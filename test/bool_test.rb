require File.join(File.dirname(__FILE__), 'test_helper')

class BoolTest < Test::Unit::TestCase

  def test_Bool
    t = Genera.Bool(true)
    assert_kind_of Bool, t
    assert_kind_of BoolLiteral, t.node
  end
  
  def test_generate
    t = Genera.Bool(true)
    context = test_context
    val = t.generate(context)
    assert_kind_of LLVM::Int1, val
  end
  
  def test_not
    t = Genera.Bool(true)
    f = !t
    assert_kind_of Bool, f

    assert_bool_op "not" do |b|
      !b
    end
  end
  
  def test_and
    t = Genera.Bool(true)
    a = t & t
    assert_kind_of Bool, a

    assert_bool_op "and" do |a, b|
      a & b
    end
  end
  
  def test_or
    t = Genera.Bool(true)
    o = t & t
    assert_kind_of Bool, o

    assert_bool_op "or" do |a, b|
      a | b
    end
  end
  
  def test_xor
    o = Genera.Bool(true)
    x = o ^ o
    assert_kind_of Bool, o

    assert_bool_op "xor" do |a, b|
      a ^ b
    end
  end

  def assert_bool_op(name, &block)
    arg_types = Array.new(block.arity) { Genera::Bool }
    ret_type = Genera::Bool
    func = Function.new(name, arg_types, ret_type, &block)
    
    args = Array.new(block.arity) { rand(2).nonzero? ? true : false }
    assert_equal block.call(*args), func.call(*args)
  end 
end
