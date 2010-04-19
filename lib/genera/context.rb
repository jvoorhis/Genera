module Genera
  
  class Context
    attr_reader :primitives, :module, :function, :builder
    
    def initialize(primitives, mod, func, builder)
      @primitives = primitives
      @module     = mod
      @function   = func
      @builder    = builder
    end
  end
end
