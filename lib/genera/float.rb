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
