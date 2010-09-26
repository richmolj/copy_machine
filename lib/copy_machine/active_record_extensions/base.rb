module CopyMachine
  module ActiveRecordExtensions
    module Base

      def self.included(klass)
        klass.extend CopyMachine::ActiveRecordExtensions::Callbacks
        klass.extend CopyMachine::ActiveRecordExtensions::Constraints

        klass.extend ClassMethods
        klass.singleton_class.alias_method_chain :find_by_sql, :override
      end

      module ClassMethods
        def with_alternate_connection(sql, backtrace)
          ActiveSupport::Notifications.instrument("copy_machine.sql",
            :sql => sql, :name => self.name, :backtrace => backtrace) do

            ActiveRecord::Base.establish_connection :copy_machine
            yield
            ActiveRecord::Base.establish_connection Rails.env
          end
        end

        def find_by_sql_with_override(sql)
          records = find_by_sql_without_override(sql)
          
          if records.empty? and !@avoid_copy
            backtrace = Rails.backtrace_cleaner.clean(caller).first
            backtrace = backtrace.split(':')[0..1].join(":") unless backtrace.nil?

            copy_mode(sql, backtrace) do
              unless (proc = CopyMachine.config.sql_alteration).nil?
                sql = proc.call(sql)
              end
              records = find_by_sql_without_override(sql)
            end

            records.each { |r| cp r }
          end

          records
        end

        private

        def cp(record)
          record.class.reset_column_information
          attrs         = build_copy_attributes(record)
          new_record    = new(attrs)
          new_record.id = record.id # have to set here or will be nil

          @avoid_copy = true
          new_record.save(:validate => false) unless exists?(new_record.id)
          @avoid_copy = false
          new_record
        end

        # TODO: obscurity logic here
        def build_copy_attributes(record)
          record.attributes.reject { |k,v| !record.class.column_names.include?(k) }
        end

        def copy_mode(sql, backtrace)
          with_alternate_connection(sql, backtrace) do
            hook = CopyMachine.config.before_copy_hook
            instance_eval &hook unless hook.nil?

            yield

            hook = CopyMachine.config.after_copy_hook
            instance_eval &hook unless hook.nil?
          end
        end

      end

    end
  end
end