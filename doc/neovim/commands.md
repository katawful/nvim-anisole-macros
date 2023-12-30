# commands
Allows interfacing with legacy Vimscript functions and commands in a simpler manner

[Reference](../reference/fnl/nvim-anisole/macros/commands.md)

## User-Commands
Macros allow full manipulation of user-commands.

### `create`
Creates a user-command:

#### Syntax
If the command is to be Vimscript, it must be passed as an entirely enclosed string. A Lua function reference or a defined function can be used.
```fennel
(create :Command (fn []) "Description")
(vim.api.nvim_create_user_command :Command (fn []) {:desc "Description"})

(create :Command "echo \"Hello\"" "Description")
(vim.api.nvim_create_user_command :Command "echo \"Hello\"" {:desc "Description"})
```

#### Examples
```fennel
;; macro form
(fn files [opts]
  ((. (require :fzf-lua) :files) opts))
(create :FZFOpenFile (fn [] (files)) "Open files")

;; expansion
(fn files [opts]
  ((. (require :fzf-lua) :files) opts))
(vim.api.nvim_create_user_command :FZFOpenFile (fn [] (files)) {:desc "Open files"})
```

### `define`
Defines a user-command:
```fennel
(define command-name command ?description ?args-table)
```
This macro behaves the same as [`create`](create), but returns `command-name` to be passed to variables. If the returned value is not needed, use `create` instead.

#### Expansion
```fennel
(do (vim.api.nvim_create_user_command command-name command {:desc description arg-key arg-value})
    command-name)
```

#### Examples
```fennel
;; macro form
(local user-command (define :TempUserCommand
                                 (fn [] (print "hello"))
                                 {:buffer true}))
;; expansion
(local user-command (do (vim.api.nvim_create_user_command :TempUserCommand
                                                      (fn [] (print "hello"))
                                                      {:buffer 0})
                        :TempUserCommand))
```

### `delete!`
Deletes a user-command:
```fennel
(delete! command-name ?buffer)
```
User-commands created for a buffer must pass `?buffer` due to limitations in the API.

#### Expansion
```fennel
(delete! command-name)
(vim.api.nvim_del_user_command command-name)

(delete! command-name true)
(vim.api.nvim_buf_del_user_command command-name 0)

(delete! command-name buffer)
(vim.api.nvim_buf_del_user_command command buffer)
```

## `run.command`
Runs a Ex command.

There is an abbreviated form `run.cmd`.

### Syntax
```fennel
(run.command function :arg)
; expansion
(vim.cmd {:cmd :function :args [:arg] :output true})

(run.command function :arg {:key :value})
(vim.cmd {:cmd :function :args [:arg "key=value"] :output true})
```

## `run.function`
Run a VimL function, returning a boolean for boolean returning functions.

There is an abbreviated form `run.fn`.

### Syntax
```fennel
(run.function function)
((. vim.fn "function"))

(run.function did_filetype)
(do (let [result_2_auto ((. vim.fn "did_filetype"))] (if (= result_2_auto 0) false true)))

(run.function expand "%" vim.v.true)
((. vim.fn "expand") "%" vim.v.true)

(run.function has :nvim)
(do (let [result_2_auto ((. vim.fn "has") "arg")] (if (= result_2_auto 0) false true)))
```
