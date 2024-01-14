(local {: describe : it} (require :plenary.busted))
(local assert (require :luassert.assert))
(import-macros lazy :nvim-anisole.macros.lazy)

(describe "Spec repo calls:"
          (fn []
            (it "spec.repo.github calls"
                #(assert.are.same "(do (local test {}) (tset test 1 \"name\") (do (tset test 1 \"name\") test))"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.github :name)
                                                              (lazy.spec.repo.gh :name))
                                              true)))
            (it "spec.repo.directory calls"
                #(assert.are.same "(do (local test {}) (tset test \"dir\" \"name\") (do (tset test \"dir\" \"name\") test))"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.directory :name)
                                                              (lazy.spec.repo.dir :name))
                                              true)))
            (it "spec.repo.url call"
                #(assert.are.same "(do (local test {}) (tset test \"url\" \"name\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.url :name))
                                              true)))))

(describe "Spec name call:"
          (fn []
            (it "spec.name call"
                #(assert.are.same "(do (local test {}) (tset test \"name\" \"name\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.name :name))
                                              true)))))

(describe "Spec dev call:"
          (fn []
            (it "spec.dev call"
                #(assert.are.same "(do (local test {}) (tset test \"dev\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.dev? true))
                                              true)))))

(describe "Spec lazy call:"
          (fn []
            (it "spec.lazy call"
                #(assert.are.same "(do (local test {}) (tset test \"lazy\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.lazy? true))
                                              true)))))

(describe "Spec enable call:"
          (fn []
            (it "spec.enable call"
                #(assert.are.same "(do (local test {}) (tset test \"enabled\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.enable? true))
                                              true)))))

(describe "Spec condition call:"
          (fn []
            (it "spec.condition call"
                #(assert.are.same "(do (local test {}) (tset test \"cond\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.condition true))
                                              true)))))

(describe "Spec dependencies call:"
          (fn []
            (it "spec.dependencies call with plugin name call"
                #(assert.are.same "(do (local test {}) (tset test \"dependencies\" [\"plugin-name\"]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.dependencies [:plugin-name]))
                                              true)))
            (it "spec.dependencies call with spec call"
                #(assert.are.same "(do (local test {}) (tset test \"dependencies\" [[\"plugin/name\"]]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.dependencies [[:plugin/name]]))
                                              true)))))

(describe "Spec startup call:"
          (fn []
            (it "spec.startup call"
                #(assert.are.same "(do (local test {}) (tset test \"init\" (fn [])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.startup (fn [])))
                                              true)))))

(describe "Spec opts table call:"
          (fn []
            (it "spec.opts call with table"
                #(assert.are.same "(do (local test {}) (tset test \"opts\" {:key value}) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.opts {:key value}))
                                              true)))
            (it "spec.opts call with function"
                #(assert.are.same "(do (local test {}) (tset test \"opts\" (fn [plugin opts] {:key value})) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.opts (fn [plugin
                                                                                   opts]
                                                                                {:key value})))
                                              true)))))

(describe "Spec config call:"
          (fn []
            (it "spec.config call with true"
                #(assert.are.same "(do (local test {}) (tset test \"config\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.config true))
                                              true)))
            (it "spec.config call with function"
                #(assert.are.same "(do (local test {}) (tset test \"config\" (fn [plugin opts])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.config (fn [plugin
                                                                                     opts])))
                                              true)))))

(describe "Spec module call:"
          (fn []
            (it "spec.module call"
                #(assert.are.same "(do (local test {}) (tset test \"main\" \"name\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.module :name))
                                              true)))))

(describe "Spec build call:"
          (fn []
            (it "spec.build call with Vim function"
                #(assert.are.same "(do (local test {}) (tset test \"build\" \":function\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.build ":function"))
                                              true)))
            (it "spec.build call with Lua function"
                #(assert.are.same "(do (local test {}) (tset test \"build\" (fn [plugin])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.build (fn [plugin])))
                                              true)))
            (it "spec.build call with sequential table"
                #(assert.are.same "(do (local test {}) (tset test \"build\" [\":function1\" \":function2\"]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.build [":function1"
                                                                                ":function2"]))
                                              true)))))

(describe "Spec repo branch/tag/version/commit call:"
          (fn []
            (it "spec.repo.branch call"
                #(assert.are.same "(do (local test {}) (tset test \"branch\" \"branch\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.branch :branch))
                                              true)))
            (it "spec.repo.tag call"
                #(assert.are.same "(do (local test {}) (tset test \"tag\" \"tag\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.tag :tag))
                                              true)))
            (it "spec.repo.version call"
                #(assert.are.same "(do (local test {}) (tset test \"version\" \"version\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.version :version))
                                              true)))
            (it "spec.repo.commit call"
                #(assert.are.same "(do (local test {}) (tset test \"commit\" \"commit\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.commit :commit))
                                              true)))
            (it "spec.repo.submodules? call"
                #(assert.are.same "(do (local test {}) (tset test \"submodules\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.repo.submodules? true))
                                              true)))))

(describe "Spec load event/key/cmd/ft calls:"
          (fn []
            (it "spec.load.event call with string event"
                #(assert.are.same "(do (local test {}) (tset test \"event\" \"Event\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.event :Event))
                                              true)))
            (it "spec.load.event call with table of string events"
                #(assert.are.same "(do (local test {}) (tset test \"event\" [\"Event1\" \"Event2\"]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.event [:Event1
                                                                                     :Event2]))
                                              true)))
            (it "spec.load.event call with function event"
                #(assert.are.same "(do (local test {}) (tset test \"event\" (fn [plugin event])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.event (fn [plugin
                                                                                         event])))
                                              true)))
            (it "spec.load.event call with event/pattern table"
                #(assert.are.same "(do (local test {}) (tset test \"event\" [[\"Event1\" \"*\"] [\"Event2\" \"*.toml\"]]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.event [[:Event1
                                                                                      "*"]
                                                                                     [:Event2
                                                                                      :*.toml]]))
                                              true)))
            (it "spec.load.command call with string command"
                #(assert.are.same "(do (local test {}) (tset test \"cmd\" \"Command\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.command :Command))
                                              true)))
            (it "spec.load.command call with table of string commands"
                #(assert.are.same "(do (local test {}) (tset test \"cmd\" [\"Command1\" \"Command2\"]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.command [:Command1
                                                                                       :Command2]))
                                              true)))
            (it "spec.load.command call with function command"
                #(assert.are.same "(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.command (fn [plugin
                                                                                           command])))
                                              true)))
            (it "spec.load.cmd call alias"
                #(assert.are.same "(do (local test {}) (tset test \"cmd\" (fn [plugin command])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.cmd (fn [plugin
                                                                                       command])))
                                              true)))
            (it "spec.load.filetype call with string filetype"
                #(assert.are.same "(do (local test {}) (tset test \"ft\" \"filetype\") test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.filetype :filetype))
                                              true)))
            (it "spec.load.filetype call with table of string filetypes"
                #(assert.are.same "(do (local test {}) (tset test \"ft\" [\"filetype1\" \"filetype2\"]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.filetype [:filetype1
                                                                                        :filetype2]))
                                              true)))
            (it "spec.load.filetype call with function filetype"
                #(assert.are.same "(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.filetype (fn [plugin
                                                                                            filetype])))
                                              true)))
            (it "spec.load.ft call alias"
                #(assert.are.same "(do (local test {}) (tset test \"ft\" (fn [plugin filetype])) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.ft (fn [plugin
                                                                                      filetype])))
                                              true)))
            (it "spec.load.map with multiple self contained maps"
                #(assert.are.same "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}
 {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :mode \"i\"}]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.map [:n
                                                                                   :lhs
                                                                                   :rhs
                                                                                   :desc
                                                                                   {:ft :toml}]
                                                                                  [:i
                                                                                   :lhs
                                                                                   :rhs
                                                                                   :desc]))
                                              true)))
            (it "spec.load.map with mode prefixed multiple maps"
                #(assert.are.same "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}
 {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode \"n\"}]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.map :n
                                                                                  [:lhs
                                                                                   :rhs
                                                                                   :desc
                                                                                   {:ft :toml}]
                                                                                  [:lhs
                                                                                   :rhs
                                                                                   :desc
                                                                                   {:ft :toml}]))
                                              true)))
            (it "spec.load.map with multiple modes prefixed multiple maps"
                #(assert.are.same "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}
 {1 \"lhs\" 2 \"rhs\" :desc \"desc\" :ft \"toml\" :mode [\"n\" \"v\"]}]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.map [:n
                                                                                   :v]
                                                                                  [:lhs
                                                                                   :rhs
                                                                                   :desc
                                                                                   {:ft :toml}]
                                                                                  [:lhs
                                                                                   :rhs
                                                                                   :desc
                                                                                   {:ft :toml}]))
                                              true)))
            (it "spec.load.map with mode and single map"
                #(assert.are.same "(do (local test {}) (tset test \"keys\" [{1 \"lhs\" 2 \"rhs\" :buffer 0 :desc \"desc\" :ft \"toml\" :mode \"n\" :remap true}]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.map :n
                                                                                  :lhs
                                                                                  :rhs
                                                                                  :desc
                                                                                  {:ft :toml
                                                                                   :buffer 0
                                                                                   :remap true}))
                                              true)))
            (it "spec.load.map with multiple modes and single map"
                #(assert.are.same "(do (local test {}) (tset test \"keys\" [{1 \"lhs\"
  2 \"rhs\"
  :buffer 0
  :desc \"desc\"
  :ft \"toml\"
  :mode [\"n\" \"v\"]
  :remap true}]) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.map [:n
                                                                                   :v]
                                                                                  :lhs
                                                                                  :rhs
                                                                                  :desc
                                                                                  {:ft :toml
                                                                                   :buffer 0
                                                                                   :remap true}))
                                              true)))))

(describe "Spec load module call:"
          (fn []
            (it "spec.load.module? call"
                #(assert.are.same "(do (local test {}) (tset test \"module\" true) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.load.module? true))
                                              true)))))

(describe "Spec priority call:"
          (fn []
            (it "spec.priority call"
                #(assert.are.same "(do (local test {}) (tset test \"priority\" 1000) test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.priority 1000))
                                              true)))))

(describe "Spec optional call:"
          (fn []
            (it "spec.optional call"
                #(assert.are.same "(do (local test {}) nil test)"
                                  (macrodebug (lazy.spec.init test
                                                              (lazy.spec.optional true))
                                              true)))))
