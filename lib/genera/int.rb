module Genera
  
  class Int
    attr_reader :node
    
    def initialize(node)
      unless node.kind_of?(Node)
        raise TypeError, "Genera::Int must constructed with an instance of Genera::Node."
      end
      
      @node = node
    end
    
    def generate(context)
      @node.generate(context)
    end
    
    def +(rhs)
      proto = Prototype.new(:+, [Int, Int], Int) 
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def -(rhs)
      proto = Prototype.new(:-, [Int, Int], Int)
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def *(rhs)
      proto = Prototype.new(:*, [Int, Int], Int)
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def /(rhs)
      proto = Prototype.new(:/, [Int, Int], Int)
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def -@
      proto = Prototype.new(:-@, [Int], Int)
      node  = Application.new(proto, [@node])
      Int.new(node)
    end
    
    def +@
      self
    end
    
    def %(rhs)
      proto = Prototype.new(:%, [Int, Int], Int)
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def **(rhs)
      proto = Prototype.new(:**, [Int, Int], Int)
      node  = Application.new(proto, [@node, rhs.node])
      Int.new(node)
    end
    
    def to_f
      proto = Prototype.new(:to_f, [Int], Float)
      node  = Application.new(proto, [@node])
      Float.new(node)
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
