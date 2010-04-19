module Genera
  
  class FloatLiteral < Node
    attr_reader :value
    
    def initialize(value)
      @value = value.to_f
    end
    
    def generate(context)
      LLVM::Float(@value)
    end
  end
end
