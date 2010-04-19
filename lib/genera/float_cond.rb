module Genera
  
  class FloatCond < Cond
    def target_type
      LLVM::Float
    end
  end
end
