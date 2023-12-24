(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros map :nvim-anisole.macros.maps)

(describe "Set single map macro:"
          (fn []
            (it "set-map with no arg and single mode"
                (fn []
                  (assert.are.same "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:desc \"Description\"})"
                                   (macrodebug (map.set-map :n :lhs :rhs
                                                            :Description)
                                               true))))
            (it "set-map with no arg and multiple modes"
                (fn []
                  (assert.are.same "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:desc \"Description\"})"
                                   (macrodebug (map.set-map [:n :v] :lhs :rhs
                                                            :Description)
                                               true))))
            (it "set-map with arg and single mode"
                (fn []
                  (assert.are.same "(vim.keymap.set \"n\" \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
                                   (macrodebug (map.set-map :n :lhs :rhs
                                                            :Description
                                                            {:buffer 0})
                                               true))))
            (it "set-map with arg and multiple modes"
                (fn []
                  (assert.are.same "(vim.keymap.set [\"n\" \"v\"] \"lhs\" \"rhs\" {:buffer 0 :desc \"Description\"})"
                                   (macrodebug (map.set-map [:n :v] :lhs :rhs
                                                            :Description
                                                            {:buffer 0})
                                               true))))))

(describe "Set multiple map macro:"
          (fn []
            (it "set-maps with no arg and single mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.set-maps :n
                                                             [:lhs1
                                                              :rhs1
                                                              "Description 1"]
                                                             [:lhs2
                                                              :rhs2
                                                              "Description 2"])
                                               true))))
            (it "set-maps with no arg and multiple mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.set-maps [:n :v]
                                                             [:lhs1
                                                              :rhs1
                                                              "Description 1"]
                                                             [:lhs2
                                                              :rhs2
                                                              "Description 2"])
                                               true))))
            (it "set-maps with arg and single mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set \"n\" \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set \"n\" \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.set-maps :n
                                                             [:lhs1
                                                              :rhs1
                                                              "Description 1"
                                                              {:buffer 0}]
                                                             [:lhs2
                                                              :rhs2
                                                              "Description 2"])
                                               true))))
            (it "set-maps with arg and multiple mode"
                (fn []
                  (assert.are.same "(do (vim.keymap.set [\"n\" \"v\"] \"lhs1\" \"rhs1\" {:buffer 0 :desc \"Description 1\"}) (do (vim.keymap.set [\"n\" \"v\"] \"lhs2\" \"rhs2\" {:desc \"Description 2\"})))"
                                   (macrodebug (map.set-maps [:n :v]
                                                             [:lhs1
                                                              :rhs1
                                                              "Description 1"
                                                              {:buffer 0}]
                                                             [:lhs2
                                                              :rhs2
                                                              "Description 2"])
                                               true))))))
