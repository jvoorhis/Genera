require File.join(File.dirname(__FILE__), 'test_helper')

class PrototypeTest < Test::Unit::TestCase
  
  def test_ctor
    proto = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    assert_equal :+, proto.name
    assert_equal [Genera::Float, Genera::Float], proto.arg_types
    assert_equal Genera::Float, proto.return_type
  end
  
  def test_eql
    p1 = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    p2 = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    p3 = Prototype.new(:-@, [Genera::Float], Genera::Float)
    assert_equal p1, p2
    assert p1.eql?(p2)
    assert_not_equal p1, p3
  end
  
  def test_hash
    p1 = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    p2 = Prototype.new(:+, [Genera::Float, Genera::Float], Genera::Float)
    hsh = { p1 => 1 }
    assert hsh[p2], "Prototype values should work as Hash keys"
  end
end
