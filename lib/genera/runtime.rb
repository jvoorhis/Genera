module Genera
  
  class Runtime
    attr_reader :module
    
    def initialize
      LLVM.init_x86
      @module = LLVM::Module.create("Genera")
      mp = LLVM::ModuleProvider.for_existing_module(@module)
      @ee = LLVM::ExecutionEngine.create_jit_compiler(mp)
      
      declare_functions!
    end
    
    def run_function(func, *args)
      unless args.size == func.arity
        raise ArgumentError, "#{args.size} arguments given for arity #{func.arity}."
      end
      
      gvs = args.zip(func.prototype.arg_types).map do |arg, ty|
        if Float == ty
          raise TypeError, "Expected a Float, got #{arg}." unless arg.respond_to?(:to_f)
          LLVM::GenericValue.from_f(arg.to_f)
        elsif Int == ty
          raise TypeError, "Expected an Int, got #{arg}." unless arg.respond_to?(:to_i)
          LLVM::GenericValue.from_i(arg.to_i)
        else
          raise ArgumentError, "Unsupported type #{ty}."
        end
      end
      
      gvout = @ee.run_function(func, *gvs)
      
      ret_type = func.prototype.return_type
      if Genera::Float == ret_type
        gvout.to_f
      elsif Int == ret_type
        gvout.to_i
      else
        raise ArgumentError, "Unsupported type #{ret_type}."
      end
    end
    
    private
    
    def declare_functions!
      @module.functions.add(:fmod, LLVM::Function([LLVM::Float, LLVM::Float], LLVM::Float))
      @module.functions.add(:powf, LLVM::Function([LLVM::Float, LLVM::Float], LLVM::Float))
      @module.functions.add(:abs, LLVM::Function([LLVM::Float], LLVM::Float))
      @module.functions.add(:roundf, LLVM::Function([LLVM::Float], LLVM::Float))
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
