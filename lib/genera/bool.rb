module Genera
  
  class Bool
    attr_reader :node
    
    def initialize(node)
      unless node.kind_of?(Node)
        raise TypeError, "Genera::Bool must be constructed with an instance of Genera::Node."
      end
      
      @node = node
    end
    
    def self.target_type
      LLVM::Int1
    end
    
    def generate(context)
      @node.generate(context)
    end
    
    def self.true
      BoolLiteral.true
    end
    
    def self.false
      BoolLiteral.false
    end
    
    def !@
      Bool.new(Generator.new(self) { |b|
        builder.not(b)
      })
    end
    
    def &(rhs)
      Bool.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.and(lhs, rhs)
      })
    end
    
    def |(rhs)
      Bool.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.or(lhs, rhs)
      })
    end
    
    def ^(rhs)
      Bool.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.xor(lhs, rhs)
      })
    end
  end
  
  def Bool(value)
    if value.kind_of?(Genera::Bool)
      value
    else
      Bool.new(BoolLiteral.new(value))
    end
  end
  module_function :Bool
end
