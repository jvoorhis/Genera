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
  end
  
  def test_subtraction
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    difference = lhs - rhs
    assert_kind_of Int, difference
  end
  
  def test_multiplication
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    product = lhs * rhs
    assert_kind_of Int, product
  end
  
  def test_division
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    quotient = lhs / rhs
    assert_kind_of Int, quotient
  end
  
  def test_negation
    int = Genera.Int(1)
    neg = -int
    assert_kind_of Int, neg
  end
  
  def test_modulo
    lhs = Genera.Int(4)
    rhs = Genera.Int(5)
    mod = lhs % rhs
    assert_kind_of Int, mod
  end
  
  def test_to_f
    int = Genera.Int(1)
    flt = int.to_f
    assert_kind_of Float, flt
  end
end
