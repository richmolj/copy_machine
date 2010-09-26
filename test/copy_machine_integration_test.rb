require "helper"

def copy_machine_db
  ActiveRecord::Base.establish_connection :copy_machine
  yield
  ActiveRecord::Base.establish_connection :test
end

def mock_copy_hook(type)
  Person.expects("#{type}_copy_hook").once
  CopyMachine::Configuration.configure do |config|
    config.send("#{type}_copy") do
      Person.send("#{type}_copy_hook")
    end
  end
end

describe CopyMachine do
  before do
    copy_machine_db { Person.create }
    mock_copy_hook(:before)
    mock_copy_hook(:after)
  end

  it "should return nil when the copy machine db does not have a record" do
    copy_machine_db { Person.delete_all }
    Person.first.must_equal(nil)
  end

  it "should return a record when the copy machine db does have a record" do
    refute_nil Person.first
    Person.first # shouldnt fire the copy again
  end

  after do
    copy_machine_db { Person.delete_all }
    Person.delete_all
  end
end