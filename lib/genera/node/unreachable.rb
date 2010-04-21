module Genera

  class Unreachable < Node
    def generate(context)
      raise "Unreachable!"
    end
  end
  
  UNREACHABLE = Unreachable.new
end
