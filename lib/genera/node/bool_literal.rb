module Genera
  
  class BoolLiteral < Node
    attr_reader :value
    
    def self.true
      new(1)
    end
    
    def self.false
      new(0)
    end
    
    def initialize(value)
      @value = value.to_i.zero? ? 0 : 1
    end
    
    def generate(context)
      LLVM::Int1.from_i(@value)
    end
  end
end
