;;; Macro file for option management
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

(fn scope [opt]
  "Gets the scope of an option"
  (let [opt# (tostring opt)]
    (. (vim.api.nvim_get_option_info2 opt# {}) :scope)))

(fn set-opt [option value ?flag]
  "Macro -- Sets an option
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option"
  (assert-arg option [:string :table] 1 :set-opt)
  (if ?flag
      (do
        (assert-arg ?flag :string 3 :set-opt)
        (match ?flag
          :append (let [opt# (tostring option)]
                    `(: (. vim.opt ,opt#) :append ,value))
          :prepend (let [opt# (tostring option)]
                     `(: (. vim.opt ,opt#) :prepend ,value))
          :remove (let [opt# (tostring option)]
                    `(: (. vim.opt ,opt#) :remove ,value))
          _ (assert-compile nil
                            (string.format "\"set-opt\" -- Expected append, prepend, or remove, got '%s'"
                                           ?flag)
                            ?flag)))
      (let [opt# (tostring option)]
        `(tset vim.opt ,opt# ,value))))

(fn set-local-opt [option value ?flag]
  "Macro -- set a local option
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option"
  (assert-arg option [:string :table] 1 :set-local-opt)
  (assert-compile (or (= (scope option) :win) (= (scope option) :buf))
                  (string.format "\"set-local-opt\" -- Expected local option, got %s option"
                                 (scope option)) option)
  (if ?flag
      (do
        (assert-arg ?flag :string 3 :set-local-opt)
        (match ?flag
          :append (let [opt# (tostring option)]
                    `(: (. vim.opt_local ,opt#) :append ,value))
          :prepend (let [opt# (tostring option)]
                     `(: (. vim.opt_local ,opt#) :prepend ,value))
          :remove (let [opt# (tostring option)]
                    `(: (. vim.opt_local ,opt#) :remove ,value))
          _ (assert-compile nil
                            (string.format "\"set-local-opt\" -- Expected append, prepend, or remove, got '%s'"
                                           ?flag)
                            ?flag)))
      (let [opt# (tostring option)]
        `(tset vim.opt_local ,opt# ,value))))

(fn set-global-opt [option value ?flag]
  "Macro -- set a global option
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option"
  (assert-arg option [:string :table] 1 :set-global-opt)
  (assert-compile (= (scope option) :global)
                  (string.format "\"set-global-opt\" -- Expected global option, got %s option"
                                 (scope option)) option)
  (if ?flag
      (do
        (assert-arg ?flag :string 3 :set-global-opt)
        (match ?flag
          :append (let [opt# (tostring option)]
                    `(: (. vim.opt_global ,opt#) :append ,value))
          :prepend (let [opt# (tostring option)]
                     `(: (. vim.opt_global ,opt#) :prepend ,value))
          :remove (let [opt# (tostring option)]
                    `(: (. vim.opt_global ,opt#) :remove ,value))
          _ (assert-compile nil
                            (string.format "\"set-global-opt\" -- Expected append, prepend, or remove, got '%s'"
                                           ?flag)
                            ?flag)))
      (let [opt# (tostring option)]
        `(tset vim.opt_global ,opt# ,value))))

(fn set-opt-auto [option value ?flag]
  "Macro -- set an option with auto scope
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option

Generally, 'set' from Vim will try to use the global scope for anything.
If you want a local scope you have to use 'setlocal'. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options
(set-opt-auto spell true) -> will set spell locally
(set-opt-auto mouse :nvi) -> will set mouse globally
(set-opt spell true)      -> will set spell globally

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :set-opt-auto)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"set-opt-auto\" -- Expected append, prepend, or remove; got '%s'"
                                     ?flag) ?flag)))
  (let [scope# (scope option)
        opt# (tostring option)]
    (if ?flag
        (match scope#
          :win `(: (. vim.opt_local ,opt#) ,?flag ,value)
          :buf `(: (. vim.opt_local ,opt#) ,?flag ,value)
          :global `(: (. vim.opt_global ,opt#) ,?flag ,value))
        (match scope#
          :win `(tset vim.opt_local ,opt# ,value)
          :buf `(tset vim.opt_local ,opt# ,value)
          :global `(tset vim.opt_global ,opt# ,value)))))

(fn set-opts [options ?flag]
  "Macro -- plural of set-opt
Takes key-value table of options
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option"
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :set-opts)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"set-opts\" -- Expected append, prepend, or remove; got '%s'"
                                     ?flag) ?flag)))
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs options)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. options v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all options are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [option# (. (. key# i#) 1)
                ; each option is a table, name is first value
                value# (. val# i#)]
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                (if ?flag
                    `(do
                       (: (. vim.opt ,option#) ,?flag ,value#))
                    `(do
                       (tset vim.opt ,option# ,value#))))
            ;; For recursion
            (if ?flag
                `(do
                   (: (. vim.opt ,option#) ,?flag ,value#)
                   ,(recurse-output key# val# (- i# 1)))
                `(do
                   (tset vim.opt ,option# ,value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(fn set-local-opts [options ?flag]
  "Macro -- plural of set-local-opt
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option

Takes key-value table of options"
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :set-local-opts)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"set-local-opts\" -- Expected append, prepend, or remove; got '%s'"
                                     ?flag) ?flag)))
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs options)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. options v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all options are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [option# (. (. key# i#) 1)
                ; each option is a table, name is first value
                value# (. val# i#)]
            (assert-compile (or (= (scope option#) :win)
                                (= (scope option#) :buf))
                            (string.format "\"set-local-opts\" -- Expected local option, got %s option"
                                           (scope option#))
                            option#)
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                (if ?flag
                    `(do
                       (: (. vim.opt_local ,option#) ,?flag ,value#))
                    `(do
                       (tset vim.opt_local ,option# ,value#))))
            ;; For recursion
            (if ?flag
                `(do
                   (: (. vim.opt_local ,option#) ,?flag ,value#)
                   ,(recurse-output key# val# (- i# 1)))
                `(do
                   (tset vim.opt_local ,option# ,value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(fn set-global-opts [options ?flag]
  "Macro -- plural of set-global-opt
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option

Takes key-value table of options"
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :set-global-opts)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"set-global-opts\" -- Expected append, prepend, or remove; got '%s'"
                                     ?flag) ?flag)))
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs options)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. options v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all options are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [option# (. (. key# i#) 1)
                ; each option is a table, name is first value
                value# (. val# i#)]
            (assert-compile (= (scope option#) :global)
                            (string.format "\"set-global-opts\" -- Expected global option, got %s option"
                                           (scope option#))
                            option#)
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                (if ?flag
                    `(do
                       (: (. vim.opt_global ,option#) ,?flag ,value#))
                    `(do
                       (tset vim.opt_global ,option# ,value#))))
            ;; For recursion
            (if ?flag
                `(do
                   (: (. vim.opt_global ,option#) ,?flag ,value#)
                   ,(recurse-output key# val# (- i# 1)))
                `(do
                   (tset vim.opt_global ,option# ,value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(fn set-opts-auto [options ?flag]
  "Macro -- plural of set-opt-auto
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option

Takes key-value table of options
Generally, 'set' from Vim will try to use the global scope for anything.
If you want a local scope you have to use 'setlocal'. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options
(set-opt-auto spell true) -> will set spell locally
(set-opt-auto mouse :nvi) -> will set mouse globally
(set-opt spell true)      -> will set spell globally

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :set-opts-auto)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"set-opts-auto\" -- Expected append, prepend, or remove; got '%s'"
                                     ?flag) ?flag)))
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs options)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. options v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all options are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [option# (. (. key# i#) 1)
                ; each option is a table, name is first value
                value# (. val# i#)
                scope# (scope option#)]
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                (if (= scope# :global)
                    (if ?flag
                        `(do
                           (: (. vim.opt_global ,option#) ,?flag ,value#))
                        `(do
                           (tset vim.opt_global ,option# ,value#)))
                    (if ?flag
                        `(do
                           (: (. vim.opt_local ,option#) ,?flag ,value#))
                        `(do
                           (tset vim.opt_local ,option# ,value#)))))
            ;; For recursion
            (if (= scope# :global)
                (if ?flag
                    `(do
                       (: (. vim.opt_global ,option#) ,?flag ,value#)
                       ,(recurse-output key# val# (- i# 1)))
                    `(do
                       (tset vim.opt_global ,option# ,value#)
                       ,(recurse-output key# val# (- i# 1))))
                (if ?flag
                    `(do
                       (: (. vim.opt_local ,option#) ,?flag ,value#)
                       ,(recurse-output key# val# (- i# 1)))
                    `(do
                       (tset vim.opt_local ,option# ,value#)
                       ,(recurse-output key# val# (- i# 1))))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(fn get-opt [option]
  "Macro -- get an option's value
@option: |object| or |string| # The option, can be written literally"
  (let [opt# (tostring option)]
    `(: (. vim.opt ,opt#) :get)))

(fn set-var [scope variable value]
  "Macro -- set a Vim variable
@scope: |string| # The scope of the variable
@variable: |object| or |string| # The variable itself. Can be string or literal object
@value: |any| # The value of the option

For b, w, and t scope, they can be indexed like (. b 1) for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"set-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(tset (. (. vim ,matched-scope#) ,index#) ,var# ,value))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"set-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(tset (. vim ,scope#) ,var# ,value)))))

(fn set-vars [scope variables]
  "Macro -- plural of set-var for one scope
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value"
  (let [output# [] ;; Put keys and vals into sequential table
        ;; We sort the keys and then use the sorted keys to build the seq val table
        ;; This helps keep the macro consistent in the compiled Lua
        key# (do
               (local out# [])
               (each [k# v# (pairs variables)]
                 (table.insert out# k#))
               (table.sort out#)
               out#)
        val# (do
               (local out# [])
               (each [k# v# (ipairs key#)]
                 (table.insert out# (. variables v#)))
               out#)
        size# (length key#)]
    ;; We recurse through this macro until all variables are placed

    (fn recurse-output [key# val# i#]
      ;; Don't go past index
      (if (< 0 i#)
          (let [variable# (. key# i#)
                ; each variable is a table, name is first value
                value# (. val# i#)]
            ;; If at one, we are at the end of the recurse and can finish this call
            (if (= 1 i#)
                `,(set-var scope variable# value#)
                ;; For recursion
                `(do
                   ,(set-var scope variable# value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(fn get-var [scope variable]
  "Macro -- get the value of a Vim variable
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value"
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"get-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(. (. (. vim ,matched-scope#) ,index#) ,var#))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"get-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(. (. vim ,scope#) ,var#)))))

{: get-opt
 : get-var
 : set-global-opt
 : set-global-opts
 : set-local-opt
 : set-local-opts
 : set-opt-auto
 : set-opts
 : set-opts-auto
 : set-var
 : set-vars
 : set-opt}
