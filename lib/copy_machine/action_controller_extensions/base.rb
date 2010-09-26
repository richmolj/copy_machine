module CopyMachine
  module ActionControllerExtensions
    module Base

      def self.included(klass)
        klass.before_filter :reset_copy_machine
      end

      def reset_copy_machine
        ::CopyMachine.notifications = []
      end

    end
  end
end