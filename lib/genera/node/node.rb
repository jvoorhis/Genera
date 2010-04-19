module Genera
  
  class Node
    def generate(context)
      raise NotImplementedError, "Genera::Node#generate is abstract"
    end
  end
end
