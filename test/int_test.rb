require File.join(File.dirname(__FILE__), 'test_helper')

class IntTest < Test::Unit::TestCase
  
  def test_Int
    int = Genera.Int(1)
    assert_kind_of Int, int
  end
  
  def test_generate
    int = Genera.Int(1)
    context = test_context
    val = int.generate(context)
    assert_kind_of LLVM::Int, val
  end
  
  def test_addition
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    sum = lhs + rhs
    assert_kind_of Int, sum
    
    assert_int_op "addition" do |a, b|
      a + b
    end
  end
  
  def test_subtraction
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    difference = lhs - rhs
    assert_kind_of Int, difference
    
    assert_int_op "subtraction" do |a, b|
      a - b
    end
  end
  
  def test_multiplication
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    product = lhs * rhs
    assert_kind_of Int, product
    
    assert_int_op "multiplication" do |a, b|
      a * b
    end
  end
  
  def test_division
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    quotient = lhs / rhs
    assert_kind_of Int, quotient
    
    assert_int_op "division" do |a, b|
      a / b
    end
  end
  
  def test_negation
    int = Genera.Int(1)
    neg = -int
    assert_kind_of Int, neg
    
    assert_int_op "negation" do |x|
      -x
    end
  end
  
  def test_modulo
    lhs = Genera.Int(4)
    rhs = Genera.Int(5)
    mod = lhs % rhs
    assert_kind_of Int, mod
    
    assert_int_op "modulo" do |a, b|
      a % b
    end
  end
  
  def test_to_f
    int = Genera.Int(1)
    flt = int.to_f
    assert_kind_of Float, flt
    
    func = Function.new("to_f", [Int], Float) { |x| x.to_f }
    x = rand(1000)
    assert_equal x.to_f, func.call(x)
  end
  
  def assert_int_op(name, &block)
    arg_types = Array.new(block.arity) { Genera::Int }
    ret_type = Genera::Int
    func = Function.new(name, arg_types, ret_type, &block)
    
    # TODO: use native max bound?
    args = Array.new(block.arity) { rand(1000) }
    assert_equal block.call(*args), func.call(*args)
  end
end
