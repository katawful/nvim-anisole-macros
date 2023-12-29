# Generalized Signatures
In order to maintain consistency, macros here have an expectation of signature behavior. Although it varies from macro to macro, it should be immediately understandable to anyone at a glance.

## Optional `opts` Table
Many `vim.X` functions take "opts table", regular Lua tables, that modify some aspect of the function called. Generally, these are required to maintain consistency with the API as well as to keep clarity when writing Lua code. Fennel, being a LISP that compiles to Lua, has very different expectations. Generally, if an argument in a function is not needed it should not be written. This improves clarity, and makes your LISP code more readable. As well, some select macros have other optional arguments. These will be noted in those cases.

## Creation Macro
```fennel
(cre-macro immediate-info command description ?args-table)
```
For `immediate-info`, this varies immensely based on the macro in use. For mappings macros, this is actually 2 symbols or lists:
```fennel
(cre-map mode-table left-hand-side right-hand-side description ?args-table)
```
For an autocommand macro, it is also 2 symbols/lists. It is kept this way to maintain the general idea of how the Vimscript versions of these functions work overall, rather than go out of the way to make a new syntax.

```fennel
(let [user-command "MyReallyAwesomeAndVeryLongUserCommand"]
  (cre-command user-command (fn [] (print "hi"))))
```

## Definition Macro
This macro behaves the same as the equivalent creation macro, but returns a value. This is useful if you want to further manipulate said values:

```fennel
(let [user-command (def-command "UserCommand" (fn [] (print "hi")))]
  (del-command! user-command))
```

## Deletion and Clear Macros
For these macros, a "deletion" is specifically about removing the entire object. After the expanded macro is run, the object passed will not exist according to Neovim. A "clearing", on the other hand, will only remove the values present for the object. Neovim will still be aware of the object:

```fennel
(cle-autocmd<-event! :BufEnter) ; clear any autocommands found for BufEnter
(del-command! "UserCommand") ; delete the entire user command "UserCommand"
```

Deletion/clearing will depend on how the macro in use works, and is in part determined by the underlying API (e.g. `nvim_clear_autocmds` vs `nvim_del_user_command`).

## Get Macro
"Get" macros are designed to get the value of some object. This is purely a data access. The data type returned depends on the macro:

```fennel
(get-autocmd {:group "SomeCoolGroup"}) ; get autocommands from group "SomeCoolGroup"
(print (get-opt mouse)) ; print the value of option "mouse"
```

## Set Macro
"Set" macros are designed to set the value of some object. This (mostly, see below) implies that the value exists. This is mostly for options macros.

```fennel
(set-opt mouse true)
(set-var :g :cool_var true)
```

Note that due to how Vim variables work, this macro is slightly incongruent in that the variable does not need to exist before being set. This behavior may change in the future.

## Do Macro
The `do-` macros that interface with `vim.cmd` have the ability to take a key value table that expands to the proper `key=value` syntax for said functions. The following example will expand to:
```fennel
(do-ex highlight :Normal {:guifg :white})
(vim.cmd {:cmd "highlight" :args [Normal "guifg=white"] :output true})
```
All `do-` macros can take any amount of arguments as needed by the function.

### `do-viml` Truthy Return
This macro wraps any 0/1 boolean VimL function and outputs a proper Fennel boolean for you. See the example:

```fennel
(if (do-viml filereadable :test.txt) (print "is readable"))
(if (= (vim.fn.filereadable :test.txt) 1) (print "is readable"))
```
