require File.join(File.dirname(__FILE__), 'test_helper')

class CondTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    t = BoolLiteral.true
    c = FloatLiteral.new(1)
    a = FloatLiteral.new(0)
    cond = Cond.new(t, c, a)
    assert_equal t, cond.condition
    assert_equal c, cond.consequent
    assert_equal a, cond.alternative
  end
  
  def test_generate
    t = BoolLiteral.true
    c = FloatLiteral.new(1)
    a = FloatLiteral.new(0)
    cond = FloatCond.new(t, c, a)
    context = test_context
    val = cond.generate(context)
    assert_kind_of LLVM::Value, val
  end
end
