(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros option :nvim-anisole.macros.options)

(describe "Set macro:"
          (fn []
            (it "set single option with no flag"
                (fn []
                  (assert.are.same "(tset vim.opt_local \"spell\" true)"
                                   (macrodebug (option.set spell true) true))))
            (it "set single option with flag"
                (fn []
                  (assert.are.same "(: (. vim.opt_local \"spell\") \"append\" true)"
                                   (macrodebug (option.set spell true :append)
                                               true))))
            (it "set multiple options with no flag"
                (fn []
                  (assert.are.same "(do (tset vim.opt_local \"spell\" true) (do (tset vim.opt_global \"mouse\" \"nvi\")))"
                                   (macrodebug (option.set {spell true
                                                            mouse :nvi})
                                               true))))
            (it "set multiple options with flag"
                (fn []
                  (assert.are.same "(do (: (. vim.opt_local \"spell\") \"append\" true) (do (: (. vim.opt_global \"mouse\") \"append\" \"nvi\")))"
                                   (macrodebug (option.set {spell true
                                                            mouse :nvi}
                                                           :append)
                                               true))))
            (it "set single variable"
                (fn []
                  (assert.are.same "(tset (. vim \"g\") \"variable\" \"Value\")"
                                   (macrodebug (option.set :g variable :Value)
                                               true))))
            (it "set single variable with indexed scope"
                (fn []
                  (assert.are.same "(tset (. (. vim \"b\") 1) \"variable\" \"Value\")"
                                   (macrodebug (option.set (. b 1) variable
                                                           :Value)
                                               true))))
            (it "set multiple variables"
                (fn []
                  (assert.are.same "(do (tset (. vim \"b\") \"variable1\" \"value\") (tset (. vim \"b\") \"variable1\" \"value\"))"
                                   (macrodebug (option.set :b
                                                           {variable1 :value
                                                            variable1 :value})
                                               true))))
            (it "set multiple variables with indexed scope"
                (fn []
                  (assert.are.same "(do (tset (. (. vim \"b\") 1) \"variable2\" \"value\") (tset (. (. vim \"b\") 1) \"variable1\" \"value\"))"
                                   (macrodebug (option.set (. b 1)
                                                           {variable1 :value
                                                            variable2 :value})
                                               true))))))

(describe "Get macro:"
          (fn []
            (it "get with option"
                (fn []
                  (assert.are.same "(: (. vim.opt \"option\") \"get\")"
                                   (macrodebug (option.get option) true))))
            (it "get variable with no scope indexing"
                (fn []
                  (assert.are.same "(. (. vim \"g\") \"variable\")"
                                   (macrodebug (option.get :g variable) true))))
            (it "get variable with scope indexing"
                (fn []
                  (assert.are.same "(. (. (. vim \"b\") 1) \"variable\")"
                                   (macrodebug (option.get (. :b 1) variable)
                                               true))))))
