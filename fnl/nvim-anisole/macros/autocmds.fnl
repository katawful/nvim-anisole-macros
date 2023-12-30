;;; Macro file for autocommands
;; [nfnl-macro]

;; Module
(local M {:group {} :cmd {}})

(fn assert-arg [var# var-type# var-pos# macro#]
  "FN -- Handle `assert-compile` simpler"
  (if (= (type var-type#) :table)
      (let [type-results# (do
                            (local out# [])
                            (each [_ v# (ipairs var-type#)]
                              (if (= (type var#) v#)
                                  (table.insert out# true)
                                  false))
                            out#)
            possible-type-string# (do
                                    (var out# "")
                                    (each [_ v# (ipairs var-type#)]
                                      (set out# (.. out# v# " or ")))
                                    (set out# (string.sub out# 1 -5))
                                    out#)]
        (assert-compile (do
                          (var truthy# false)
                          (each [_ v# (ipairs type-results#)]
                            (if v#
                                (set truthy# true)))
                          truthy#)
                        (string.format "\"%s\" -- Expected %s for arg #%s, received %s"
                                       (tostring macro#) possible-type-string#
                                       var-pos# (type var#))))
      (assert-compile (= (type var#) var-type#)
                      (string.format "\"%s\" -- Expected %s for arg #%s, received %s"
                                     (tostring macro#) var-type# var-pos#
                                     (type var#)))))

(lambda M.cmd.create [events pattern callback desc ?args]
  "Macro -- Creates an autocmd

```
@events: |string| or |seq of strings| # The autocmd event(s) to use
@pattern: |string| or |seq of strings| # The file pattern(s) to match against
@callback: |function| or |string| # The function or vimscript that gets called on fire of autocmd
@desc: |string| # Description of autocmd
@?args: |opt table| # Table of options for `vim.api.nvim_create_autocmd`
```"
  (assert-arg events [:string :table] 1 :cmd.create)
  (assert-arg pattern [:string :table] 2 :cmd.create)
  (assert-arg callback [:table :function :string] 3 :cmd.create)
  (assert-arg desc :string 4 :cmd.create)
  (let [opts# {}
        call-type# (if (= (type callback) :string) :command :callback)] ; if no desc string, just insert that table
    ;; if a desc string, add them all to the opts table
    (tset opts# :desc desc)
    (tset opts# call-type# callback)
    (tset opts# :pattern pattern)
    (when ?args
      (assert-arg ?args :table 5 :cmd.create)
      (each [k# v# (pairs ?args)]
        (tset opts# k# v#)))
    `(vim.api.nvim_create_autocmd ,events ,opts#)))

(lambda M.group.define [name ?no-clear]
  "Macro -- Defines an auto group and returns the id

```
@name: |string| # Name of group
@?no-clear(optional): |boolean| # If true, don't clear out group. Opposite of default
```"
  (assert-arg name :string 1 :group.define)
  (when ?no-clear
    (assert-arg ?no-clear :boolean 2 :group.define))
  (if ?no-clear
      `(vim.api.nvim_create_augroup ,name {:clear true})
      `(vim.api.nvim_create_augroup ,name {:clear false})))

(lambda M.group.fill [group ...]
  "Macro -- Fills cmd.create calls with an augroup

```
@group: |number| # id of augroup
@... # `cmd.create` calls only
```"
  (assert-arg group :number 1 :group.fill)
  (let [autocmds# [...]
        size# (length autocmds#)]
    ;; Recurse through macro to make static

    (fn recurse-output [autocmd# i#]
      (let [assertion (?. (?. autocmd# i#) 1)]
        (if assertion
            (assert-compile (string.find (tostring assertion) :cmd.create)
                            (string.format "\"do-augroup\" -- Expected `cmd.create` only, received %s"
                                           (tostring assertion)))))
      (if (< 0 i#)
          (let [current-autocmd# (. autocmd# i#)
                events# (. current-autocmd# 2)
                pattern# (. current-autocmd# 3)
                callback# (. current-autocmd# 4)
                desc# (. current-autocmd# 5)
                args# (if (?. current-autocmd# 6)
                          (. current-autocmd# 6)
                          {})]
            ;; Insert group to opts table
            (tset args# :group group)
            ;; If at one, end of recurse. Finish macro
            (if (= 1 i#)
                `(do
                   ,(M.cmd.create events# pattern# callback# desc# args#)))
            `(do
               ,(M.cmd.create events# pattern# callback# desc# args#)
               ,(recurse-output autocmd# (- i# 1))))))

    (recurse-output autocmds# size#)))

(lambda M.cmd.clear! [tbl]
  "Macro -- Clears autocommands

```
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds
```"
  (assert-arg tbl :table 1 :cmd.clear!)
  `(vim.api.nvim_clear_autocmds ,tbl))

(lambda M.cmd.clear<-event! [events]
  "Macro -- Clears autocommands from events

```
@events: |string| or |seq table| # Events
```"
  (assert-arg events [:string :table] 1 :cmd.clear<-event!)
  `(vim.api.nvim_clear_autocmds {:event ,events}))

(lambda M.cmd.clear<-pattern! [patterns]
  "Macro -- Clears autocommands from patterns

```
@patterns: |string| or |seq table| # File patterns to match
```"
  (assert-arg patterns [:string :table] 1 :cmd.clear<-pattern!)
  `(vim.api.nvim_clear_autocmds {:pattern ,patterns}))

(lambda M.cmd.clear<-buffer! [buffers]
  "Macro -- Clears autocommands from buffers

```
@buffers: |number| or |boolean| # Buffer number or current buffer
```"
  (assert-arg buffers [:number :boolean] 1 :cmd.clear<-buffer!)
  (let [buffer# (if (= buffers true) 0
                    buffers)]
    `(vim.api.nvim_clear_autocmds {:buffer ,buffer#})))

(lambda M.cmd.clear<-group! [groups]
  "Macro -- Clears autocommands from group

```
@groups: |string| or |number| # Augroups
```"
  (assert-arg groups [:string :number] 1 :cmd.clear<-group!)
  `(vim.api.nvim_clear_autocmds {:group ,groups}))

(lambda M.group.delete! [augroup]
  "Macro -- Deletes augroup by id or name

```
@augroup: |string| or |number| # Augroup
```"
  (assert-arg augroup [:string :number] 1 :group.delete!)
  (if (= (type augroup) :string)
      `(vim.api.nvim_del_augroup_by_name ,augroup)
      `(vim.api.nvim_del_augroup_by_id ,augroup)))

(lambda M.cmd.get [tbl]
  "Macro -- Gets autocommands

```
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds
```"
  (assert-arg tbl :table 1 :cmd.get!)
  `(vim.api.nvim_get_autocmds ,tbl))

(lambda M.cmd.get<-group [groups]
  "Macro -- Gets autocommand from group

```
@groups: |string| or |number| # Augroups
```"
  (assert-arg groups [:string :number] 1 :cmd.get<-group!)
  `(vim.api.nvim_get_autocmds {:group ,groups}))

(lambda M.cmd.get<-pattern [patterns]
  "Macro -- Gets autocommands from patterns

```
@patterns: |string| or |seq table| # File patterns to match
```"
  (assert-arg patterns [:string :table] 1 :cmd.get<-pattern!)
  `(vim.api.nvim_get_autocmds {:pattern ,patterns}))

(lambda M.cmd.get<-event [events]
  "Macro -- Gets autocommands from events

```
@events: |string| or |seq table| # Events
```"
  (assert-arg events [:string :table] 1 :cmd.get<-event!)
  `(vim.api.nvim_get_autocmds {:event ,events}))

(lambda M.cmd.run [events ?args]
  "Macro -- Runs an autocommand

```
@events: |string| or |seq table| # Events
@?args: |key/val table| # Options table for vim.api.nvim_exec_autocmds
```"
  (assert-arg events [:string :table] 1 :cmd.run)
  (when ?args
    (assert-arg ?args :table 2 :cmd.run))
  (let [?args (if ?args ?args {})]
    `(vim.api.nvim_exec_autocmds ,events ,?args)))

M
