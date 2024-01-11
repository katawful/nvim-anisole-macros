(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros lazy :nvim-anisole.macros.lazy)

(describe "Spec repo calls:"
          (fn []
            (it "spec.init spec.repo.github calls"
                #(assert.are.same "(do (local test {}) (tset test 1 \"butts\") (do (tset test 1 \"butts\") test))"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.github :butts)
                                                              (lazy.spec.repo.gh :butts))
                                              true)))
            (it "spec.init spec.repo.directory calls"
                #(assert.are.same "(do (local test {}) (tset test \"dir\" \"butts\") (do (tset test \"dir\" \"butts\") test))"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.directory :butts)
                                                              (lazy.spec.repo.dir :butts))
                                              true)))
            (it "spec.init spec.repo.url call"
                #(assert.are.same "(do (local test {}) (tset test \"url\" \"butts\"))"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.url :butts))
                                              true)))))
