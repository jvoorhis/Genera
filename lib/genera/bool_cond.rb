module Genera
  
  class BoolCond < Cond
    def target_type
      LLVM::Int1
    end
  end
end
