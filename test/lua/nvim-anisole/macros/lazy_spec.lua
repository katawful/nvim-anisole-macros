-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/lazy_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(do (local test {}) (tset test 1 \"butts\") (do (tset test 1 \"butts\") test))"
    end
    return assert.are.same("(do (local test {}) (tset test 1 \"butts\") (do (tset test 1 \"butts\") test))", _4_())
  end
  it("spec.init spec.repo.github calls", _3_)
  local function _5_()
    local function _6_()
      return "(do (local test {}) (tset test \"dir\" \"butts\") (do (tset test \"dir\" \"butts\") test))"
    end
    return assert.are.same("(do (local test {}) (tset test \"dir\" \"butts\") (do (tset test \"dir\" \"butts\") test))", _6_())
  end
  it("spec.init spec.repo.directory calls", _5_)
  local function _7_()
    local function _8_()
      return "(do (local test {}) (tset test \"url\" \"butts\"))"
    end
    return assert.are.same("(do (local test {}) (tset test \"url\" \"butts\"))", _8_())
  end
  return it("spec.init spec.repo.url call", _7_)
end
return describe("Spec repo calls:", _2_)
