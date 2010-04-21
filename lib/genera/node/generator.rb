module Genera
  class Generator < Node
    def initialize(*args, &gen)
      @args = args
      @gen  = gen
    end
    
    def generate(context)
      arg_vals = @args.map { |arg| arg.generate(context) }
      context.instance_exec(*arg_vals, &@gen)
    end
  end
end
