require File.join(File.dirname(__FILE__), 'test_helper')

class FunctionTest < Test::Unit::TestCase
  
  Add = Function.new(:add, [Int, Int], Int) { |a, b| a + b }
  
  def test_ctor
    # Invalid types are rejected
    assert_raises TypeError do
      proto = Prototype.new(:to_f, [Int], Int)
      func  = Function.new(proto, &:to_f)
    end
    
    # Functions can be constructed with a Prototype
    assert_nothing_raised do
      proto = Prototype.new(:to_f, [Int], Float)
      func  = Function.new(proto, &:to_f)
      assert_kind_of Prototype, func.prototype
      assert_equal 1, func.arity
    end
    
    # Functions can be constructed with their Prototype's arguments
    assert_nothing_raised do
      proto = Prototype.new(:to_f, [Int], Float)
      func  = Function.new(:to_f, [Int], Float, &:to_f)
      assert_equal proto, func.prototype
    end
  end
  
  def test_call
    assert_equal 4, Add.call(2, 2)
    assert_equal 4, Add.call(2.0, 2.0)
    assert_equal 4, Add.call(2, 2.00001)
    assert_raise TypeError do
      assert_equal 4, Add.call(2, Object.new)
    end
    assert_raise ArgumentError do
      Add.call(2)
    end
  end
  
  def test_to_proc
    assert_nothing_raised do
      assert_equal 6, [1,2,3].inject(0, &Add)
    end
  end
end
