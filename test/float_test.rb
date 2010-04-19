require File.join(File.dirname(__FILE__), 'test_helper')

class FloatTest < Test::Unit::TestCase
  include Genera
  
  def test_Float
    flt = Genera.Float(1.0)
    assert_kind_of Genera::Float, flt
  end
  
  def test_generate
    flt = Genera.Float(1.0)
    context = test_context
    val = flt.generate(context)
    assert_kind_of LLVM::Float, val
  end
end
