require 'rubygems'
require 'bundler'

Bundler.setup
require 'minitest/spec'

begin
  require 'redgreen'
rescue LoadError
end

require 'mocha'

# Configure Rails
ENV["RAILS_ENV"] = "test"

require 'active_record'
# require 'active_support'
# require 'action_controller'
# require 'active_model'
# require 'rails/railtie'
require 'rails'

config = YAML::load(IO.read(File.dirname(__FILE__) + '/database.yml'))

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'copy_machine'

ActiveRecord::Base.configurations =
{
  'test' => {
    'adapter'  => 'mysql',
    'database' => 'copy_machine_test'
  },
  'copy_machine' => {
    'adapter'  => 'mysql',
    'database' => 'copy_machine_slave_test'
  }
}

ActiveRecord::Migration.verbose = false

ActiveRecord::Base.send(:include, CopyMachine::ActiveRecordExtensions::Base)

class Person < ActiveRecord::Base; end

class Migrator
  def self.migrate
    ActiveRecord::Schema.define do
      create_table :people, :force => true do |t|
        t.string :name
      end
    end
  end
end

ActiveRecord::Base.establish_connection :copy_machine
Migrator.migrate
ActiveRecord::Base.establish_connection :test
Migrator.migrate

MiniTest::Unit.autorun