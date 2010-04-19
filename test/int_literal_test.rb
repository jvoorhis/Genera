require File.join(File.dirname(__FILE__), 'test_helper')

class IntLiteralTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    lit = IntLiteral.new(1)
    assert_kind_of Fixnum, lit.value
    assert_equal 1, lit.value
    
    lit = IntLiteral.new(2.5)
    assert_kind_of Fixnum, lit.value
    assert_equal 2, lit.value
  end
  
  def test_generate
    lit = IntLiteral.new(1)
    context = test_context
    val = lit.generate(context)
    assert_kind_of LLVM::Int, val
  end
end
