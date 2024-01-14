-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/lazy_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(do (local test {}) (tset test 1 \"name\") (do (tset test 1 \"name\") test))"
    end
    return assert.are.same("(do (local test {}) (tset test 1 \"name\") (do (tset test 1 \"name\") test))", _4_())
  end
  it("spec.repo.github calls", _3_)
  local function _5_()
    local function _6_()
      return "(do (local test {}) (tset test \"dir\" \"name\") (do (tset test \"dir\" \"name\") test))"
    end
    return assert.are.same("(do (local test {}) (tset test \"dir\" \"name\") (do (tset test \"dir\" \"name\") test))", _6_())
  end
  it("spec.repo.directory calls", _5_)
  local function _7_()
    local function _8_()
      return "(do (local test {}) (tset test \"url\" \"name\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"url\" \"name\") test)", _8_())
  end
  return it("spec.repo.url call", _7_)
end
describe("Spec repo calls:", _2_)
local function _9_()
  local function _10_()
    local function _11_()
      return "(do (local test {}) (tset test \"name\" \"name\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"name\" \"name\") test)", _11_())
  end
  return it("spec.name call", _10_)
end
describe("Spec name call:", _9_)
local function _12_()
  local function _13_()
    local function _14_()
      return "(do (local test {}) (tset test \"dev\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"dev\" true) test)", _14_())
  end
  return it("spec.dev call", _13_)
end
describe("Spec dev call:", _12_)
local function _15_()
  local function _16_()
    local function _17_()
      return "(do (local test {}) (tset test \"lazy\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"lazy\" true) test)", _17_())
  end
  return it("spec.lazy call", _16_)
end
describe("Spec lazy call:", _15_)
local function _18_()
  local function _19_()
    local function _20_()
      return "(do (local test {}) (tset test \"enabled\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"enabled\" true) test)", _20_())
  end
  return it("spec.enable call", _19_)
end
describe("Spec enable call:", _18_)
local function _21_()
  local function _22_()
    local function _23_()
      return "(do (local test {}) (tset test \"cond\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"cond\" true) test)", _23_())
  end
  return it("spec.condition call", _22_)
end
describe("Spec condition call:", _21_)
local function _24_()
  local function _25_()
    local function _26_()
      return "(do (local test {}) (tset test \"dependencies\" [\"plugin-name\"]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"dependencies\" [\"plugin-name\"]) test)", _26_())
  end
  it("spec.dependencies call with plugin name call", _25_)
  local function _27_()
    local function _28_()
      return "(do (local test {}) (tset test \"dependencies\" [[\"plugin/name\"]]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"dependencies\" [[\"plugin/name\"]]) test)", _28_())
  end
  return it("spec.dependencies call with spec call", _27_)
end
describe("Spec dependencies call:", _24_)
local function _29_()
  local function _30_()
    local function _31_()
      return "(do (local test {}) (tset test \"init\" (fn [])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"init\" (fn [])) test)", _31_())
  end
  return it("spec.startup call", _30_)
end
describe("Spec startup call:", _29_)
local function _32_()
  local function _33_()
    local function _34_()
      return "(do (local test {}) (tset test \"opts\" {:key value}) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"opts\" {:key value}) test)", _34_())
  end
  it("spec.opts call with table", _33_)
  local function _35_()
    local function _36_()
      return "(do (local test {}) (tset test \"opts\" (fn [plugin opts] {:key value})) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"opts\" (fn [plugin opts] {:key value})) test)", _36_())
  end
  return it("spec.opts call with function", _35_)
end
describe("Spec opts table call:", _32_)
local function _37_()
  local function _38_()
    local function _39_()
      return "(do (local test {}) (tset test \"config\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"config\" true) test)", _39_())
  end
  it("spec.config call with true", _38_)
  local function _40_()
    local function _41_()
      return "(do (local test {}) (tset test \"config\" (fn [plugin opts])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"config\" (fn [plugin opts])) test)", _41_())
  end
  return it("spec.config call with function", _40_)
end
describe("Spec config call:", _37_)
local function _42_()
  local function _43_()
    local function _44_()
      return "(do (local test {}) (tset test \"main\" \"name\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"main\" \"name\") test)", _44_())
  end
  return it("spec.module call", _43_)
end
describe("Spec module call:", _42_)
local function _45_()
  local function _46_()
    local function _47_()
      return "(do (local test {}) (tset test \"build\" \":function\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"build\" \":function\") test)", _47_())
  end
  it("spec.build call with Vim function", _46_)
  local function _48_()
    local function _49_()
      return "(do (local test {}) (tset test \"build\" (fn [plugin])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"build\" (fn [plugin])) test)", _49_())
  end
  it("spec.build call with Lua function", _48_)
  local function _50_()
    local function _51_()
      return "(do (local test {}) (tset test \"build\" [\":function1\" \":function2\"]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"build\" [\":function1\" \":function2\"]) test)", _51_())
  end
  return it("spec.build call with sequential table", _50_)
end
describe("Spec build call:", _45_)
local function _52_()
  local function _53_()
    local function _54_()
      return "(do (local test {}) (tset test \"branch\" \"branch\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"branch\" \"branch\") test)", _54_())
  end
  it("spec.repo.branch call", _53_)
  local function _55_()
    local function _56_()
      return "(do (local test {}) (tset test \"tag\" \"tag\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"tag\" \"tag\") test)", _56_())
  end
  it("spec.repo.tag call", _55_)
  local function _57_()
    local function _58_()
      return "(do (local test {}) (tset test \"version\" \"version\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"version\" \"version\") test)", _58_())
  end
  it("spec.repo.version call", _57_)
  local function _59_()
    local function _60_()
      return "(do (local test {}) (tset test \"commit\" \"commit\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"commit\" \"commit\") test)", _60_())
  end
  it("spec.repo.commit call", _59_)
  local function _61_()
    local function _62_()
      return "(do (local test {}) (tset test \"submodules\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"submodules\" true) test)", _62_())
  end
  return it("spec.repo.submodules? call", _61_)
end
describe("Spec repo branch/tag/version/commit call:", _52_)
local function _63_()
  local function _64_()
    local function _65_()
      return "(do (local test {}) (tset test \"event\" \"Event\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"event\" \"Event\") test)", _65_())
  end
  it("spec.load.event call with string event", _64_)
  local function _66_()
    local function _67_()
      return "(do (local test {}) (tset test \"event\" [\"Event1\" \"Event2\"]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"event\" [\"Event1\" \"Event2\"]) test)", _67_())
  end
  it("spec.load.event call with table of string events", _66_)
  local function _68_()
    local function _69_()
      return "(do (local test {}) (tset test \"event\" (fn [plugin event])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"event\" (fn [plugin event])) test)", _69_())
  end
  it("spec.load.event call with function event", _68_)
  local function _70_()
    local function _71_()
      return "(do (local test {}) (tset test \"event\" [[\"Event1\" \"*\"] [\"Event2\" \"*.toml\"]]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"event\" [[\"Event1\" \"*\"] [\"Event2\" \"*.toml\"]]) test)", _71_())
  end
  it("spec.load.event call with event/pattern table", _70_)
  local function _72_()
    local function _73_()
      return "(do (local test {}) (tset test \"cmd\" \"Command\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"cmd\" \"Command\") test)", _73_())
  end
  it("spec.load.command call with string command", _72_)
  local function _74_()
    local function _75_()
      return "(do (local test {}) (tset test \"cmd\" [\"Command1\" \"Command2\"]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"cmd\" [\"Command1\" \"Command2\"]) test)", _75_())
  end
  it("spec.load.command call with table of string commands", _74_)
  local function _76_()
    local function _77_()
      return "(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)", _77_())
  end
  it("spec.load.command call with function command", _76_)
  local function _78_()
    local function _79_()
      return "(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)", _79_())
  end
  it("spec.load.cmd call alias", _78_)
  local function _80_()
    local function _81_()
      return "(do (local test {}) (tset test \"ft\" \"filetype\") test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"ft\" \"filetype\") test)", _81_())
  end
  it("spec.load.filetype call with string filetype", _80_)
  local function _82_()
    local function _83_()
      return "(do (local test {}) (tset test \"ft\" [\"filetype1\" \"filetype2\"]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"ft\" [\"filetype1\" \"filetype2\"]) test)", _83_())
  end
  it("spec.load.filetype call with table of string filetypes", _82_)
  local function _84_()
    local function _85_()
      return "(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)", _85_())
  end
  it("spec.load.filetype call with function filetype", _84_)
  local function _86_()
    local function _87_()
      return "(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)", _87_())
  end
  it("spec.load.ft call alias", _86_)
  local function _88_()
    local function _89_()
      return "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :mode \"i\"}]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :mode \"i\"}]) test)", _89_())
  end
  it("spec.load.map with multiple self contained maps", _88_)
  local function _90_()
    local function _91_()
      return "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}]) test)", _91_())
  end
  it("spec.load.map with mode prefixed multiple maps", _90_)
  local function _92_()
    local function _93_()
      return "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}\n {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}]) test)", _93_())
  end
  it("spec.load.map with multiple modes prefixed multiple maps", _92_)
  local function _94_()
    local function _95_()
      return "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :buffer 0 :desc \"desc\" :ft \"toml\" :mode \"n\" :remap true}]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :buffer 0 :desc \"desc\" :ft \"toml\" :mode \"n\" :remap true}]) test)", _95_())
  end
  it("spec.load.map with mode and single map", _94_)
  local function _96_()
    local function _97_()
      return "(do (local test {}) (tset test \"keys\" [{1 \"lhs\"\n  2 \"rhs\"\n  :buffer 0\n  :desc \"desc\"\n  :ft \"toml\"\n  :mode [\"n\" \"v\"]\n  :remap true}]) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"keys\" [{1 \"lhs\"\n  2 \"rhs\"\n  :buffer 0\n  :desc \"desc\"\n  :ft \"toml\"\n  :mode [\"n\" \"v\"]\n  :remap true}]) test)", _97_())
  end
  return it("spec.load.map with multiple modes and single map", _96_)
end
describe("Spec load event/key/cmd/ft calls:", _63_)
local function _98_()
  local function _99_()
    local function _100_()
      return "(do (local test {}) (tset test \"module\" true) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"module\" true) test)", _100_())
  end
  return it("spec.load.module? call", _99_)
end
describe("Spec load module call:", _98_)
local function _101_()
  local function _102_()
    local function _103_()
      return "(do (local test {}) (tset test \"priority\" 1000) test)"
    end
    return assert.are.same("(do (local test {}) (tset test \"priority\" 1000) test)", _103_())
  end
  return it("spec.priority call", _102_)
end
describe("Spec priority call:", _101_)
local function _104_()
  local function _105_()
    local function _106_()
      return "(do (local test {}) nil test)"
    end
    return assert.are.same("(do (local test {}) nil test)", _106_())
  end
  return it("spec.optional call", _105_)
end
return describe("Spec optional call:", _104_)
