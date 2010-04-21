require File.join(File.dirname(__FILE__), 'test_helper')

class BoolLiteralTest < Test::Unit::TestCase
  
  def test_true
    lit = BoolLiteral.true
    assert_equal 1, lit.value
  end
  
  def test_false
    lit = BoolLiteral.false
    assert_equal 0, lit.value
  end
  
  def test_ctor
    lit = BoolLiteral.new(0)
    assert_equal 0, lit.value
    lit = BoolLiteral.new(1)
    assert_equal 1, lit.value
    lit = BoolLiteral.new(2)
    assert_equal 1, lit.value
  end
  
  def test_generate
    lit = BoolLiteral.new(1)
    context = test_context
    val = lit.generate(context)
    assert_kind_of LLVM::Int1, val
  end
end
