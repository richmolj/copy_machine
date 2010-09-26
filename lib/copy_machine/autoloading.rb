module CopyMachine
  autoload :Configuration, 'copy_machine/configuration'
  autoload :Template, 'copy_machine/template'

  module ActiveRecordExtensions
    autoload :Base, 'copy_machine/active_record_extensions/base'
    autoload :Callbacks, 'copy_machine/active_record_extensions/callbacks'
    autoload :Constraints, 'copy_machine/active_record_extensions/constraints'
  end

  module ActionControllerExtensions
    autoload :Base, 'copy_machine/action_controller_extensions/base'
  end
end

module Rack
  autoload :CopyMachine, 'rack/copy_machine'
end