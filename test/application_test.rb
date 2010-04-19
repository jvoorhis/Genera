require File.join(File.dirname(__FILE__), 'test_helper')

class ApplicationTest < Test::Unit::TestCase
  include Genera
  
  def test_ctor
    proto = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    lhs   = FloatLiteral.new(1.0)
    rhs   = FloatLiteral.new(2.0)
    app   = Application.new(proto, [lhs, rhs])
    
    assert_equal proto, app.prototype
    assert_equal [lhs, rhs], app.args
  end
  
  def test_generate
    proto = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    lhs   = FloatLiteral.new(1.0)
    rhs   = FloatLiteral.new(2.0)
    app   = Application.new(proto, [lhs, rhs])
    
    context = test_context
    context.primitives[proto] = lambda do |lhs, rhs|
      builder.fadd(lhs, rhs)
    end
    
    val = app.generate(context)
    assert_kind_of LLVM::Value, val
  end
end
