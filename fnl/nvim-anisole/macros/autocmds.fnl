;;; Macro file for autocommands
;; [nfnl-macro]

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

(fn cre-autocmd! [events pattern callback desc args]
  "Macro -- Creates an autocmd
@events: |string| or |seq of strings| # The autocmd event(s) to use
@pattern: |string| or |seq of strings| # The file pattern(s) to match against
@callback: |function| or |string| # The function or vimscript that gets called on fire of autocmd
@desc: |string| # Description of autocmd
@args: |opt table| # Table of options for `vim.api.nvim_create_autocmd`"
  (assert-arg events [:string :table] 1 :cre-autocmd!)
  (assert-arg pattern [:string :table] 2 :cre-autocmd!)
  (assert-arg callback [:table :function :string] 3 :cre-autocmd!)
  (assert-arg desc :string 4 :cre-autocmd!)
  (assert-arg args :table 5 :cre-autocmd!)
  (let [opts# {}
        call-type# (if (= (type callback) :string) :command :callback)] ; if no desc string, just insert that table
    ;; if a desc string, add them all to the opts table
    (tset opts# :desc desc)
    (tset opts# call-type# callback)
    (tset opts# :pattern pattern)
    (each [key val (pairs args)]
      (tset opts# key val))
    `(vim.api.nvim_create_autocmd ,events ,opts#)))


(fn def-augroup! [name no-clear?]
  "Macro -- Defines an auto group and returns the id
@name: |string| # Name of group
@no-clear?(optional): |boolean| # If true, don't clear out group. Opposite of default"
  (assert-arg name :string 1 :def-augroup!)
  (when no-clear?
    (assert-arg no-clear? :boolean 2 :def-augroup!))
  (if no-clear?
      `(vim.api.nvim_create_augroup ,name {:clear true})
      `(vim.api.nvim_create_augroup ,name {:clear false})))

(fn do-augroup [group ...]
  "Macro -- Inserts an auto group into autocmd calls
@group: |number| # id of augroup
@... # `cre-autocmd!` calls only"
  (assert-arg group :number 1 :do-augroup)
  (let [autocmds# [...]
        size# (length autocmds#)]
    ;; Recurse through macro to make static

    (fn recurse-output [autocmd# i#]
      (let [assertion (?. (?. autocmd# i#) 1)]
        (if assertion
            (assert-compile (string.find (tostring assertion) "cre%-autocmd!")
                            (string.format "\"do-augroup\" -- Expected `cre-autocmd!` only, received %s"
                                           (tostring assertion)))))
      (if (< 0 i#)
          (let [current-autocmd# (. autocmd# i#)
                events# (. current-autocmd# 2)
                pattern# (. current-autocmd# 3)
                callback# (. current-autocmd# 4)
                desc# (. current-autocmd# 5)
                args# (. current-autocmd# 6)]
            ;; Insert group to opts table
            (tset args# :group group)
            ;; If at one, end of recurse. Finish macro
            (if (= 1 i#)
                `(do
                   ,(cre-autocmd! events# pattern# callback# desc# args#)))
            `(do
               ,(cre-autocmd! events# pattern# callback# desc# args#)
               ,(recurse-output autocmd# (- i# 1))))))

    (recurse-output autocmds# size#)))

(fn cle-autocmd! [tbl]
  "Macro -- clear autocommands
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds"
  (assert-arg tbl :table 1 :cle-autocmd!)
  `(vim.api.nvim_clear_autocmds ,tbl))

(fn cle-autocmd<-event! [events]
  "Macro -- clear autocommands from events
@events: |string| or |seq table| # Events"
  (assert-arg events [:string :table] 1 :cle-autocmd<-event!)
  `(vim.api.nvim_clear_autocmds {:event ,events}))

(fn cle-autocmd<-pattern! [patterns]
  "Macro -- clear autocommands from patterns
@patterns: |string| or |seq table| # File patterns to match"
  (assert-arg patterns [:string :table] 1 :cle-autocmd<-pattern!)
  `(vim.api.nvim_clear_autocmds {:pattern ,patterns}))

(fn cle-autocmd<-buffer! [buffers]
  "Macro -- clear autocommands from buffers
@buffers: |number| or |boolean| # Buffer number or current buffer"
  (assert-arg buffers [:number :boolean] 1 :cle-autocmd!<-buffer)
  (let [buffer# (if (= buffers true) 0
                    buffers)]
    `(vim.api.nvim_clear_autocmds {:buffer ,buffer#})))

(fn cle-autocmd<-group! [groups]
  "Macro -- clear autocommands from group
@groups: |string| or |number| # Augroups"
  (assert-arg groups [:string :number] 1 :cle-autocmd<-group!)
  `(vim.api.nvim_clear_autocmds {:group ,groups}))

(fn del-augroup! [augroup]
  "Macro -- delete augroup by augroup or name
@augroup: |string| or |number| # Augroup"
  (assert-arg augroup [:string :number] 1 :del-augroup!)
  (if (= (type augroup) :string)
      `(vim.api.nvim_del_augroup_by_name ,augroup)
      `(vim.api.nvim_del_augroup_by_id ,augroup)))

(fn get-autocmd [tbl]
  "Macro -- get autocommands
@tbl: |table| # Options table for vim.api.nvim_clear_autocmds"
  (assert-arg tbl :table 1 :cle-autocmd!)
  `(vim.api.nvim_get_autocmds ,tbl))

(fn get-autocmd<-group [groups]
  "Macro -- get autocommand from group
@groups: |string| or |number| # Augroups"
  (assert-arg groups [:string :number] 1 :cle-autocmd<-group!)
  (assert-compile (or (= (type groups) :string) (= (type groups) :number))
                  (.. "Expected string or number, got " (type groups)) groups)
  `(vim.api.nvim_get_autocmds {:group ,groups}))

(fn get-autocmd<-pattern [patterns]
  "Macro -- get autocommands from patterns
@patterns: |string| or |seq table| # File patterns to match"
  (assert-arg patterns [:string :table] 1 :cle-autocmd<-pattern!)
  `(vim.api.nvim_get_autocmds {:pattern ,patterns}))

(fn get-autocmd<-event [events]
  "Macro -- get autocommands from events
@events: |string| or |seq table| # Events"
  (assert-arg events [:string :table] 1 :cle-autocmd<-event!)
  `(vim.api.nvim_get_autocmds {:event ,events}))

(fn do-autocmd [events ?opts]
  "Macro -- do autocommand
@events: |string| or |seq table| # Events
@?opts: |key/val table| # Options table for vim.api.nvim_exec_autocmds"
  (assert-arg events [:string :table] 1 :do-autocmd)
  (let [opts (if (= ?opts nil)
                 {}
                 ?opts)]
    (assert-compile (or (not ?opts) (= (type opts) :table))
                    (.. "\"do-autocmd\" -- Expected table for arg #2, got " (type opts)) opts)
    `(vim.api.nvim_exec_autocmds ,events ,opts)))

{: cle-autocmd!
 : cle-autocmd<-event!
 : cle-autocmd<-pattern!
 : cle-autocmd<-buffer!
 : cle-autocmd<-group!
 : get-autocmd
 : get-autocmd<-event
 : get-autocmd<-pattern
 : get-autocmd<-group
 : do-autocmd
 : cre-autocmd!
 : do-augroup
 : del-augroup!
 : def-augroup!}
