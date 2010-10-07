# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{copy_machine}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Lee Richmond"]
  s.date = %q{2010-10-07}
  s.description = %q{For sprawling legacy apps, seeds.rb and fixtures are sometimes not enough. Copy machine eases development by copying records from a slave database as you move through your app, or as you execute predefined templates}
  s.email = %q{richmolj@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.md"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.md",
     "Rakefile",
     "VERSION",
     "copy_machine.gemspec",
     "lib/copy_machine.rb",
     "lib/copy_machine/action_controller_extensions/base.rb",
     "lib/copy_machine/active_record_extensions/base.rb",
     "lib/copy_machine/active_record_extensions/callbacks.rb",
     "lib/copy_machine/active_record_extensions/constraints.rb",
     "lib/copy_machine/autoloading.rb",
     "lib/copy_machine/configuration.rb",
     "lib/copy_machine/railtie.rb",
     "lib/copy_machine/template.rb",
     "lib/generators/copy_machine_configuration_generator.rb",
     "lib/generators/copy_machine_template_generator.rb",
     "lib/generators/templates/copy_machine.rb",
     "lib/generators/templates/example_template.rb",
     "lib/rack/copy_machine.rb",
     "lib/rack/copy_machine/asset_server.rb",
     "lib/rack/copy_machine/public/__rack_copy_machine__/copy_machine.css",
     "lib/rack/copy_machine/public/__rack_copy_machine__/copy_machine.js",
     "lib/rack/copy_machine/public/__rack_copy_machine__/jquery-1.4.2.min.js",
     "lib/rack/views/notifications.html.erb",
     "test/configuration_test.rb",
     "test/copy_machine_integration_test.rb",
     "test/database.yml",
     "test/helper.rb"
  ]
  s.homepage = %q{http://github.com/richmolj/copy_machine}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Easily copy production or slave records into your development database}
  s.test_files = [
    "test/configuration_test.rb",
     "test/copy_machine_integration_test.rb",
     "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<growl>, [">= 0"])
      s.add_development_dependency(%q<minitest>, [">= 0"])
    else
      s.add_dependency(%q<growl>, [">= 0"])
      s.add_dependency(%q<minitest>, [">= 0"])
    end
  else
    s.add_dependency(%q<growl>, [">= 0"])
    s.add_dependency(%q<minitest>, [">= 0"])
  end
end

