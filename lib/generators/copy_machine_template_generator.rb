class CopyMachineTemplate < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)
  argument :dataset_name, :type => :string, :default => "by_id"

  def create_template_file
    FileUtils.mkdir_p 'templates' unless File.directory? 'templates'
  
    template "example_template.rb", "templates/#{file_name}_template.rb"
  end
end  
