;;; Macro file for easier management of lazy.nvim
;; [nfnl-macro]

;; Module
(local M {:spec {:repo {}}})
(local P {:spec {:repo {}}})

(fn which-macro [macro-call#]
  "Gets the direct macro name, without any scoping"
  (string.match macro-call# "spec[%.%a]+"))

;;; Private
;; NOTE: To keep clarity in exported macros, the actual functionality for
;; for this module is held P

(fn P.spec.repo.github [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# 1 ,(. name# 1)))

(fn P.spec.repo.directory [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# :dir ,(. name# 1)))

(fn P.spec.repo.url [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# :url ,(. name# 1)))

;;; NOTE: To keep simplicity of macros, and to not freak out the fennel
;; compiler, we will simply define dummy macros. The actual macros are
;; contained inside the private module P
;; TODO: Document these for fenneldoc
(fn M.spec.repo.github [name#]
  "Macro -- Use a github repo for your spec
```
@name: |string| # The github path for the repository
```")

(fn M.spec.repo.gh [name#]
  "Macro -- Use a github repo for your spec
```
@name: |string| # The github path for the repository
```")

(fn M.spec.repo.directory [directory#]
  "Macro -- Use a github repo for your spec
```
@directory: |string| # A filesystem path to a repository
```")

(fn M.spec.repo.dir [directory#]
  "Macro -- Use a github repo for your spec
```
@directory: |string| # A filesystem path to a repository
```")

(fn M.spec.repo.url [url#]
  "Macro -- Use a github repo for your spec
```
@url |string| # A URL to a git repository
```")

;;; FIXME: Make this usable
; (fn M.spec.use [spec#]
;   "Macro -- Use a previously constructed spec"
;   `,spec#)

(fn quote-macro [spec# macro-name# call-args#]
  "Quotes a macro for use during compilation.
This simplifies the macro names we use, since we can direct to P macros"
  ;; FIXME: A large match use like this should be replaced with something else
  (match macro-name#
    ;; :spec.use `,(M.spec.use spec#)
    :spec.repo.github
    `,(P.spec.repo.github call-args# spec#)
    :spec.repo.gh
    `,(P.spec.repo.github call-args# spec#)
    :spec.repo.directory
    `,(P.spec.repo.directory call-args# spec#)
    :spec.repo.dir
    `,(P.spec.repo.directory call-args# spec#)
    :spec.repo.url
    `,(P.spec.repo.url call-args# spec#)))

(fn M.spec.init [spec# ...]
  "Macro -- Construct a spec then fill with entries"
  (let [calls# [...]
        size# (length calls#)]
    (fn recurse-output [call# i#]
      (if (>= size# i#)
          (let [current-call# (. call# i#)
                call-args# (if (= (type current-call#) :table)
                               (do
                                 (local out# [])
                                 (each [k# v# (ipairs current-call#)]
                                   (if (not= k# 1)
                                       (table.insert out# v#)))
                                 out#)
                               current-call#)
                macro-name# (. (. current-call# 1) 1)]
            ;; For the first iteration we will add a local variable to add our calls to
            ;; It uses the spec name we desire
            ;; FIXME: Since this will compile to a do-end block, we will need to use a function
            ;; wrap to actually return this for lazy. This should be fixed so a function call
            ;; is not required
            (if (= i# 1)
                `(do
                   (local ,spec# {})
                   ,(quote-macro spec# (which-macro macro-name#) call-args#)
                   ,(recurse-output call# (+ i# 1)))
                ;; If at the last iteration, simply end the recursion
                (= size# i#)
                `(do
                   ,(quote-macro spec# (which-macro macro-name#) call-args#)
                   ,spec#)
                ;; Recurse as much as possible
                `(do
                   ,(quote-macro spec# (which-macro macro-name#) call-args#)
                   ,(recurse-output call# (+ i# 1)))))))

    (when (> size# 0)
      (recurse-output calls# 1))))

M
