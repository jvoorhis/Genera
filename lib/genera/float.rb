module Genera
  
  class Float
    attr_reader :node
    
    def initialize(node)
      unless node.kind_of?(Node)
        raise TypeError, "Genera::Float must constructed with an instance of Genera::Node."
      end
      
      @node = node
    end
    
    def self.target_type
      LLVM::Float
    end
    
    def generate(context)
      @node.generate(context)
    end
    
    def +(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.fadd(lhs, rhs)
      })
    end
    
    def -(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.fsub(lhs, rhs)
      })
    end
    
    def *(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.fmul(lhs, rhs)
      })
    end
    
    def /(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.fdiv(lhs, rhs)
      })
    end
    
    def -@
      Float.new(Generator.new(self) { |x|
        builder.fsub(LLVM::Float(0), x)
      })
    end
    
    def +@
      self
    end
    
    def %(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.call(self.module.functions[:fmod], lhs, rhs)
      })
    end
    
    def **(rhs)
      Float.new(Generator.new(self, rhs) { |lhs, rhs|
        builder.call(self.module.functions[:powf], lhs, rhs)
      })
    end
    
    def abs
      Float.new(Generator.new(self) { |x|
        builder.call(self.module.functions[:abs], x)
      })
    end
    
    def floor
      Int.new(Generator.new(self) { |x|
        builder.fp2si(x, LLVM::Int)
      })
    end
    
    def ceil
      Int.new(Generator.new(self) { |x|
        i = builder.fp2si(x, LLVM::Int)
        builder.add(i, LLVM::Int(1))
      })
    end
    
    def round
      Int.new(Generator.new(self) { |x|
        f = builder.call(self.module.functions[:roundf], x)
        builder.fp2si(f, LLVM::Int)
      })
    end
    
    alias :to_i :floor
    
    def to_f
      self
    end
  end
  
  def Float(value)
    if value.kind_of?(Genera::Float)
      value
    else
      Float.new(FloatLiteral.new(value))
    end
  end
  module_function :Float
end
