module Genera
  
  class Prototype
    attr_reader :name, :arg_types, :return_type
    
    def initialize(name, arg_types, return_type)
      @name        = name
      @arg_types   = arg_types
      @return_type = return_type
    end
    
    def ==(proto)
      return false unless proto.kind_of?(Prototype)
      @name == proto.name &&
      @arg_types == proto.arg_types &&
      @return_type == proto.return_type
    end
    
    alias :eql? :==
    
    def hash
      [Prototype, @name, @arg_types, @return_type].hash
    end
    
    def to_s
      "%s : %s -> %s" % [
        @name =~ /^[a-z0-9]/i ? @name : "(%s)" % @name,
        @arg_types.join(" * "),
        @return_type
      ]
    end
  end
end
