class CopyMachineConfiguration < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)

  def create_initializer_file
    copy_file "copy_machine.rb", "config/initializers/copy_machine.rb"
  end
end