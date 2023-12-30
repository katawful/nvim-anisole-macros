-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/autocmd_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Description\" :pattern \"*\"})"
    end
    return assert.are.same("(vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Description\" :pattern \"*\"})", _4_())
  end
  it("cmd.create with empty opts table", _3_)
  local function _5_()
    local function _6_()
      return "(vim.api.nvim_create_autocmd \"Test\" {:buffer 0 :callback (fn []) :desc \"Description\" :group \"Test\" :pattern \"*\"})"
    end
    return assert.are.same("(vim.api.nvim_create_autocmd \"Test\" {:buffer 0 :callback (fn []) :desc \"Description\" :group \"Test\" :pattern \"*\"})", _6_())
  end
  return it("cmd.create with opts table", _5_)
end
describe("Create autocommand macro:", _2_)
local function _7_()
  local function _8_()
    local function _9_()
      return "(vim.api.nvim_create_augroup \"Test\" {:clear false})"
    end
    return assert.are.same("(vim.api.nvim_create_augroup \"Test\" {:clear false})", _9_())
  end
  it("group.define without ?no-clear", _8_)
  local function _10_()
    local function _11_()
      return "(vim.api.nvim_create_augroup \"Test\" {:clear true})"
    end
    return assert.are.same("(vim.api.nvim_create_augroup \"Test\" {:clear true})", _11_())
  end
  return it("group.define with ?no-clear", _10_)
end
describe("Define autogroup macro:", _7_)
local function _12_()
  local function _13_()
    local function _14_()
      return "(do (vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}))"
    end
    return assert.are.same("(do (vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}))", _14_())
  end
  it("group.fill with one autocommand", _13_)
  local function _15_()
    local function _16_()
      return "(do (vim.api.nvim_create_autocmd \"Command2\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}) (do (vim.api.nvim_create_autocmd \"Command1\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"})))"
    end
    return assert.are.same("(do (vim.api.nvim_create_autocmd \"Command2\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}) (do (vim.api.nvim_create_autocmd \"Command1\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"})))", _16_())
  end
  return it("group.fill with multiple autocommands", _15_)
end
describe("Fill autogroup macro:", _12_)
local function _17_()
  local function _18_()
    local function _19_()
      return "(vim.api.nvim_clear_autocmds {})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {})", _19_())
  end
  it("cmd.clear! is empty", _18_)
  local function _20_()
    local function _21_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0})", _21_())
  end
  it("cmd.clear! with one option", _20_)
  local function _22_()
    local function _23_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0 :event \"Test\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0 :event \"Test\"})", _23_())
  end
  it("cmd.clear! with multiple options", _22_)
  local function _24_()
    local function _25_()
      return "(vim.api.nvim_clear_autocmds {:event \"Event1\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:event \"Event1\"})", _25_())
  end
  it("cmd.clear<-event! with one option", _24_)
  local function _26_()
    local function _27_()
      return "(vim.api.nvim_clear_autocmds {:event [\"Event1\" \"Event2\"]})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:event [\"Event1\" \"Event2\"]})", _27_())
  end
  it("cmd.clear<-event! with multiple options", _26_)
  local function _28_()
    local function _29_()
      return "(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})", _29_())
  end
  it("cmd.clear<-pattern! with one option", _28_)
  local function _30_()
    local function _31_()
      return "(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})", _31_())
  end
  it("cmd.clear<-pattern! with multiple options", _30_)
  local function _32_()
    local function _33_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0})", _33_())
  end
  it("cmd.clear<-buffer!", _32_)
  local function _34_()
    local function _35_()
      return "(vim.api.nvim_clear_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:group \"Group\"})", _35_())
  end
  it("cmd.clear<-group! with string group", _34_)
  local function _36_()
    local function _37_()
      return "(vim.api.nvim_clear_autocmds {:group 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:group 0})", _37_())
  end
  return it("cmd.clear<-group! with int group", _36_)
end
describe("Clear autocommand macro:", _17_)
local function _38_()
  local function _39_()
    local function _40_()
      return "(vim.api.nvim_del_augroup_by_id 0)"
    end
    return assert.are.same("(vim.api.nvim_del_augroup_by_id 0)", _40_())
  end
  it("group.delete! with int augroup", _39_)
  local function _41_()
    local function _42_()
      return "(vim.api.nvim_del_augroup_by_name \"Augroup\")"
    end
    return assert.are.same("(vim.api.nvim_del_augroup_by_name \"Augroup\")", _42_())
  end
  return it("group.delete! with string augroup", _41_)
end
describe("Delete autogroup macro:", _38_)
local function _43_()
  local function _44_()
    local function _45_()
      return "(vim.api.nvim_get_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group \"Group\"})", _45_())
  end
  it("cmd.get with table", _44_)
  local function _46_()
    local function _47_()
      return "(vim.api.nvim_get_autocmds {:event \"Event\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:event \"Event\"})", _47_())
  end
  it("cmd.get<-event with one option", _46_)
  local function _48_()
    local function _49_()
      return "(vim.api.nvim_get_autocmds {:event [\"Event1\" \"Event2\"]})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:event [\"Event1\" \"Event2\"]})", _49_())
  end
  it("cmd.get<-event with multiple option", _48_)
  local function _50_()
    local function _51_()
      return "(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})", _51_())
  end
  it("cmd.get<-pattern with one option", _50_)
  local function _52_()
    local function _53_()
      return "(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})", _53_())
  end
  it("cmd.get<-pattern with multiple option", _52_)
  local function _54_()
    local function _55_()
      return "(vim.api.nvim_get_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group \"Group\"})", _55_())
  end
  it("cmd.get<-group with string augroup", _54_)
  local function _56_()
    local function _57_()
      return "(vim.api.nvim_get_autocmds {:group 0})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group 0})", _57_())
  end
  return it("cmd.get<-group with int augroup", _56_)
end
describe("Get autocommand macro:", _43_)
local function _58_()
  local function _59_()
    local function _60_()
      return "(vim.api.nvim_exec_autocmds \"Event\" {})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds \"Event\" {})", _60_())
  end
  it("cmd.run with string event and no opts table", _59_)
  local function _61_()
    local function _62_()
      return "(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})", _62_())
  end
  it("cmd.run with string event and opts table", _61_)
  local function _63_()
    local function _64_()
      return "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})", _64_())
  end
  it("cmd.run with table event and no opts table", _63_)
  local function _65_()
    local function _66_()
      return "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})", _66_())
  end
  return it("cmd.run with table event and opts table", _65_)
end
return describe("Do autocommand macro:", _58_)
