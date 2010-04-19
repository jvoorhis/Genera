require File.join(File.dirname(__FILE__), 'test_helper')

class FloatLiteralTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    lit = FloatLiteral.new(1.0)
    assert_kind_of ::Float, lit.value
    assert_equal 1.0, lit.value
    
    lit = FloatLiteral.new(1)
    assert_kind_of ::Float, lit.value
    assert_equal 1.0, lit.value
  end
  
  def test_generate
    lit = FloatLiteral.new(1.0)
    context = test_context
    val = lit.generate(context)
    assert_kind_of LLVM::Float, val
  end
end
