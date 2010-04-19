module Genera
  
  class Data < Node
    attr_reader :data
    
    def initialize(data)
      unless data.kind_of?(LLVM::Value)
        raise TypeError, "Genera::Data can only be constructed with an LLVM::Value."
      end
      
      @data = data
    end
    
    def generate(context)
      @data
    end
  end
end
