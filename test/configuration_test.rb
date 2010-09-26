require 'helper'
require 'rails'
              
describe CopyMachine::Configuration do
  before do
    @config = CopyMachine::Configuration.config
    @proc = Proc.new { puts 'foo '}
  end

  it "should add procs to the before_copy_hooks array when configuring before_copy hooks" do
    @config.before_copy &@proc
    refute_nil @config.before_copy_hook
  end

  it "should add procs to the after_copy_hooks array when configuring after_copy hooks" do
    @config.after_copy &@proc
    refute_nil @config.after_copy_hook
  end

  it "should assign to sql_alteration cattr_accessor when configuring sql alteration hook" do
    @config.alter_sql &@proc
    refute_nil @config.sql_alteration
  end
  
  after do
    @config.clear
  end
end