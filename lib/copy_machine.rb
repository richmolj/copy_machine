require 'copy_machine/autoloading'
require 'copy_machine/railtie'

module CopyMachine
  mattr_accessor :notifications
  self.notifications = []

  class << self
    def configure
      yield CopyMachine::Configuration.config
    end

    def config
      CopyMachine::Configuration.config
    end

    def growl_notification(message)
      Growl.send("notify_warning", message, {
        :title => "Copy Machine",
        :sticky => false
      })
    end
  end
end