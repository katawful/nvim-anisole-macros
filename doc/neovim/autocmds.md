# autocommands
Handles dealing with autocommands and autogroups.


[Reference](../reference/fnl/nvim-anisole-macros/autocmds.md)

## `def-augroup!`
Defines an autogroup to be returned for a variable.

### Syntax
```fennel
(local augroup (def-augroup "GroupName" true))
; expansion
(local augroup (vim.api.nvim_create_augroup "GroupName" {:clear false}))
```
The boolean is optional. It inverts the functionality of `nvim_create_augroup`. If set to false or nil (i.e. no argument after the name), then the default behavior of `nvim_create_augroup` will be used. This means augroups will clear upon each call.

## `cre-autocmd!`
Creates an autocommand. It is not designed to be accepted by a variable for manipulation. Like maps and user command macros, it can take an optional description and options table. The events, pattern, and callback are required.

### Syntax
```fennel
; no description or options table, lua callback
(cre-autocmd! :Event "*.file" (fn [] (print "callback")))
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback (fn [] (print "callback"))})

; description, no options table, vimscript callback
(cre-autocmd! :Event "*.file" "echo 'command'" "Autocmd description")
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :command "echo 'command'" :desc "Autocmd description"})

; no description, options table, called lua callback
(fn [] auto-callback (print "called function"))
(cre-autocmd! :Event "*.file" auto-callback {:buffer 0})
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback auto-callback :buffer 0})

; description and options table, called lua callback
(fn [] auto-callback (print "called function"))
(cre-autocmd! :Event "*.file" auto-callback "Autocmd description" {:buffer 0})
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback auto-callback :desc "Autocmd description" :buffer 0})
```

## `do-augroup`
Absorbs `cre-autocmd!` calls within its list, and injects the group throughout each. Only accepts `cre-autocmd!` after the group variable.

### Syntax
```fennel
(do-augroup group
  (cre-autocmd! :Event "*" (fn [] (print "callback"))))
; expansion minus cre-autocmd!
(cre-autocmd! :Event "*" (fn [] (print "callback")) {:group group})
; full expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*" :callback (fn [] (print "callback")) :group group})
```

The group must have been previously defined, it cannot be passed through with this macro. For additional notice, only `autocmd-` calls are accepted. Attempting to use anything else will result in a compile-time error. This is *not* a way to be programmatic about autocommand creation, it is only equivalent to the `->` threading macros in function. Any programmatic work of autocommands must be done in a list outside of this scope.

## `cle-autocmd!`
Clears an autocommand using `vim.api.nvim_clear_autocommands`.

### Syntax
```fennel
(cle-autocmd! (:buffer 0})
(vim.api.nivm_clear_autocmds {:buffer 0})
```

## `cle-autocmd<-event!`, `cle-autocmd<-pattern!`, `cle-autocmd<-buffer!`, `cle-autocmd<-group!`
Takes the appropriate type, single and plural, and only that type and clears the autocommands using `vim.api.nvim_clear_autocommands`

- `cle-autocmd<-event!`: takes a string or sequential table of strings corresponding to event name
- `cle-autocmd<-pattern!`: takes a string or sequential table of strings corresponding to a pattern
- `cle-autocmd<-buffer!`: takes a int buffer number
- `cle-autocmd<-group!`: takes a string or sequential table of strings corresponding to group name

### Syntax
```fennel
(cle-autocmd<-event! :Event)
(vim.api.nvim_clear_autocmd {:event "Event"})
```

## `get-autocmd!`
Clears an autocommand using `vim.api.nvim_get_autocmds`.

### Syntax
```fennel
(get-autocmd! (:buffer 0})
(vim.api.nivm_get_autocmds {:buffer 0})
```

## `get-autocmd<-event!`, `get-autocmd<-pattern!`, `get-autocmd<-buffer!`, `get-autocmd<-group!`
Takes the appropriate type, single and plural, and only that type and gets the autocommands using `vim.api.nvim_get_autocmds`

- `get-autocmd<-event!`: takes a string or sequential table of strings corresponding to event name
- `get-autocmd<-pattern!`: takes a string or sequential table of strings corresponding to a pattern
- `get-autocmd<-group!`: takes a string or sequential table of strings corresponding to group name

### Syntax
```fennel
(get-autocmd<-event! :Event)
(vim.api.nvim_get_autocmds {:event "Event"})
```

## `del-augroup!`
Deletes an autogroup by name or by id.

### Syntax
```fennel
(del-augroup! :Group)
(vim.api.nvim_del_augroup_by_name "Group")

(del-augroup! 0)
(vim.api.nvim_del_augroup_by_id 0)
```

## `do-autocmd`
Fires an autocmd using `vim.api.nvim_exec_autocmds`.

### Syntax
```fennel
(do-autocmd :Event)
(vim.api.nvim_exec_autocmds "Event" {})

(do-autocmd [:Event1 :Event2] {:group :Group})
(vim.api.nvim_exec_autocmds ["Event1" "Event2"] {:group "Group"})
```

## Examples
```fennel
; macro form
(let [highlight (def-augroup "highlightOnYank")]
  (do-augroup highlight
        (autocmd- "TextYankPost" :* 
              (fn [] ((. (require :vim.highlight) :on_yank)))
              "Highlight yank region")))
(let [terminal (def-augroup "terminalSettings")]
  (do-augroup terminal
   (cre-autocmd! "TermOpen" :* (fn [] (setl- number false)) "No number")
   (cre-autocmd! "TermOpen" :* (fn [] (setl- relativenumber false)) "No relative number")
   (cre-autocmd! "TermOpen" :* (fn [] (setl- spell false)) "No spell")
   (cre-autocmd! "TermOpen" :* (fn [] (setl- bufhidden :hide)) "Bufhidden")))

; expansion
(let [highlight (vim.api.nvim_create_augroup "highlightOnYank" {:clear true})]
  (vim.api.nvim_create_autocmd "TextYankPost"
                               {:pattern :*
			        :callback (fn [] ((. (require :vim.highlight) :on_yank)))
				:desc "Highlight yank region"
				:group highlight}))
(let [terminal (vim.api.nvim_create_augroup "terminalSettings" {:clear true})]
  (vim.api.nvim_create_autocmd "TermOpen" 
                               {:pattern :* 
			        :callback (fn [] (setl- number false))
				:group terminal
				:desc "No number"})
  (vim.api.nvim_create_autocmd "TermOpen" 
                               {:pattern :* 
			        :callback (fn [] (setl- relativenumber false)) 
				:group terminal
				:desc "No relative number"})
  (vim.api.nvim_create_autocmd "TermOpen" 
                               {:pattern :* 
			        :callback (fn [] (setl- spell false)) 
				:group terminal
				:desc "No spell"})
  (vim.api.nvim_create_autocmd "TermOpen" 
                               {:pattern :* 
			        :callback (fn [] (setl- bufhidden :hide)) 
				:group terminal
				:desc "Bufhidden"})))
```
