-- [nfnl] Compiled from test/fnl/nvim-anisole/macros/autocmd_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local function _2_()
  local function _3_()
    local function _4_()
      return "(vim.api.nvim_clear_autocmds {})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {})", _4_())
  end
  it("cle-auc! is empty", _3_)
  local function _5_()
    local function _6_()
local function _7_()
  local function _8_()
    local function _9_()
      return "(vim.api.nvim_clear_autocmds {})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {})", _9_())
  end
  it("cle-autocmd! is empty", _8_)
  local function _10_()
    local function _11_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0})", _11_())
  end
  it("cle-autocmd! with one option", _10_)
  local function _12_()
    local function _13_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0 :event \"Test\"})", _13_())
  end
  it("cle-autocmd! with multiple options", _12_)
  local function _14_()
    local function _15_()
      return "(vim.api.nvim_clear_autocmds {:event \"Event1\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:event \"Event1\"})", _15_())
  end
  it("cle-autocmd<-event! with one option", _14_)
  local function _16_()
    local function _17_()
      return "(vim.api.nvim_clear_autocmds {:event [\"Event1\"]})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:event [\"Event1\" \"Event2\"]})", _17_())
  end
  it("cle-autocmd<-event! with multiple options", _16_)
  local function _18_()
    local function _19_()
      return "(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})", _19_())
  end
  it("cle-autocmd<-pattern! with one option", _18_)
  local function _20_()
    local function _21_()
      return "(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\"]})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})", _21_())
  end
  it("cle-autocmd<-pattern! with multiple options", _20_)
  local function _22_()
    local function _23_()
      return "(vim.api.nvim_clear_autocmds {:buffer 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:buffer 0})", _23_())
  end
  it("cle-autocmd<-buffer!", _22_)
  local function _24_()
    local function _25_()
      return "(vim.api.nvim_clear_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:group \"Group\"})", _25_())
  end
  it("cle-autocmd<-group! with string group", _24_)
  local function _26_()
    local function _27_()
      return "(vim.api.nvim_clear_autocmds {:group 0})"
    end
    return assert.are.same("(vim.api.nvim_clear_autocmds {:group 0})", _27_())
  end
  return it("cle-autocmd<-group! with int group", _26_)
end
describe("Clear autocommand macro:", _7_)
local function _28_()
  local function _29_()
    local function _30_()
      return "(vim.api.nvim_del_augroup_by_id 0)"
    end
    return assert.are.same("(vim.api.nvim_del_augroup_by_id 0)", _30_())
  end
  it("del-aug! with int augroup", _29_)
  local function _31_()
    local function _32_()
      return "(vim.api.nvim_del_augroup_by_name \"Augroup\")"
    end
    return assert.are.same("(vim.api.nvim_del_augroup_by_name \"Augroup\")", _32_())
  end
  return it("del-aug! with string augroup", _31_)
end
describe("Delete autocommand group macro:", _28_)
local function _33_()
  local function _34_()
    local function _35_()
      return "(vim.api.nvim_get_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group \"Group\"})", _35_())
  end
  it("get-autocmd with table", _34_)
  local function _36_()
    local function _37_()
      return "(vim.api.nvim_get_autocmds {:event \"Event\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:event \"Event\"})", _37_())
  end
  it("get-autocmd<-event with one option", _36_)
  local function _38_()
    local function _39_()
      return "(vim.api.nvim_get_autocmds {:event [\"Event1\"]})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:event [\"Event1\" \"Event2\"]})", _39_())
  end
  it("get-autocmd<-event with multiple option", _38_)
  local function _40_()
    local function _41_()
      return "(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})", _41_())
  end
  it("get-autocmd<-pattern with one option", _40_)
  local function _42_()
    local function _43_()
      return "(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\"]})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})", _43_())
  end
  it("get-autocmd<-pattern with multiple option", _42_)
  local function _44_()
    local function _45_()
      return "(vim.api.nvim_get_autocmds {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group \"Group\"})", _45_())
  end
  it("get-autocmd<-group with string augroup", _44_)
  local function _46_()
    local function _47_()
      return "(vim.api.nvim_get_autocmds {:group 0})"
    end
    return assert.are.same("(vim.api.nvim_get_autocmds {:group 0})", _47_())
  end
  return it("get-autocmd<-group with int augroup", _46_)
end
describe("Get autocommand macro:", _33_)
local function _48_()
  local function _49_()
    local function _50_()
      return "(vim.api.nvim_exec_autocmds \"Event\" {})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds \"Event\" {})", _50_())
  end
  it("do-autocmd with string event and no opts table", _49_)
  local function _51_()
    local function _52_()
      return "(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})", _52_())
  end
  it("do-autocmd with string event and opts table", _51_)
  local function _53_()
    local function _54_()
      return "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})", _54_())
  end
  it("do-autocmd with table event and no opts table", _53_)
  local function _55_()
    local function _56_()
      return "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})"
    end
    return assert.are.same("(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})", _56_())
  end
  return it("do-autocmd with table event and opts table", _55_)
end
return describe("Do autocommand macro:", _48_)
