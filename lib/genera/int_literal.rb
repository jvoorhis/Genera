module Genera
  
  class IntLiteral < Node
    attr_reader :value
    
    def initialize(value)
      @value = value.to_i
    end
    
    def generate(context)
      LLVM::Int(@value)
    end
  end
end
