;;; Macro file for key maps
;; [nfnl-macro]

;; Module
(local M {})

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

; (map.create [:n :v] :lhs :rhs "Description") ;-> would be for 1 map
; (map.create [:n :v] [:lhs :rhs "Description"]
;                     [:lhs :rhs "Description"]) ;-> would be for multiple maps

(lambda M.cre-map [modes lhs rhs desc ?args]
  "Macro -- Creates a map

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@lhs: |string| # Left hand of keymap
@rhs: |string| or |function| or |table| # Right hand of keymap
@desc: |string| # Description of keymap
@?args(optional): |opt table| # Opts table for vim.keymap.set
```"
  (assert-arg modes [:string :table] 1 :cre-map)
  (assert-arg lhs :string 2 :cre-map)
  (assert-arg rhs [:string :function :table] 3 :cre-map)
  (assert-arg desc :string 4 :cre-map)
  (let [opts# {}]
    (tset opts# :desc desc)
    (when ?args
      (assert-arg ?args :table 5 :cre-map)
      (each [key val (pairs ?args)]
        (tset opts# key val)))
    `(vim.keymap.set ,modes ,lhs ,rhs ,opts#)))

(lambda M.cre-maps [modes ...]
  "Macro -- Creates multiple maps

```
@modes: |string| or |seq table| # String or seq table of strings corresponding
                                  to modes
@... # Stored as sequential tables, each table is the arguments of `cre-map`
       minus the `modes` argument
```"
  (assert-arg modes [:string :table] 1 :cre-map)
  (let [maps# [...]
        size# (length maps#)]
    (assert-compile (> size# 0)
                    (string.format "\"cre-maps\" -- Expected a table of keymaps, received nil")
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
                   ,(M.cre-map modes lhs# rhs# desc# args#)))
            `(do
               ,(M.cre-map modes lhs# rhs# desc# args#)
               ,(recurse-output map# (+ i# 1))))))

    (when (> size# 0)
      (recurse-output maps# 1))))

M
