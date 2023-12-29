# commands
Allows interfacing with legacy Vimscript functions and commands in a simpler manner

[Reference](../fnl/nvim-anisole-macros/commands.md)

## User-Commands
Macros allow full manipulation of user-commands.

### `cre-command`
Creates a user-command:

#### Syntax
If the command is to be Vimscript, it must be passed as an entirely enclosed string. A Lua function reference or a defined function can be used.
```fennel
(cre-command :Command (fn []) "Description")
(vim.api.nvim_create_user_command :Command (fn []) {:desc "Description"})

(cre-command :Command "echo \"Hello\"" "Description")
(vim.api.nvim_create_user_command :Command "echo \"Hello\"" {:desc "Description"})
```

#### Examples
```fennel
;; macro form
(fn files [opts]
  ((. (require :fzf-lua) :files) opts))
(cre-command :FZFOpenFile (fn [] (files)) "Open files")

;; expansion
(fn files [opts]
  ((. (require :fzf-lua) :files) opts))
(vim.api.nvim_create_user_command :FZFOpenFile (fn [] (files)) {:desc "Open files"})
```

### `def-command`
Defines a user-command:
```fennel
(def-command command-name command ?description ?args-table)
```
This macro behaves the same as [`cre-command`](cre-command), but returns `command-name` to be passed to variables. If the returned value is not needed, use `cre-command` instead.

#### Expansion
```fennel
(do (vim.api.nvim_create_user_command command-name command {:desc description arg-key arg-value})
    command-name)
```

#### Examples
```fennel
;; macro form
(local user-command (def-command :TempUserCommand
                                 (fn [] (print "hello"))
                                 {:buffer true}))
;; expansion
(local user-command (do (vim.api.nvim_create_user_command :TempUserCommand
                                                      (fn [] (print "hello"))
                                                      {:buffer 0})
                        :TempUserCommand))
```

### `del-command`
Deletes a user-command:
```fennel
(del-command command-name ?buffer)
```
User-commands created for a buffer must pass `?buffer` due to limitations in the API.

#### Expansion
```fennel
(del-command command-name)
(vim.api.nvim_del_user_command command-name)

(del-command command-name true)
(vim.api.nvim_buf_del_user_command command-name 0)

(del-command command-name buffer)
(vim.api.nvim_buf_del_user_command command buffer)
```

### `do-command`
Runs a user command:
```fennel
(do-command command-name args)
```

#### Expansion
```fennel
(do-command command-name)
(vim.cmd {:cmd command-name :output true})

(do-command command-name :arg)
(vim.cmd {:cmd command-name :args [:arg] :output true})
```

## `do-ex`
Runs a Ex command:

### Syntax
```fennel
(do-ex function :arg)
; expansion
(vim.cmd {:cmd :function :args [:arg] :output true})

(do-ex function :arg {:key :value})
(vim.cmd {:cmd :function :args [:arg "key=value"] :output true})
```

## `do-viml`
Run a VimL function, returning a boolean for boolean returning functions:

### Syntax
```fennel
(do-viml function)
((. vim.fn "function"))

(do-viml did_filetype)
(do (let [result_2_auto ((. vim.fn "did_filetype"))] (if (= result_2_auto 0) false true)))

(do-viml expand "%" vim.v.true)
((. vim.fn "expand") "%" vim.v.true)

(do-viml has :nvim)
(do (let [result_2_auto ((. vim.fn "has") "arg")] (if (= result_2_auto 0) false true)))
```
