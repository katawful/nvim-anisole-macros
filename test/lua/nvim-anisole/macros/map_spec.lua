-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/map_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:desc \"Description\"})"
    end
    return assert.are.same("(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:desc \"Description\"})", _4_())
  end
  it("create with single map, no arg and single mode", _3_)
  local function _5_()
    local function _6_()
      return "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:desc \"Description\"})"
    end
    return assert.are.same("(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:desc \"Description\"})", _6_())
  end
  it("create with single map, no arg and multiple modes", _5_)
  local function _7_()
    local function _8_()
      return "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
    end
    return assert.are.same("(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})", _8_())
  end
  it("create with single map, arg and single mode", _7_)
  local function _9_()
    local function _10_()
      return "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
    end
    return assert.are.same("(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})", _10_())
  end
  it("create with single map, arg and multiple modes", _9_)
  local function _11_()
    local function _12_()
      return "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
    end
    return assert.are.same("(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))", _12_())
  end
  it("create with multiple maps, no arg and single mode", _11_)
  local function _13_()
    local function _14_()
      return "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
    end
    return assert.are.same("(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))", _14_())
  end
  it("create with multiple maps, no arg and multiple mode", _13_)
  local function _15_()
    local function _16_()
      return "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
    end
    return assert.are.same("(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))", _16_())
  end
  it("create with multiple maps, arg and single mode", _15_)
  local function _17_()
    local function _18_()
      return "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
    end
    return assert.are.same("(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))", _18_())
  end
  return it("create with multiple maps, arg and multiple mode", _17_)
end
return describe("Create map macro:", _2_)
