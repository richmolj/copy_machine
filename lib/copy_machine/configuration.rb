class CopyMachine::Configuration
  include ActiveSupport::Configurable

  config.notifiers = []

  class << config
    [:before_copy, :after_copy].each do |m|
      class_eval %{
        def #{m}(&blk)
          send("#{m}_hook=", blk)
        end
      }
    end
    
    def alter_sql(&blk)
      self.sql_alteration = blk
    end
  end

end