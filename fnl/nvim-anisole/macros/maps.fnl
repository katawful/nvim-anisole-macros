;;; Macro file for key maps
;; [nfnl-macro]

;; Module
(local M {:private {}})

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

(lambda M.private.create-single-map [modes lhs rhs desc ?args]
  "Internal Macro -- Creates a map

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@lhs: |string| # Left hand of keymap
@rhs: |string| or |function| or |table| # Right hand of keymap
@desc: |string| # Description of keymap
@?args(optional): |opt table| # Opts table for vim.keymap.set
```"
  (assert-arg modes [:string :table] 1 :create-single-map)
  (assert-arg lhs :string 2 :create-single-map)
  (assert-arg rhs [:string :function :table] 3 :create-single-map)
  (assert-arg desc :string 4 :create-single-map)
  (let [opts# {}]
    (tset opts# :desc desc)
    (when ?args
      (assert-arg ?args :table 5 :create-single-map)
      (each [key val (pairs ?args)]
        (tset opts# key val)))
    `(vim.keymap.set ,modes ,lhs ,rhs ,opts#)))

(lambda M.private.create-multi-map [modes ...]
  "Internal Macro -- Creates multiple maps

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@... # Stored as sequential tables, each table is the arguments of `create-single-map`
       minus the `modes` argument
```"
  (assert-arg modes [:string :table] 1 :create-single-map)
  (let [maps# [...]
        size# (length maps#)]
    (assert-compile (> size# 0)
                    (string.format "\"create-multi-map\" -- Expected a table of keymaps, received nil")
                    maps#)
    ;; Recurse through macro to make static, starting from first element

    (fn recurse-output [map# i#]
      (if (>= size# i#)
          (let [current-map# (. map# i#)
                lhs# (. current-map# 1)
                rhs# (. current-map# 2)
                desc# (. current-map# 3)
                args# (?. current-map# 4)]
            ;; If at one, end of recurse. Finish macro
            (if (= size# i#)
                `(do
                   ,(M.private.create-single-map modes lhs# rhs# desc# args#)))
            `(do
               ,(M.private.create-single-map modes lhs# rhs# desc# args#)
               ,(recurse-output map# (+ i# 1))))))

    (when (> size# 0)
      (recurse-output maps# 1))))

(fn M.create [modes ...]
  "Macro -- Creates a map. Supports single and multiple map creations.

Arguments for single maps:

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@lhs: |string| # Left hand of keymap
@rhs: |string| or |function| or |table| # Right hand of keymap
@desc: |string| # Description of keymap
@?args(optional): |opt table| # Opts table for vim.keymap.set
```
Arguments for multiple maps:

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@... # Stored as sequential tables, each table is the arguments of single map mode
       minus the `modes` argument
```"
  (assert-arg modes [:string :table] 1 :create)
  (let [maps# [...]]
    (match (type (?. maps# 1))
      :string
      `,(M.private.create-single-map modes (. maps# 1) (. maps# 2) (. maps# 3)
                                     (. maps# 4))
      :table `,(M.private.create-multi-map modes ...))))

M
