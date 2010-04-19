module Genera
  
  class IntCond < Cond
    def target_type
      LLVM::Int
    end
  end
end
