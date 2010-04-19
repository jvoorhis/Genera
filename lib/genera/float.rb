module Genera
  
  class Float
    attr_reader :node
    
    def initialize(node)
      unless node.kind_of?(Node)
        raise TypeError, "Genera::Float must constructed with an instance of Genera::Node."
      end
      
      @node = node
    end
    
    def generate(context)
      @node.generate(context)
    end
    
    def +(rhs)
      proto = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def -(rhs)
      proto = Prototype.new(:-, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def *(rhs)
      proto = Prototype.new(:*, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def /(rhs)
      proto = Prototype.new(:/, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def -@
      proto = Prototype.new(:-@, [Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node])
      Float.new(node)
    end
    
    def +@
      self
    end
    
    def %(rhs)
      proto = Prototype.new(:%, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def **(rhs)
      proto = Prototype.new(:**, [Genera::Float, Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node, rhs.node])
      Float.new(node)
    end
    
    def abs
      proto = Prototype.new(:abs, [Genera::Float], Genera::Float)
      node  = Application.new(proto, [@node])
      Float.new(node)
    end
    
    def floor
      proto = Prototype.new(:floor, [Genera::Float], Genera::Int)
      node  = Application.new(proto, [@node])
      Int.new(node)
    end
    
    def ceil
      proto = Prototype.new(:ceil, [Genera::Float], Genera::Int)
      node  = Application.new(proto, [@node])
      Int.new(node)
    end
    
    def round
      proto = Prototype.new(:round, [Genera::Float], Genera::Int)
      node  = Application.new(proto, [@node])
      Int.new(node)
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
