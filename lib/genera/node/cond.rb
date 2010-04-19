module Genera
  
  class Cond < Node
    attr_reader :condition, :consequent, :alternative
    
    def initialize(condition, consequent, alternative)
      @condition   = condition
      @consequent  = consequent
      @alternative = alternative
    end
    
    def generate(context)
      consequent_block  = context.function.basic_blocks.append("consequent")
      alternative_block = context.function.basic_blocks.append("alternative")
      merge_block       = context.function.basic_blocks.append("merge")
      
      condition_value = context.builder.icmp(:eq, LLVM::Int1.from_i(1),
                                             @condition.generate(context))
      context.builder.cond(condition_value, consequent_block, alternative_block)
      
      context.builder.position_at_end(consequent_block)
      consequent_value = @consequent.generate(context)
      context.builder.br(merge_block)
      
      context.builder.position_at_end(alternative_block)
      alternative_value = @alternative.generate(context)
      context.builder.br(merge_block)
      
      context.builder.position_at_end(merge_block)
      context.builder.phi(target_type,
                          consequent_value, consequent_block,
                          alternative_value, alternative_block)
    end
    
    def target_type
      raise NotImplementedError, "Genera::Cond#target_type is abstract."
    end
  end
end
