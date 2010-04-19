module Genera
  
  class Context
    attr_reader :module, :function, :builder
    
    def initialize(mod, func, builder)
      @module, @function, @builder = mod, func, builder
    end
  end
end
