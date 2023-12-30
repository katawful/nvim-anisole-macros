(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros auto :nvim-anisole.macros.autocmds)
; (local cmd auto.cmd)
; (local group auto.group)

(describe "Create autocommand macro:"
          (fn []
            (it "cmd.create with empty opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Description\" :pattern \"*\"})"
                                   (macrodebug (auto.cmd.create :Test "*"
                                                                (fn [])
                                                                :Description)
                                               true))))
            (it "cmd.create with opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_autocmd \"Test\" {:buffer 0 :callback (fn []) :desc \"Description\" :group \"Test\" :pattern \"*\"})"
                                   (macrodebug (auto.cmd.create :Test "*"
                                                                (fn [])
                                                                :Description
                                                                {:group :Test
                                                                 :buffer 0})
                                               true))))))

(describe "Define autogroup macro:"
          (fn []
            (it "group.define without ?no-clear"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_augroup \"Test\" {:clear false})"
                                   (macrodebug (auto.group.define :Test) true))))
            (it "group.define with ?no-clear"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_augroup \"Test\" {:clear true})"
                                   (macrodebug (auto.group.define :Test true)
                                               true))))))

(describe "Fill autogroup macro:"
          (fn []
            (it "group.fill with one autocommand"
                (fn []
                  (assert.are.same "(do (vim.api.nvim_create_autocmd \"Test\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}))"
                                   (macrodebug (auto.group.fill 1
                                                                (auto.cmd.create :Test
                                                                                 "*"
                                                                                 (fn [])
                                                                                 :Desc))
                                               true))))
            (it "group.fill with multiple autocommands"
                (fn []
                  (assert.are.same "(do (vim.api.nvim_create_autocmd \"Command2\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"}) (do (vim.api.nvim_create_autocmd \"Command1\" {:callback (fn []) :desc \"Desc\" :group 1 :pattern \"*\"})))"
                                   (macrodebug (auto.group.fill 1
                                                                (auto.cmd.create :Command1
                                                                                 "*"
                                                                                 (fn [])
                                                                                 :Desc)
                                                                (auto.cmd.create :Command2
                                                                                 "*"
                                                                                 (fn [])
                                                                                 :Desc))
                                               true))))))

(describe "Clear autocommand macro:"
          (fn []
            (it "cmd.clear! is empty"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {})"
                                   (macrodebug (auto.cmd.clear! {}) true))))
            (it "cmd.clear! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0})"
                                   (macrodebug (auto.cmd.clear! {:buffer 0})
                                               true))))
            (it "cmd.clear! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0 :event \"Test\"})"
                                   (macrodebug (auto.cmd.clear! {:buffer 0
                                                                 :event :Test})
                                               true))))
            (it "cmd.clear<-event! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:event \"Event1\"})"
                                   (macrodebug (auto.cmd.clear<-event! :Event1)
                                               true))))
            (it "cmd.clear<-event! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:event [\"Event1\" \"Event2\"]})"
                                   (macrodebug (auto.cmd.clear<-event! [:Event1
                                                                        :Event2])
                                               true))))
            (it "cmd.clear<-pattern! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})"
                                   (macrodebug (auto.cmd.clear<-pattern! :Pattern)
                                               true))))
            (it "cmd.clear<-pattern! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
                                   (macrodebug (auto.cmd.clear<-pattern! [:Pattern1
                                                                          :Pattern2])
                                               true))))
            (it :cmd.clear<-buffer!
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0})"
                                   (macrodebug (auto.cmd.clear<-buffer! 0) true))))
            (it "cmd.clear<-group! with string group"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.cmd.clear<-group! :Group)
                                               true))))
            (it "cmd.clear<-group! with int group"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:group 0})"
                                   (macrodebug (auto.cmd.clear<-group! 0) true))))))

(describe "Delete autogroup macro:"
          (fn []
            (it "group.delete! with int augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_del_augroup_by_id 0)"
                                   (macrodebug (auto.group.delete! 0) true))))
            (it "group.delete! with string augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_del_augroup_by_name \"Augroup\")"
                                   (macrodebug (auto.group.delete! :Augroup)
                                               true))))))

(describe "Get autocommand macro:"
          (fn []
            (it "cmd.get with table"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.cmd.get {:group :Group})
                                               true))))
            (it "cmd.get<-event with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:event \"Event\"})"
                                   (macrodebug (auto.cmd.get<-event :Event)
                                               true))))
            (it "cmd.get<-event with multiple option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:event [\"Event1\" \"Event2\"]})"
                                   (macrodebug (auto.cmd.get<-event [:Event1
                                                                     :Event2])
                                               true))))
            (it "cmd.get<-pattern with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})"
                                   (macrodebug (auto.cmd.get<-pattern :Pattern)
                                               true))))
            (it "cmd.get<-pattern with multiple option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
                                   (macrodebug (auto.cmd.get<-pattern [:Pattern1
                                                                       :Pattern2])
                                               true))))
            (it "cmd.get<-group with string augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.cmd.get<-group :Group)
                                               true))))
            (it "cmd.get<-group with int augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group 0})"
                                   (macrodebug (auto.cmd.get<-group 0) true))))))

(describe "Do autocommand macro:"
          (fn []
            (it "cmd.run with string event and no opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds \"Event\" {})"
                                   (macrodebug (auto.cmd.run :Event) true))))
            (it "cmd.run with string event and opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})"
                                   (macrodebug (auto.cmd.run :Event
                                                             {:group :Group})
                                               true))))
            (it "cmd.run with table event and no opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})"
                                   (macrodebug (auto.cmd.run [:Event1 :Event2])
                                               true))))
            (it "cmd.run with table event and opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})"
                                   (macrodebug (auto.cmd.run [:Event1 :Event2]
                                                             {:group :Group})
                                               true))))))
