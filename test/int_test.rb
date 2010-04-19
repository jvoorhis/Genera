require File.join(File.dirname(__FILE__), 'test_helper')

class IntTest < Test::Unit::TestCase
  include Genera
  
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
    assert_kind_of Application, sum.node
    proto = Prototype.new(:+, [Int, Int], Int)
    assert_equal proto, sum.node.prototype
  end
  
  def test_subtraction
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    difference = lhs - rhs
    assert_kind_of Int, difference
    assert_kind_of Application, difference.node
    proto = Prototype.new(:-, [Int, Int], Int)
    assert_equal proto, difference.node.prototype
  end
  
  def test_multiplication
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    product = lhs * rhs
    assert_kind_of Int, product
    assert_kind_of Application, product.node
    proto = Prototype.new(:*, [Int, Int], Int)
    assert_equal proto, product.node.prototype
  end
  
  def test_division
    lhs = Genera.Int(1.0)
    rhs = Genera.Int(2.0)
    quotient = lhs / rhs
    assert_kind_of Int, quotient
    assert_kind_of Application, quotient.node
    proto = Prototype.new(:/, [Int, Int], Int)
    assert_equal proto, quotient.node.prototype
  end
  
  def test_negation
    int = Genera.Int(1)
    neg = -int
    assert_kind_of Int, neg
    assert_kind_of Application, neg.node
    proto = Prototype.new(:-@, [Int], Int)
    assert_equal proto, neg.node.prototype
  end
  
  def test_modulo
    lhs = Genera.Int(4)
    rhs = Genera.Int(5)
    mod = lhs % rhs
    assert_kind_of Int, mod
    assert_kind_of Application, mod.node
    proto = Prototype.new(:%, [Int, Int], Int)
    assert_equal proto, mod.node.prototype
  end
  
  def test_exponentiation
    lhs = Genera.Int(4)
    rhs = Genera.Int(5)
    pow = lhs ** rhs
    assert_kind_of Int, pow
    assert_kind_of Application, pow.node
    proto = Prototype.new(:**, [Int, Int], Int)
    assert_equal proto, pow.node.prototype
  end
end
