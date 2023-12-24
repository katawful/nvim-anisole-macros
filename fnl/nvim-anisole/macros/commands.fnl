;;; Macros for nvim commands
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

(local truthy-functions {:bufexists true
                         :buflisted true
                         :bufloaded true
                         :did_filetype true
                         :empty true
                         :exists true
                         :eventhandler true
                         :filereadable true
                         :filewriteable true
                         :has true
                         :has_key true
                         :haslocaldir true
                         :hasmapto true
                         :hlexists true
                         :isdirectory true
                         :islocked true
                         :isnan true})

(fn do-ex [function ...]
  "Macro -- Runs a Ex command
@function: |Ex| # Ex function
@... # Arguments for Ex command
Can accept a table for functions that take key=val args"
  (let [passed-args# [...]
        args# []
        function (tostring function)]
    (each [_ arg# (ipairs passed-args#)]
      (if (= (type arg#) :table)
          (each [key# val# (pairs arg#)]
            (table.insert args# (string.format "%s=%s" key# val#)))
          (table.insert args# (tostring arg#))))
    `(vim.cmd {:cmd ,function :args ,args# :output true})))

(fn do-viml [function ...]
  "Macro -- Runs a VimL function
@function: |Vimscript| # Vimscript function
@... # Arguments for Vimscript command
Returns boolean for builtin truthy/falsy functions such as 'has()'"
  (let [args# ...
        func# (tostring function)]
    (if (. truthy-functions func#)
        `(do
           (let [result# ((. vim.fn ,func#) ,...)]
             (if (= result# 0) false true)))
        `((. vim.fn ,func#) ,...))))

(fn cre-command [name callback desc args]
  "Macro -- Creates a user command
@name: |string| # Name for user command
@callback: |string| # The function that gets called on fire of user command
@desc: |string| # Description of user command
@args: |opt table| # Opts table for `vim.api.nvim_create_user_command`"
  (assert-arg name :string 1 :cre-command)
  (assert-arg callback [:table :function] 2 :cre-command)
  (assert-arg desc :string 3 :cre-command)
  (assert-arg args :table 4 :cre-command)
  (let [opts# {}]
    (tset opts# :desc desc)
    (each [k# v# (pairs args)]
      (tset opts# k# v#))
    (if (?. args :buffer)
        (let [buffer# (if (= args.buffer true) 0
                          args.buffer)]
          (tset opts# :buffer nil)
          `(vim.api.nvim_buf_create_user_command ,buffer# ,name ,callback
                                                 ,opts#))
        `(vim.api.nvim_create_user_command ,name ,callback ,opts#))))

(fn def-command [name command desc args]
  "Macro -- define a user command with a returned value
@name: |string| # Name for user command
@callback: |string| # The function that gets called on fire of user command
@desc: |string| # Description of user command
@args: |opt table| # Opts table for `vim.api.nvim_create_user_command`
Returns a string of the user-command name"
  `(do
     ,(cre-command name command desc args)
     ,name))

(fn del-command [name ?buffer]
  "Macro -- delete a user command
@name: |string| # Name for user command
@?buffer(optional): |int| or |boolean| # Use a buffer
Buffer created user commands will fail if ?buffer is not provided"
  (assert-arg name :string 1 :del-command)
  (if ?buffer
      (do
        (assert-arg ?buffer [:boolean :number] 2 :del-command)
        (if (= ?buffer true)
            `(vim.api.nvim_buf_del_user_command ,name 0)
            `(vim.api.nvim_buf_del_user_command ,name ,?buffer)))
      `(vim.api.nvim_del_user_command ,name)))

(fn do-command [command# ...]
  "Macro -- run a user command"
  `(do
     ,(do-ex command# ...)))

{: cre-command : def-command : del-command : do-command : do-viml : do-ex}
