require File.join(File.dirname(__FILE__), 'test_helper')

class FloatTest < Test::Unit::TestCase
  include Genera
  
  def test_Float
    flt = Genera.Float(1.0)
    assert_kind_of Float, flt
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
  end
  
  def test_subtraction
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    difference = lhs - rhs
    assert_kind_of Float, difference
  end
  
  def test_multiplication
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    product = lhs * rhs
    assert_kind_of Float, product
  end
  
  def test_division
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    quotient = lhs / rhs
    assert_kind_of Float, quotient
  end
  
  def test_negation
    flt = Genera.Float(1.0)
    neg = -flt
    assert_kind_of Float, neg
  end
  
  def test_modulo
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    mod = lhs % rhs
    assert_kind_of Float, mod
  end
  
  def test_exponentiaiton
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    pow = lhs ** rhs
    assert_kind_of Float, pow
  end
  
  def test_abs
    flt = Genera.Float(1.0)
    abs = flt.abs
    assert_kind_of Float, abs
  end
  
  def test_floor
    flt = Genera.Float(1.5)
    floor = flt.floor
    assert_kind_of Genera::Int, floor
  end
  
  def test_ceil
    flt = Genera.Float(1.5)
    ceil = flt.ceil
    assert_kind_of Genera::Int, ceil
  end
  
  def test_round
    flt = Genera.Float(1.5)
    int = flt.round
    assert_kind_of Genera::Int, int
  end
end
