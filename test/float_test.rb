require File.join(File.dirname(__FILE__), 'test_helper')

class FloatTest < Test::Unit::TestCase
  
  ERROR = 0.1e-4
  
  def test_Float
    flt = Genera.Float(1.0)
    assert_kind_of Float, flt
    assert_kind_of FloatLiteral, flt.node
  end
  
  def test_coerce
    assert_floating_op "Fixnum coercion" do |x|
      1 + x
    end
    
    assert_floating_op "Float coercion" do |x|
      1.0 + x            
    end
  end

  def test_generate
    flt = Genera.Float(1.0)
    context = test_context
    val = flt.generate(context)
    assert_kind_of LLVM::Float, val
  end
  
  def test_addition
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    sum = lhs + rhs
    assert_kind_of Float, sum
    
    assert_floating_op "addition" do |a, b|
      a + b
    end
  end
  
  def test_subtraction
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    difference = lhs - rhs
    assert_kind_of Float, difference
    
    assert_floating_op "subtraction" do |a, b|
      a - b
    end
  end
  
  def test_division
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    quotient = lhs / rhs
    assert_kind_of Float, quotient
    
    assert_floating_op "division" do |a, b|
      a / b
    end
  end
  
  def test_negation
    flt = Genera.Float(1.0)
    neg = -flt
    assert_kind_of Float, neg
    
    assert_floating_op "negation" do |x|
      -x
    end
  end
  
  def test_modulo
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    mod = lhs % rhs
    assert_kind_of Float, mod
    
    assert_floating_op "modulo" do |a, b|
      a % b
    end
  end
  
  def test_exponentiaiton
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    pow = lhs ** rhs
    assert_kind_of Float, pow
    
    assert_floating_op "exponentiation" do |a, b|
      a ** b
    end
  end
  
  def test_abs
    flt = Genera.Float(1.0)
    abs = flt.abs
    assert_kind_of Float, abs
    
    assert_floating_op "abs" do |x|
      x.abs
    end
  end
  
  def test_floor
    flt = Genera.Float(1.5)
    floor = flt.floor
    assert_kind_of Genera::Int, floor
    
    func = Function.new("floor", [Float], Int) { |x| x.floor }
    x = rand
    assert_equal x.floor, func.call(x)
  end
  
  def test_ceil
    flt = Genera.Float(1.5)
    ceil = flt.ceil
    assert_kind_of Genera::Int, ceil
    
    func = Function.new("ceil", [Float], Int) { |x| x.ceil }
    x = rand
    assert_equal x.ceil, func.call(x)
  end
  
  def test_round
    flt = Genera.Float(1.5)
    int = flt.round
    assert_kind_of Genera::Int, int
    
    func = Function.new("round", [Float], Int) { |x| x.round }
    x = rand
    assert_equal x.round, func.call(x)
  end
  
  def test_eq
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x == y

    func = Function.new("eq", [Float, Float], Bool) { |x, y| x == y }
    assert_equal true, func.call(1.0, 1.0)
  end

  def test_ne
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x != y

    func = Function.new("eq", [Float, Float], Bool) { |x, y| x != y }
    assert_equal false, func.call(1.0, 1.0)
  end

  def test_gt
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x > y
    
    assert_floating_pred "gt" do |x, y|
      x > y
    end
  end

  def test_lt
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x < y

    assert_floating_pred "lt" do |x, y|
      x < y
    end
  end

  def test_gte
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x >= y

    assert_floating_pred "gte" do |x, y|
      x >= y
    end
  end

  def test_lte
    x = Genera.Float(1.0)
    y = Genera.Float(1.0)
    assert_kind_of Genera::Bool, x <= y

    assert_floating_pred "lte" do |x, y|
      x <= y
    end
  end

  def assert_floating_op(name, &block)
    arg_types = Array.new(block.arity) { Genera::Float }
    ret_type = Genera::Float
    func = Function.new(name, arg_types, ret_type, &block)

    args = Array.new(block.arity) { rand }
    assert_relative_error block.call(*args), func.call(*args), ERROR
  end
  
  def assert_floating_pred(name, &block)
    arg_types = Array.new(block.arity) { Genera::Float }
    ret_type = Genera::Bool
    func = Function.new(name, arg_types, ret_type, &block)

    args = Array.new(block.arity) { rand }
    assert_equal block.call(*args), func.call(*args)
  end

  # Implementation of relative floating point error, as described at
  # http://www.cygnus-software.com/papers/comparingfloats/comparingfloats.htm
  def assert_relative_error(expected, actual, tolerance, message = nil)
    if expected == actual
      error = 0.0
    elsif expected.abs > actual.abs
      error = ((expected - actual) / expected.to_f).abs
    else
      error = ((expected - actual) / actual.to_f).abs
    end
    message ||= "Expected relative error between %e and %e to be within %e." % [expected, actual, tolerance]
    assert (expected - actual).abs < tolerance || error < tolerance, message
  end
end
