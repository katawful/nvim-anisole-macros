(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros command :nvim-anisole.macros.commands)

(describe "Run Ex command macro:"
          (fn []
            (it "run.command with no args"
                (fn []
                  (assert.are.same "(vim.cmd {:args {} :cmd \"function\" :output true})"
                                   (macrodebug (command.run.command function)
                                               true))))
            (it "run.command with switch arg"
                (fn []
                  (assert.are.same "(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})"
                                   (macrodebug (command.run.command function
                                                                    :arg)
                                               true))))
            (it "run.command with table arg"
                (fn []
                  (assert.are.same "(vim.cmd {:args [\"key=value\"] :cmd \"function\" :output true})"
                                   (macrodebug (command.run.command function
                                                                    {:key value})
                                               true))))
            (it "run.command with table and switch arg"
                (fn []
                  (assert.are.same "(vim.cmd {:args [\"arg\" \"key=value\"] :cmd \"function\" :output true})"
                                   (macrodebug (command.run.command function
                                                                    :arg
                                                                    {:key value})
                                               true))))
            (it "run.cmd abbreviation"
                (fn []
                  (assert.are.same "(vim.cmd {:args [\"arg\"] :cmd \"function\" :output true})"
                                   (macrodebug (command.run.cmd function :arg)
                                               true))))))

(describe "Run VimL 8 command macro:"
          (fn []
            (it "run.function with no args"
                (fn []
                  (assert.are.same "((. vim.fn \"function\"))"
                                   (macrodebug (command.run.function function)
                                               true))))
            (it "run.function boolean returning function"
                (fn []
                  (assert.are.same "(do (let [result_6_auto ((. vim.fn \"empty\"))] (if (= result_6_auto 0) false true)))"
                                   (macrodebug (command.run.function empty)
                                               true))))
            (it "run.function with arg"
                (fn []
                  (assert.are.same "((. vim.fn \"expand\") \"%\" vim.v.true)"
                                   (macrodebug (command.run.function expand "%"
                                                                     vim.v.true)
                                               true))))
            (it "run.function boolean returning function with arg"
                (fn []
                  (assert.are.same "(do (let [result_6_auto ((. vim.fn \"has\") \"arg\")] (if (= result_6_auto 0) false true)))"
                                   (macrodebug (command.run.function has :arg)
                                               true))))
            (it "run.fn abbreviation"
                (fn []
                  (assert.are.same "((. vim.fn \"function\"))"
                                   (macrodebug (command.run.fn function) true))))))

(describe "Create user-command macro:"
          (fn []
            (it "create without buffer option with no arg"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"})"
                                   (macrodebug (command.create :UserCommand
                                                               (fn []
                                                                 callback)
                                                               :Description)
                                               true))))
            (it "create without buffer option with arg"
                (fn []
                  (assert.are.same "(vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
                                   (macrodebug (command.create :UserCommand
                                                               (fn []
                                                                 callback)
                                                               :Description
                                                               {:bang true})
                                               true))))
            (it "create with buffer option with arg"
                (fn []
                  (assert.are.same "(vim.api.nvim_buf_create_user_command 0 \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"})"
                                   (macrodebug (command.create :UserCommand
                                                               (fn []
                                                                 callback)
                                                               :Description
                                                               {:bang true
                                                                :buffer 0})
                                               true))))))

(describe "Define user-command macro:"
          (fn []
            (it "define with no arg"
                (fn []
                  (assert.are.same "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:desc \"Description\"}) \"UserCommand\")"
                                   (macrodebug (command.define :UserCommand
                                                 (fn [] callback)
                                                 :Description)
                                               true))))
            (it "define with arg"
                (fn []
                  (assert.are.same "(do (vim.api.nvim_create_user_command \"UserCommand\" (fn [] callback) {:bang true :desc \"Description\"}) \"UserCommand\")"
                                   (macrodebug (command.define :UserCommand
                                                 (fn [] callback)
                                                 :Description
                                                 {:bang true})
                                               true))))))

(describe "Delete user-command macro:"
          (fn []
            (it "delete! with just name"
                (fn []
                  (assert.are.same "(vim.api.nvim_del_user_command \"UserCommand\")"
                                   (macrodebug (command.delete! :UserCommand)
                                               true))))
            (it "delete! with name and boolean buffer option"
                (fn []
                  (assert.are.same "(vim.api.nvim_buf_del_user_command \"UserCommand\" 0)"
                                   (macrodebug (command.delete! :UserCommand
                                                                true)
                                               true))))
            (it "delete! with name and int buffer option"
                (fn []
                  (assert.are.same "(vim.api.nvim_buf_del_user_command \"UserCommand\" 1)"
                                   (macrodebug (command.delete! :UserCommand 1)
                                               true))))))
