class CopyMachine::Template
  
  class << self
    
    def find_by_name(name)
      datasets.select { |hash| hash[:name] == name }.first
    end
    
    def datasets
      @datasets ||= []
    end
    
    def define_dataset(name, opts, &blk)
      datasets << { :name => name, :needs => opts[:needs], :proc => blk }
      self
    end
    
  end
  
end