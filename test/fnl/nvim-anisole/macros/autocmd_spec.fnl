(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros auto :nvim-anisole.macros.autocmds)

(describe "Clear autocommand macro:"
          (fn []
            (it "cle-autocmd! is empty"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {})"
                                   (macrodebug (auto.cle-autocmd! {}) true))))
            (it "cle-autocmd! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0})"
                                   (macrodebug (auto.cle-autocmd! {:buffer 0}) true))))
            (it "cle-autocmd! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0 :event \"Test\"})"
                                   (macrodebug (auto.cle-autocmd! {:buffer 0}
                                                               :event :Test)
                                               true))))
            (it "cle-autocmd<-event! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:event \"Event1\"})"
                                   (macrodebug (auto.cle-autocmd<-event! :Event1)
                                               true))))
            (it "cle-autocmd<-event! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:event [\"Event1\" \"Event2\"]})"
                                   (macrodebug (auto.cle-autocmd<-event! [:Event1]
                                                                      :Event2)
                                               true))))
            (it "cle-autocmd<-pattern! with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:pattern \"Pattern\"})"
                                   (macrodebug (auto.cle-autocmd<-pattern! :Pattern)
                                               true))))
            (it "cle-autocmd<-pattern! with multiple options"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
                                   (macrodebug (auto.cle-autocmd<-pattern! [:Pattern1]
                                                                        :Pattern2)
                                               true))))
            (it :cle-autocmd<-buffer!
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:buffer 0})"
                                   (macrodebug (auto.cle-autocmd<-buffer! 0) true))))
            (it "cle-autocmd<-group! with string group"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.cle-autocmd<-group! :Group)
                                               true))))
            (it "cle-autocmd<-group! with int group"
                (fn []
                  (assert.are.same "(vim.api.nvim_clear_autocmds {:group 0})"
                                   (macrodebug (auto.cle-autocmd<-group! 0) true))))))

(describe "Delete autocommand group macro:"
          (fn []
            (it "del-aug! with int augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_del_augroup_by_id 0)"
                                   (macrodebug (auto.del-aug! 0) true))))
            (it "del-aug! with string augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_del_augroup_by_name \"Augroup\")"
                                   (macrodebug (auto.del-aug! :Augroup) true))))))

(describe "Get autocommand macro:"
          (fn []
            (it "get-autocmd with table"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.get-autocmd {:group :Group})
                                               true))))
            (it "get-autocmd<-event with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:event \"Event\"})"
                                   (macrodebug (auto.get-autocmd<-event :Event)
                                               true))))
            (it "get-autocmd<-event with multiple option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:event [\"Event1\" \"Event2\"]})"
                                   (macrodebug (auto.get-autocmd<-event [:Event1]
                                                                     :Event2)
                                               true))))
            (it "get-autocmd<-pattern with one option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:pattern \"Pattern\"})"
                                   (macrodebug (auto.get-autocmd<-pattern :Pattern)
                                               true))))
            (it "get-autocmd<-pattern with multiple option"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:pattern [\"Pattern1\" \"Pattern2\"]})"
                                   (macrodebug (auto.get-autocmd<-pattern [:Pattern1]
                                                                       :Pattern2)
                                               true))))
            (it "get-autocmd<-group with string augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group \"Group\"})"
                                   (macrodebug (auto.get-autocmd<-group :Group)
                                               true))))
            (it "get-autocmd<-group with int augroup"
                (fn []
                  (assert.are.same "(vim.api.nvim_get_autocmds {:group 0})"
                                   (macrodebug (auto.get-autocmd<-group 0) true))))))

(describe "Do autocommand macro:"
          (fn []
            (it "do-autocmd with string event and no opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds \"Event\" {})"
                                   (macrodebug (auto.do-autocmd :Event) true))))
            (it "do-autocmd with string event and opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds \"Event\" {:group \"Group\"})"
                                   (macrodebug (auto.do-autocmd :Event
                                                            {:group :Group})
                                               true))))
            (it "do-autocmd with table event and no opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {})"
                                   (macrodebug (auto.do-autocmd [:Event1 :Event2])
                                               true))))
            (it "do-autocmd with table event and opts table"
                (fn []
                  (assert.are.same "(vim.api.nvim_exec_autocmds [\"Event1\" \"Event2\"] {:group \"Group\"})"
                                   (macrodebug (auto.do-autocmd [:Event1 :Event2]
                                                            {:group :Group})
                                               true))))))
