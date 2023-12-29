-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/command_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(vim.cmd {:args {} :cmd \"function\" :output true})"
    end
    return assert.are.same("(vim.cmd {:args {} :cmd \"function\" :output true})", _4_())
  end
  it("do-ex with no args", _3_)
  local function _5_()
    local function _6_()
      return "(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})"
    end
    return assert.are.same("(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})", _6_())
  end
  it("do-ex with switch arg", _5_)
  local function _7_()
    local function _8_()
      return "(vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true})"
    end
    return assert.are.same("(vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true})", _8_())
  end
  it("do-ex with table arg", _7_)
  local function _9_()
    local function _10_()
      return "(vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true})"
    end
    return assert.are.same("(vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true})", _10_())
  end
  return it("do-ex with table and switch arg", _9_)
end
describe("Do Ex command macro:", _2_)
local function _11_()
  local function _12_()
    local function _13_()
      return "((. vim.fn \"function\"))"
    end
    return assert.are.same("((. vim.fn \"function\"))", _13_())
  end
  it("do-viml with no args", _12_)
  local function _14_()
    local function _15_()
      return "(do (let [result_6_auto ((. vim.fn \"empty\"))] (if (= result_6_auto 0) false true)))"
    end
    return assert.are.same("(do (let [result_6_auto ((. vim.fn \"empty\"))] (if (= result_6_auto 0) false true)))", _15_())
  end
  it("do-viml boolean returning function", _14_)
  local function _16_()
    local function _17_()
      return "((. vim.fn \"expand\") \"%\" vim.v.true)"
    end
    return assert.are.same("((. vim.fn \"expand\") \"%\" vim.v.true)", _17_())
  end
  it("do-viml with arg", _16_)
  local function _18_()
    local function _19_()
      return "(do (let [result_6_auto ((. vim.fn \"has\") \"arg\")] (if (= result_6_auto 0) false true)))"
    end
    return assert.are.same("(do (let [result_6_auto ((. vim.fn \"has\") \"arg\")] (if (= result_6_auto 0) false true)))", _19_())
  end
  return it("do-viml boolean returning function with arg", _18_)
end
describe("Do VimL 8 command macro:", _11_)
local function _20_()
  local function _21_()
    local function _22_()
      return "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"})", _22_())
  end
  it("cre-command without buffer option with no arg", _21_)
  local function _23_()
    local function _24_()
      return "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})", _24_())
  end
  it("cre-command without buffer option with arg", _23_)
  local function _25_()
    local function _26_()
      return "(vim.api.nvim_buf_create_user_command 0 \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_buf_create_user_command 0 \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})", _26_())
  end
  return it("cre-command with buffer option with arg", _25_)
end
describe("Create user-command macro:", _20_)
local function _27_()
  local function _28_()
    local function _29_()
      return "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"}) \"UserCommand\")"
    end
    return assert.are.same("(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"}) \"UserCommand\")", _29_())
  end
  it("def-command with no arg", _28_)
  local function _30_()
    local function _31_()
      return "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"}) \"UserCommand\")"
    end
    return assert.are.same("(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"}) \"UserCommand\")", _31_())
  end
  return it("def-command with arg", _30_)
end
describe("Define user-command macro:", _27_)
local function _32_()
  local function _33_()
    local function _34_()
      return "(vim.api.nvim_del_user_command \"UserCommand\")"
    end
    return assert.are.same("(vim.api.nvim_del_user_command \"UserCommand\")", _34_())
  end
  it("del-command! with just name", _33_)
  local function _35_()
    local function _36_()
      return "(vim.api.nvim_buf_del_user_command \"UserCommand\" 0)"
    end
    return assert.are.same("(vim.api.nvim_buf_del_user_command \"UserCommand\" 0)", _36_())
  end
  it("del-command! with name and boolean buffer option", _35_)
  local function _37_()
    local function _38_()
      return "(vim.api.nvim_buf_del_user_command \"UserCommand\" 1)"
    end
    return assert.are.same("(vim.api.nvim_buf_del_user_command \"UserCommand\" 1)", _38_())
  end
  return it("del-command! with name and int buffer option", _37_)
end
describe("Delete user-command macro:", _32_)
local function _39_()
  local function _40_()
    local function _41_()
      return "(do (vim.cmd {:args {} :cmd \"function\" :output true}))"
    end
    return assert.are.same("(do (vim.cmd {:args {} :cmd \"function\" :output true}))", _41_())
  end
  it("do-command with no args", _40_)
  local function _42_()
    local function _43_()
      return "(do (vim.cmd {:args [\"arg\"] :cmd \"function\" :output true}))"
    end
    return assert.are.same("(do (vim.cmd {:args [\"arg\"] :cmd \"function\" :output true}))", _43_())
  end
  it("do-command with switch arg", _42_)
  local function _44_()
    local function _45_()
      return "(do (vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true}))"
    end
    return assert.are.same("(do (vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true}))", _45_())
  end
  it("do-command with table arg", _44_)
  local function _46_()
    local function _47_()
      return "(do (vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true}))"
    end
    return assert.are.same("(do (vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true}))", _47_())
  end
  return it("do-command with table and switch arg", _46_)
end
return describe("Do user-command macro:", _39_)
