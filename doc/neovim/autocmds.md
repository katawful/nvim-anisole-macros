# autocommands
Handles dealing with autocommands and autogroups.


[Reference](../reference/fnl/nvim-anisole/macros/autocmds.md)


Note, for this document, I assume that the macro uses the namespace `auto`. This is because autocmd and augroup macros are placed inside their own tables.

## `group.define`
Defines an autogroup to be returned for a variable.

### Syntax
```fennel
(local augroup (auto.group.define "GroupName" true))
; expansion
(local augroup (vim.api.nvim_create_augroup "GroupName" {:clear false}))
```
The boolean is optional. It inverts the functionality of `nvim_create_augroup`. If set to false or nil (i.e. no argument after the name), then the default behavior of `nvim_create_augroup` will be used. This means augroups will clear upon each call.

## `cmd.create`
Creates an autocommand. It is not designed to be accepted by a variable for manipulation. Like maps and user command macros, it can take an optional description and options table. The events, pattern, and callback are required.

### Syntax
```fennel
; no description or options table, lua callback
(auto.cmd.create :Event "*.file" (fn [] (print "callback")))
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback (fn [] (print "callback"))})

; description, no options table, vimscript callback
(auto.cmd.create :Event "*.file" "echo 'command'" "Autocmd description")
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :command "echo 'command'" :desc "Autocmd description"})

; no description, options table, called lua callback
(fn [] auto-callback (print "called function"))
(auto.cmd.create :Event "*.file" auto-callback {:buffer 0})
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback auto-callback :buffer 0})

; description and options table, called lua callback
(fn [] auto-callback (print "called function"))
(auto.cmd.create :Event "*.file" auto-callback "Autocmd description" {:buffer 0})
; expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*.file" :callback auto-callback :desc "Autocmd description" :buffer 0})
```

## `group.fill`
Absorbs `auto.cmd.create` calls within its list, and injects the group throughout each. Only accepts `auto.cmd.create` after the group variable.

### Syntax
```fennel
(auto.group.fill group
  (auto.cmd.create :Event "*" (fn [] (print "callback"))))
; expansion minus auto.cmd.create
(auto.cmd.create :Event "*" (fn [] (print "callback")) {:group group})
; full expansion
(vim.api.nvim_create_autocmd :Event {:pattern "*" :callback (fn [] (print "callback")) :group group})
```

The group must have been previously defined, it cannot be passed through with this macro. For additional notice, only `autocmd-` calls are accepted. Attempting to use anything else will result in a compile-time error. This is *not* a way to be programmatic about autocommand creation, it is only equivalent to the `->` threading macros in function. Any programmatic work of autocommands must be done in a list outside of this scope.

## `cmd.clear!`
Clears an autocommand using `vim.api.nvim_clear_autocommands`.

### Syntax
```fennel
(auto.cmd.clear! (:buffer 0})
(vim.api.nivm_clear_autocmds {:buffer 0})
```

## `cmd.clear<-event!`, `cmd.clear<-pattern!`, `cmd.clear<-buffer!`, `cmd.clear<-group!`
Takes the appropriate type, single and plural, and only that type and clears the autocommands using `vim.api.nvim_clear_autocommands`

- `cmd.clear<-event!`: takes a string or sequential table of strings corresponding to event name
- `cmd.clear<-pattern!`: takes a string or sequential table of strings corresponding to a pattern
- `cmd.clear<-buffer!`: takes a int buffer number
- `cmd.clear<-group!`: takes a string or sequential table of strings corresponding to group name

### Syntax
```fennel
(auto.cmd.clear<-event! :Event)
(vim.api.nvim_clear_autocmd {:event "Event"})
```

## `cmd.get`
Clears an autocommand using `vim.api.nvim_get_autocmds`.

### Syntax
```fennel
(auto.cmd.get (:buffer 0})
(vim.api.nivm_get_autocmds {:buffer 0})
```

## `cmd.get<-event`, `cmd.get<-pattern`, `cmd.get<-buffer`, `cmd.get<-group`
Takes the appropriate type, single and plural, and only that type and gets the autocommands using `vim.api.nvim_get_autocmds`

- `cmd.get<-event`: takes a string or sequential table of strings corresponding to event name
- `cmd.get<-pattern`: takes a string or sequential table of strings corresponding to a pattern
- `cmd.get<-group`: takes a string or sequential table of strings corresponding to group name

### Syntax
```fennel
(auto.cmd.get<-event! :Event)
(vim.api.nvim_get_autocmds {:event "Event"})
```

## `group.delete!`
Deletes an autogroup by name or by id.

### Syntax
```fennel
(auto.group.delete! :Group)
(vim.api.nvim_del_augroup_by_name "Group")

(auto.group.delete! 0)
(vim.api.nvim_del_augroup_by_id 0)
```

## `cmd.run`
Fires an autocmd using `vim.api.nvim_exec_autocmds`.

### Syntax
```fennel
(auto.cmd.run :Event)
(vim.api.nvim_exec_autocmds "Event" {})

(auto.cmd.run [:Event1 :Event2] {:group :Group})
(vim.api.nvim_exec_autocmds ["Event1" "Event2"] {:group "Group"})
```

## Examples
```fennel
; macro form
(let [highlight (auto.group.define "highlightOnYank")]
  (auto.group.fill highlight
        (auto.cmd.create "TextYankPost" :* 
                         (fn [] ((. (require :vim.highlight) :on_yank)))
                         "Highlight yank region")))
(let [terminal (auto.group.define "terminalSettings")]
  (auto.group.fill terminal
   (auto.cmd.create "TermOpen" :* (fn [] (option.set number false)) "No number")
   (auto.cmd.create "TermOpen" :* (fn [] (option.set relativenumber false)) "No relative number")
   (auto.cmd.create "TermOpen" :* (fn [] (option.set spell false)) "No spell")
   (auto.cmd.create "TermOpen" :* (fn [] (option.set bufhidden :hide)) "Bufhidden")))

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
