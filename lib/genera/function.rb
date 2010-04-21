module Genera
  
  class Function
    attr_reader :prototype
    
    def initialize(proto, &body)
      validate proto, body
      @prototype = proto
      @func      = generate(@prototype, &body)
    end
    
    def call(*args)
      Genera.runtime.run_function(self, *args)
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
    
    def validate(proto, body)
      args = proto.arg_types.map { |ty| ty.new(UNREACHABLE) }
      val = body.call(*args) rescue nil
      unless proto.return_type === val
        raise TypeError, "Expected #{proto}"
      end
    end
  end
end
