module Genera
  
  class Int
    attr_reader :node
    
    def initialize(node)
      unless node.kind_of?(Node)
        raise TypeError, "Genera::Int must constructed with an instance of Genera::Node."
      end
      
      @node = node
    end
    
    def self.target_type
      LLVM::Int
    end
    
    def generate(context)
      @node.generate(context)
    end
    
    def coerce(other)
      [Genera.Int(other), self]
    end

    def +(rhs)
      Int.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.add(lhs, rhs)
      })
    end
    
    def -(rhs)
      Int.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.sub(lhs, rhs)
      })
    end
    
    def *(rhs)
      Int.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.mul(lhs, rhs)
      })
    end
    
    def /(rhs)
      Int.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.sdiv(lhs, rhs)
      })
    end
    
    def -@
      Int.new(Generator.new(self) { |x|
        builder.sub(LLVM::Int(0), x)
      })
    end
    
    def +@
      self
    end
    
    def %(rhs)
      Int.new(Generator.new(self, rhs) { |a, b|
        builder.srem(a, b)
      })
    end
    
    def to_f
      Float.new(Generator.new(self) { |x|
        builder.si2fp(x, LLVM::Float)
      })
    end
  end
  
  def Int(value)
    if value.kind_of?(Int)
      value
    else
      Int.new(IntLiteral.new(value))
    end
  end
  module_function :Int
end
