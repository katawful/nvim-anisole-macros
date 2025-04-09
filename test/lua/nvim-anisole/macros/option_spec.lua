-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/option_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(: (. vim.opt_local \"spell\") nil true)"
    end
    return assert.are.same("(tset vim.opt_local \"spell\" true)", _4_())
  end
  it("set single option with no flag", _3_)
  local function _5_()
    local function _6_()
      return "(: (. vim.opt_local \"spell\") \"append\" true)"
    end
    return assert.are.same("(: (. vim.opt_local \"spell\") \"append\" true)", _6_())
  end
  it("set single option with flag", _5_)
  local function _7_()
    local function _8_()
      return "(do (tset vim.opt_local \"spell\" true) (do (tset vim.opt_global \"mouse\" \"nvi\")))"
    end
    return assert.are.same("(do (tset vim.opt_local \"spell\" true) (do (tset vim.opt_global \"mouse\" \"nvi\")))", _8_())
  end
  it("set multiple options with no flag", _7_)
  local function _9_()
    local function _10_()
      return "(do (: (. vim.opt_local \"spell\") \"append\" true) (do (: (. vim.opt_global \"mouse\") \"append\" \"nvi\")))"
    end
    return assert.are.same("(do (: (. vim.opt_local \"spell\") \"append\" true) (do (: (. vim.opt_global \"mouse\") \"append\" \"nvi\")))", _10_())
  end
  it("set multiple options with flag", _9_)
  local function _11_()
    local function _12_()
      return "(tset (. vim \"g\") \"variable\" \"Value\")"
    end
    return assert.are.same("(tset (. vim \"g\") \"variable\" \"Value\")", _12_())
  end
  it("set single variable", _11_)
  local function _13_()
    local function _14_()
      return "(tset (. (. vim \"b\") 1) \"variable\" \"Value\")"
    end
    return assert.are.same("(tset (. (. vim \"b\") 1) \"variable\" \"Value\")", _14_())
  end
  it("set single variable with indexed scope", _13_)
  local function _15_()
    local function _16_()
      return "(do (tset (. vim \"b\") \"variable1\" \"value\") (tset (. vim \"b\") \"variable1\" \"value\"))"
    end
    return assert.are.same("(do (tset (. vim \"b\") \"variable1\" \"value\") (tset (. vim \"b\") \"variable1\" \"value\"))", _16_())
  end
  it("set multiple variables", _15_)
  local function _17_()
    local function _18_()
      return "(do (tset (. (. vim \"b\") 1) \"variable2\" \"value\") (tset (. (. vim \"b\") 1) \"variable1\" \"value\"))"
    end
    return assert.are.same("(do (tset (. (. vim \"b\") 1) \"variable2\" \"value\") (tset (. (. vim \"b\") 1) \"variable1\" \"value\"))", _18_())
  end
  return it("set multiple variables with indexed scope", _17_)
end
describe("Set macro:", _2_)
local function _19_()
  local function _20_()
    local function _21_()
      return "(: (. vim.opt \"option\") \"get\")"
    end
    return assert.are.same("(: (. vim.opt \"option\") \"get\")", _21_())
  end
  it("get with option", _20_)
  local function _22_()
    local function _23_()
      return "(. (. vim \"g\") \"variable\")"
    end
    return assert.are.same("(. (. vim \"g\") \"variable\")", _23_())
  end
  it("get variable with no scope indexing", _22_)
  local function _24_()
    local function _25_()
      return "(. (. (. vim \"b\") 1) \"variable\")"
    end
    return assert.are.same("(. (. (. vim \"b\") 1) \"variable\")", _25_())
  end
  return it("get variable with scope indexing", _24_)
end
return describe("Get macro:", _19_)
