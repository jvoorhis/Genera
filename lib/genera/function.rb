module Genera
  
  class Function
    attr_reader :prototype
    
    def initialize(*args, &body)
      if args.first.kind_of?(Prototype)
        proto = args.first
      else
        proto = Prototype.new(*args)
      end
      validate(proto, body)
      @prototype = proto
      @func      = generate(@prototype, &body)
    end
    
    def arity
      @prototype.arity
    end
    
    def call(*args)
      Genera.runtime.run_function(self, *args)
    end
    
    def to_proc
      @proc ||= Proc.new { |*args| call(*args) }
    end
    
    def to_ptr
      @func.to_ptr
    end
    
    private
    
    def generate(proto)
      mod = Genera.runtime.module
      func = mod.functions.add(proto.name, proto.target_type)
      entry = func.basic_blocks.append("entry")
      builder = LLVM::Builder.create
      begin
        builder.position_at_end(entry)
        context = Context.new(mod, func, builder)
        args = func.params.zip(proto.arg_types).map { |arg, ty|
          ty.new(Data.new(arg))
        }
        value = yield(*args).generate(context)
        context.builder.ret(value)
        return func
      ensure
        builder.dispose
      end
    end
    
    def validate(proto, body)
      args = proto.arg_types.map { |ty| ty.new(UNREACHABLE) }
      val = body.call(*args)
      unless val.kind_of?(proto.return_type)
        raise TypeError, "Expected #{proto.return_type} but got #{val.class}."
      end
    end
  end
end
