(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros map :nvim-anisole.macros.maps)

(describe "Create map macro:"
          (fn []
            (it "create with single map, no arg and single mode"
                (fn []
                  (assert.are.same "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:desc \"Description\"})"
                                   (macrodebug (map.create :n :lhs :rhs
                                                           :Description)
                                               true))))
            (it "create with single map, no arg and multiple modes"
                (fn []
                  (assert.are.same "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:desc \"Description\"})"
                                   (macrodebug (map.create [:n :v] :lhs :rhs
                                                           :Description)
                                               true))))
            (it "create with single map, arg and single mode"
                (fn []
                  (assert.are.same "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
                                   (macrodebug (map.create :n :lhs :rhs
                                                           :Description
                                                           {:buffer 0})
                                               true))))
            (it "create with single map, arg and multiple modes"
                (fn []
                  (assert.are.same "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
                                   (macrodebug (map.create [:n :v] :lhs :rhs
                                                           :Description
                                                           {:buffer 0})
                                               true))))
            (it "create with multiple maps, no arg and single mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.create :n
                                                           [:lhs1
                                                            :rhs1
                                                            "Description 1"]
                                                           [:lhs2
                                                            :rhs2
                                                            "Description 2"])
                                               true))))
            (it "create with multiple maps, no arg and multiple mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.create [:n :v]
                                                           [:lhs1
                                                            :rhs1
                                                            "Description 1"]
                                                           [:lhs2
                                                            :rhs2
                                                            "Description 2"])
                                               true))))
            (it "create with multiple maps, arg and single mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.create :n
                                                           [:lhs1
                                                            :rhs1
                                                            "Description 1"
                                                            {:buffer 0}]
                                                           [:lhs2
                                                            :rhs2
                                                            "Description 2"])
                                               true))))
            (it "create with multiple maps, arg and multiple mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.create [:n :v]
                                                           [:lhs1
                                                            :rhs1
                                                            "Description 1"
                                                            {:buffer 0}]
                                                           [:lhs2
                                                            :rhs2
                                                            "Description 2"])
                                               true))))))
