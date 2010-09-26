module CopyMachine
  module ActiveRecordExtensions
    module Constraints

      def with_disabled_constraints
        disable_foreign_key_constraints
        yield
        enable_foreign_key_constraints
      end

      def disable_foreign_key_constraints
        if connection.class.name == 'ActiveRecord::ConnectionAdapters::MysqlAdapter'
          connection.execute "SET FOREIGN_KEY_CHECKS = 0"
        end
      end

      def enable_foreign_key_constraints
        if connection.class.name == 'ActiveRecord::ConnectionAdapters::MysqlAdapter'
          connection.execute "SET FOREIGN_KEY_CHECKS = 1"
        end
      end

    end
  end
end