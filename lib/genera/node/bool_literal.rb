module Genera
  
  class BoolLiteral < Node
    attr_reader :value
    
    def self.true
      new(true)
    end
    
    def self.false
      new(false)
    end
    
    def initialize(value)
      @value = value ? 1 : 0
    end
    
    def generate(context)
      LLVM::Int1.from_i(@value)
    end
  end
end
