module CopyMachine
  module ActiveRecordExtensions
    module Callbacks

      def with_disabled_callbacks
        remove_callbacks!
        yield
        resurrect_callbacks!
      end

      def remove_callbacks!
        override_callback_methods!
        callback_vars = self.instance_variables.select { |var| var =~ /callbacks/ }

        callback_vars.each do |cb|
          instance_variable_set("#{cb}_temp".to_sym, instance_variable_get("#{cb}".to_sym))
          self.send(:remove_instance_variable, "#{cb}")
        end
      end

      def callback_methods
        instance_methods.select do |im|
          [
            'before_save',
            'after_save',
            'before_create',
            'after_create'
          ].include?(im)
        end
      end

      def override_callback_methods!
        callback_methods.each do |m|
          class_eval <<-METHOD, __FILE__, __LINE__ + 1
            def #{m}_with_override; end
            alias_method_chain #{m}, :override
          METHOD
        end
      end

      def resurrect_callback_methods!
        callback_methods.each do |m|
          alias_method m, "#{m}_without_override"
        end
      end

      def resurrect_callbacks!
        resurrect_callback_methods!
        temp_callback_vars = instance_variables.select { |var| var =~ /callbacks_temp/ }

        temp_callback_vars.each do |tcb|
          instance_variable_set("#{tcb.gsub("temp", "")}".to_sym, self.instance_variable_get("#{tcb}".to_sym))
          send(:remove_instance_variable, "#{tcb}")
        end
      end

    end
  end
end