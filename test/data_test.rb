require File.join(File.dirname(__FILE__), 'test_helper')

class DataTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    val = LLVM::Int(0)
    data = Data.new(val)
    assert_equal val, data.data
  end
  
  def test_generate
    inval = LLVM::Int(0)
    data = Data.new(inval)
    context = test_context
    outval = data.generate(context)
    assert_equal inval, outval
  end
end
