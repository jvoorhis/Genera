module Genera
  
  class Runtime
    attr_reader :module
    
    def initialize
      LLVM.init_x86
      @module = LLVM::Module.create("Genera")
      mp = LLVM::ModuleProvider.for_existing_module(@module)
      @ee = LLVM::ExecutionEngine.create_jit_compiler(mp)
    end
    
    def run_function(func, *args)
      gvs = args.zip(func.prototype.arg_types).map do |arg, ty|
        if Float == ty
          LLVM::GenericValue.from_f(arg)
        elsif Int == ty
          LLVM::GenericValue.from_i(arg)
        else
          raise ArgumentError, "Unsupported type #{ty}."
        end
      end
      
      gvout = @ee.run_function(func, *gvs)
      
      retty = func.prototype.return_type
      if Genera::Float == retty
        gvout.to_f
      elsif Int == retty
        gvout.to_i
      else
        raise ArgumentError, "Unsupported type #{retty}."
      end
    end
  end
  
  def runtime
    if @runtime
      @runtime
    else
      @runtime = Runtime.new
    end
  end
  
  module_function :runtime
end
