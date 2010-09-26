class <%= class_name %>Template < CopyMachine::Template
  
  define_dataset :<%= dataset_name %>, :needs => [:id] do
    <%- if dataset_name == 'by_id' -%>
    <%= class_name %>.find(@id)
    <%- end -%>
  end
  
  # Here you can define steps to copy your objects and their associations.
  #
  # The name of the template should reflect your model, ie ExampleTemplate for Example < ActiveRecord::Base.
  #
  # Rake will prompt you for each off the :needs array, and make each an instance variable, ie :needs => [:foo] gives you @foo
  #
  # To call these templates: rake db:class_name[dataset_name] ie rake db:example[by_name]
  #
  # Simple example.
  #
  # define_dataset :by_name, :needs => [:name] do
  #   example = Example.find_by_name(@name)
  #   example
  #   example.association
  #   
  #   example
  # end 
  
  # Multi-dataset example
  #
  # define_dataset :multi, :needs => [:name] do
  #   gimme "example" do |example|
  #     if example.something?
  #       example.something
  #     else
  #       example.something_else
  #     end
  #   end
  # end
  
end