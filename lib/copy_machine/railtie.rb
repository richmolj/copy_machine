require 'growl'

module CopyMachine
  class Railtie < Rails::Railtie

    initializer "copy_machine.insert_rack_middleware", :after => :load_config_initializers do |app|
      if CopyMachine.config.notifiers.include?('middleware')
        app.config.middleware.use Rack::CopyMachine
      end
    end

    initializer "copy_machine.reset_after_request" do |app|
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, CopyMachine::ActionControllerExtensions::Base)
      end
    end

    initializer 'copy_machine.initialize' do |app|
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, CopyMachine::ActiveRecordExtensions::Base)
      end

      unless CopyMachine.config.notifiers.empty?
        ActiveSupport::Notifications.subscribe(/copy_machine/) do |*args|
          event = ActiveSupport::Notifications::Event.new(*args)
          payload = event.payload

          sql = payload[:sql].is_a?(Array) ? payload[:sql][0] : payload[:sql]
          sql.squeeze!(' ')
          backtrace = payload[:backtrace]

          message = [
            "Attempting to copy an instance of #{payload[:name]}",
            backtrace,
            sql
          ].join("\n\n")

          CopyMachine.notifications << {:sql => sql, :backtrace => backtrace}
          CopyMachine.growl_notification(message) if CopyMachine.config.notifiers.include?('growl')
        end
      end
    end
    
    # TODO: clean up
    rake_tasks do
      desc "copy objects using a template"
      namespace :copy do
        Dir.glob("#{Rails.root}/templates/*.rb").each do |f|
          name = File.basename(f, '_template.rb')
          task name.to_sym, :dataset_name, :needs => [:environment] do |t, args|
            dataset_name = args[:dataset_name].to_sym
            require f
            dataset = "#{name.classify}Template".constantize.find_by_name(dataset_name)
            dataset[:needs].each do |need|
              puts "Set the #{need}:"
              ActiveRecord::Base.instance_variable_set("@#{need}", $stdin.gets.chomp)
            end
            ActiveRecord::Base.instance_eval(&dataset[:proc])
          end
        end
      end 
    end

  end
end