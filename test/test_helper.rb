require 'genera'
require 'test/unit'

module TestHelper
  def test_context
    mod = LLVM::Module.create("Test Module")
    func = mod.functions.add("test_function", [], LLVM::Int)
    entry = func.basic_blocks.append("entry")
    builder = LLVM::Builder.create
    builder.position_at_end(entry)
    Genera::Context.new(mod, func, builder)
  end
end

class Test::Unit::TestCase
  include Genera
  include TestHelper
end
