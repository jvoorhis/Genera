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
    assert_kind_of Application, sum.node
    proto = Prototype.new(:+, [Float, Float], Float)
    assert_equal proto, sum.node.prototype
  end
  
  def test_subtraction
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    difference = lhs - rhs
    assert_kind_of Float, difference
    assert_kind_of Application, difference.node
    proto = Prototype.new(:-, [Float, Float], Float)
    assert_equal proto, difference.node.prototype
  end
  
  def test_multiplication
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    product = lhs * rhs
    assert_kind_of Float, product
    assert_kind_of Application, product.node
    proto = Prototype.new(:*, [Float, Float], Float)
    assert_equal proto, product.node.prototype
  end
  
  def test_division
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    quotient = lhs / rhs
    assert_kind_of Float, quotient
    assert_kind_of Application, quotient.node
    proto = Prototype.new(:/, [Float, Float], Float)
    assert_equal proto, quotient.node.prototype
  end
  
  def test_negation
    flt = Genera.Float(1.0)
    neg = -flt
    assert_kind_of Float, neg
    assert_kind_of Application, neg.node
    proto = Prototype.new(:-@, [Float], Float)
    assert_equal proto, neg.node.prototype
  end
  
  def test_modulo
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    mod = lhs % rhs
    assert_kind_of Float, mod
    assert_kind_of Application, mod.node
    proto = Prototype.new(:%, [Float, Float], Float)
    assert_equal proto, mod.node.prototype
  end
  
  def test_exponentiaiton
    lhs = Genera.Float(1.0)
    rhs = Genera.Float(2.0)
    pow = lhs ** rhs
    assert_kind_of Float, pow
    assert_kind_of Application, pow.node
    proto = Prototype.new(:**, [Float, Float], Float)
    assert_equal proto, pow.node.prototype
  end
  
  def test_abs
    flt = Genera.Float(1.0)
    abs = flt.abs
    assert_kind_of Float, abs
    assert_kind_of Application, abs.node
    proto = Prototype.new(:abs, [Float], Float)
    assert_equal proto, abs.node.prototype
  end
  
  def test_floor
    flt = Genera.Float(1.5)
    floor = flt.floor
    assert_kind_of Genera::Int, floor
    assert_kind_of Application, floor.node
    proto = Prototype.new(:floor, [Float], Int)
    assert_equal proto, floor.node.prototype
  end
  
  def test_ceil
    flt = Genera.Float(1.5)
    ceil = flt.ceil
    assert_kind_of Genera::Int, ceil
    assert_kind_of Application, ceil.node
    proto = Prototype.new(:ceil, [Float], Int)
    assert_equal proto, ceil.node.prototype
  end
  
  def test_round
    flt = Genera.Float(1.5)
    int = flt.round
    assert_kind_of Genera::Int, int
    assert_kind_of Application, int.node
    proto = Prototype.new(:round, [Float], Int)
    assert_equal proto, int.node.prototype
  end
end
