Copy Machine
============

Ever had to pull records from production to debug an issue, or had a sprawling legacy app with no seeds.rb and a need for development data? Using CopyMachine, this is fixed in two ways -  either dynamically pull data from a slave database whenever no records are found, or define dataset templates that pull in data with a rake task. Whenever a copy happens, you'll get a growl notice, a small button in the top left of your app, or both. These will contain the sql and line number that fired the copy (click the button for additional info).

The main benefits of CopyMachine are 1) No hassles and easy set up 2) Easily pull associations and 3) never fire callbacks or validations.

Install
-------

Make sure you have growl and growl_notifications set up.

**Gemfile**

    gem 'growl'
    gem 'copy_machine'

Then, add a 'copy_machine' entry to your database.yml for the alternate database you'd like to copy from.

**Console**

    rails g copy_machine_configuration
    
To create config/initializers/copy_machine.rb

As you move through your app, hits to the database that return 0 records will attempt to copy records from the :copy_machine database from database.yml

Datasets
--------

If you want to pull in specific sets of records, define a template that finds this data and run it via rake.

**console**

    rails g copy_machine_template person

Gives you a templates directory off of Rails root that contains person_template.rb. Within this file:

**Template**

    define_dataset :by_id, :needs => [:id] do
      Person.find(@id)
    end 

That you can call from rake

    rake copy:person[by_id]

You'll get prompted for the id you want to copy, and your response will set the @id instance variable. Similarly,

**templates/my_model_template.rb**

    define_dataset :foo, :needs => [:bar] do
      MyModel.find_by_bar(@bar)
    end  

Could be called by

    rake copy:my_model[foo]

Which would prompt for foo and set @foo. You can call any associations or methods you need here, just like in your app. See the comments in the generated template for more examples.

Configuration
-------------

Because apps can get funky, you may have special needs before or after the copy process takes place, or scrubbing the sql itself. There are hooks in place for this:

**config/initializers/copy_machine.rb**

    config.alter_sql do |sql|
      # scrub the sql, ie sql.gsub(/whatever/,'somethingelse')
    end

    config.before_copy do
      # your code
    end

    config.after_copy do
      # your code
    end     

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

Copyright
---------

Copyright (c) 2010 richmolj@gmail.com. See LICENSE for details.
