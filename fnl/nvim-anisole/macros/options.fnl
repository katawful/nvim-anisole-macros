;;; Macro file for option management
;; [nfnl-macro]

;; Module
(local M {:private {}})

(fn var-scope [list-item]
  "Group var scopes for easier management"
  (let [list-string (tostring list-item)]
    (if (or (= list-string :g) (= list-string :b) (= list-string :w)
            (= list-string :t) (= list-string :v) (= list-string :env))
        true
        false)))

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

(lambda M.private.set-opt-auto [option value ?flag]
  "Macro -- Sets an option with auto scope

```
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.private.set-opt-auto spell true)` -> will set spell locally   
`(M.private.set-opt-auto mouse :nvi)` -> will set mouse globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :private.set-opt-auto)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"private.set-opt-auto\" -- Expected append, prepend, or remove; got '%s'"
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

(lambda M.private.set-opts-auto [options ?flag]
  "Macro -- Plural of set-opt-auto

```
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Takes key-value table of options
Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.private.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs."
  (when ?flag
    (do
      (assert-arg ?flag :string 3 :private.set-opts-auto)
      (assert-compile (or (= ?flag :append) (= ?flag :prepend)
                          (= ?flag :remove))
                      (string.format "\"private.set-opts-auto\" -- Expected append, prepend, or remove; got '%s'"
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

(lambda M.private.set-var [scope variable value]
  "Macro -- Sets a Vim variable

```
@scope: |string| # The scope of the variable
@variable: |object| or |string| # The variable itself. Can be string or literal object
@value: |any| # The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"private.set-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(tset (. (. vim ,matched-scope#) ,index#) ,var# ,value))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"private.set-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(tset (. vim ,scope#) ,var# ,value)))))

(lambda M.private.set-vars [scope variables]
  "Macro -- Plural of private.set-var for one scope

```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
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
                `,(M.private.set-var scope variable# value#)
                ;; For recursion
                `(do
                   ,(M.private.set-var scope variable# value#)
                   ,(recurse-output key# val# (- i# 1)))))))

    ;; Start recurse
    (recurse-output key# val# size#)))

(lambda M.set [...]
  "Macro -- Sets one or multiple options or variables

Since this macro supports 4 different modes of operation, plus a flag for the option settings,
we need to handle all of those.

1. Single option -> `(set option value ?flag)`
2. Multiple options -> `(set {option1 value option2 value} ?flag)`
3. Single var -> `(set scope variable value)`
4. Multiple vars -> `(set scope {var1 value var2 value})`

1.
```
@option: |object| or |string| # The option, can be written literally
@value: |any| # The value of the option
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   


2.
```
@options: |key/val table| # The options, where the key is the option and val is the value
@?flag(optional): |string| # A flag (append, prepend, remove) for the option
```

Takes key-value table of options

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   

3.
```
@scope: |string| # The scope of the variable
@variable: |object| or |string| # The variable itself. Can be string or literal object
@value: |any| # The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

4.
```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.
"
  ;; Let's check to see what we have
  (let [lists [...]]
    (case (type (. lists 1))
      :string (do
                (if (var-scope (. lists 1))
                    (if (sym? (. lists 2))
                        `,(M.private.set-var (. lists 1) (. lists 2)
                                             (. lists 3))
                        `,(M.private.set-vars (. lists 1) (. lists 2)))))
      :table (do
               (if (list? (. lists 1))
                   (do
                     (if (sym? (. lists 2))
                         `,(M.private.set-var (. lists 1) (. lists 2)
                                              (. lists 3))
                         `,(M.private.set-vars (. lists 1) (. lists 2))))
                   (sym? (. lists 1))
                   `,(M.private.set-opt-auto (. lists 1) (. lists 2)
                                             (?. lists 3))
                   `,(M.private.set-opts-auto (. lists 1) (. lists 2)
                                              (?. lists 3)))))))

(lambda M.private.get-var [scope variable]
  "Macro -- Get the value of a Vim variable

```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [var# (tostring variable)]
    (if (list? scope)
        ;; need to destruct the indexed list and inject the appropriate table
        (let [matched-scope# (tostring (. scope 2))
              index# (. scope 3)]
          (assert-compile (or (= matched-scope# :b) (= matched-scope# :w)
                              (= matched-scope# :t))
                          (string.format "\"private.get-var\" -- Expected b, w, or t scope; got %s"
                                         matched-scope#)
                          matched-scope#)
          `(. (. (. vim ,matched-scope#) ,index#) ,var#))
        (let [scope# (tostring scope)]
          (assert-compile (or (= scope# :g) (= scope# :b) (= scope# :w)
                              (= scope# :t) (= scope# :v) (= scope# :env))
                          (string.format "\"private.get-var\" -- Expected b, w, or t scope; got %s"
                                         scope#)
                          scope#)
          `(. (. vim ,scope#) ,var#)))))

(lambda M.private.get-opt [option]
  "Macro -- Get an option's value

```
@option: |object| or |string| # The option, can be written literally
```"
  (let [opt# (tostring option)]
    `(: (. vim.opt ,opt#) :get)))

(lambda M.get [...]
  "Macro -- Gets the value of an option or a variable
1. Variable -> `(get scope variable)`
2. Option -> `(get option)`
```
@scope: |string| # The scope of the variable
@variables: |key/val table| # The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error."
  (let [lists [...]]
    (case (type (. lists 1))
      :string `,(M.private.get-var (. lists 1) (. lists 2))
      :table (do
               (if (list? (. lists 1))
                   `,(M.private.get-var (. lists 1) (. lists 2))
                   `,(M.private.get-opt (. lists 1)))))))

M
