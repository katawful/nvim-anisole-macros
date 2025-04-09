-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/command_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(vim.cmd {:args {} :bang false :cmd \"function\"})"
    end
    return assert.are.same("(vim.cmd {:args {} :cmd \"function\" :output true})", _4_())
  end
  it("run.command with no args", _3_)
  local function _5_()
    local function _6_()
      return "(vim.cmd {:args [\"arg\"] :bang false :cmd \"function\"})"
    end
    return assert.are.same("(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})", _6_())
  end
  it("run.command with switch arg", _5_)
  local function _7_()
    local function _8_()
      return "(vim.cmd {:args [\"key=value\"] :bang false :cmd \"function\"})"
    end
    return assert.are.same("(vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true})", _8_())
  end
  it("run.command with table arg", _7_)
  local function _9_()
    local function _10_()
      return "(vim.cmd {:args [\"arg\" \"key=value\"] :bang false :cmd \"function\"})"
    end
    return assert.are.same("(vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true})", _10_())
  end
  it("run.command with table and switch arg", _9_)
  local function _11_()
    local function _12_()
      return "(vim.cmd {:args [\"arg\"] :bang false :cmd \"function\"})"
    end
    return assert.are.same("(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})", _12_())
  end
  return it("run.cmd abbreviation", _11_)
end
describe("Run Ex command macro:", _2_)
local function _13_()
  local function _14_()
    local function _15_()
      return "((. vim.fn \"function\"))"
    end
    return assert.are.same("((. vim.fn \"function\"))", _15_())
  end
  it("run.function with no args", _14_)
  local function _16_()
    local function _17_()
      return "(do (let [result_9_auto ((. vim.fn \"empty\"))] (if (= result_9_auto 0) false true)))"
    end
    return assert.are.same("(do (let [result_6_auto ((. vim.fn \"empty\"))] (if (= result_6_auto 0) false true)))", _17_())
  end
  it("run.function boolean returning function", _16_)
  local function _18_()
    local function _19_()
      return "((. vim.fn \"expand\") \"%\" vim.v.true)"
    end
    return assert.are.same("((. vim.fn \"expand\") \"%\" vim.v.true)", _19_())
  end
  it("run.function with arg", _18_)
  local function _20_()
    local function _21_()
      return "(do (let [result_9_auto ((. vim.fn \"has\") \"arg\")] (if (= result_9_auto 0) false true)))"
    end
    return assert.are.same("(do (let [result_6_auto ((. vim.fn \"has\") \"arg\")] (if (= result_6_auto 0) false true)))", _21_())
  end
  it("run.function boolean returning function with arg", _20_)
  local function _22_()
    local function _23_()
      return "((. vim.fn \"function\"))"
    end
    return assert.are.same("((. vim.fn \"function\"))", _23_())
  end
  return it("run.fn abbreviation", _22_)
end
describe("Run VimL 8 command macro:", _13_)
local function _24_()
  local function _25_()
    local function _26_()
      return "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"})", _26_())
  end
  it("create without buffer option with no arg", _25_)
  local function _27_()
    local function _28_()
      return "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})", _28_())
  end
  it("create without buffer option with arg", _27_)
  local function _29_()
    local function _30_()
      return "(vim.api.nvim_buf_create_user_command 0 \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
    end
    return assert.are.same("(vim.api.nvim_buf_create_user_command 0 \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})", _30_())
  end
  return it("create with buffer option with arg", _29_)
end
describe("Create user-command macro:", _24_)
local function _31_()
  local function _32_()
    local function _33_()
      return "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"}) \"UserCommand\")"
    end
    return assert.are.same("(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"}) \"UserCommand\")", _33_())
  end
  it("define with no arg", _32_)
  local function _34_()
    local function _35_()
      return "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"}) \"UserCommand\")"
    end
    return assert.are.same("(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"}) \"UserCommand\")", _35_())
  end
  return it("define with arg", _34_)
end
describe("Define user-command macro:", _31_)
local function _36_()
  local function _37_()
    local function _38_()
      return "(vim.api.nvim_del_user_command \"UserCommand\")"
    end
    return assert.are.same("(vim.api.nvim_del_user_command \"UserCommand\")", _38_())
  end
  it("delete! with just name", _37_)
  local function _39_()
    local function _40_()
      return "(vim.api.nvim_buf_del_user_command \"UserCommand\" 0)"
    end
    return assert.are.same("(vim.api.nvim_buf_del_user_command \"UserCommand\" 0)", _40_())
  end
  it("delete! with name and boolean buffer option", _39_)
  local function _41_()
    local function _42_()
      return "(vim.api.nvim_buf_del_user_command \"UserCommand\" 1)"
    end
    return assert.are.same("(vim.api.nvim_buf_del_user_command \"UserCommand\" 1)", _42_())
  end
  return it("delete! with name and int buffer option", _41_)
end
return describe("Delete user-command macro:", _36_)
