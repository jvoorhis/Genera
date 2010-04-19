module Genera
  
  class Application < Node
    attr_reader :prototype, :args
    
    def initialize(prototype, args)
      @prototype = prototype
      @args      = args
    end
    
    def generate(context)
      unless impl = context.primitives[@prototype]
        raise NotImplementedError, "#{@prototype} is not implemented."
      end
      arg_vals = @args.map { |arg| arg.generate(context) }
      context.instance_exec(*arg_vals, &impl)
    end
  end
end
