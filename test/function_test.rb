require File.join(File.dirname(__FILE__), 'test_helper')

class FunctionTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    proto = Prototype.new(:add, [Float, Float], Float)
    func  = Function.new(proto, &:+)
    assert_kind_of Prototype, func.prototype
  end
  
  def test_validation
    assert_raises TypeError do
      proto = Prototype.new(:to_f, [Int], Int)
      func  = Function.new(proto, &:to_f)
    end
    
    assert_nothing_raised do
      proto = Prototype.new(:to_f, [Int], Float)
      func  = Function.new(proto, &:to_f)
    end
  end
end
