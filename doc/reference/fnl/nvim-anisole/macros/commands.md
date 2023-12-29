# Commands.fnl (prerelease)

**Table of contents**

- [`cre-command`](#cre-command)
- [`def-command`](#def-command)
- [`del-command!`](#del-command)
- [`do-command`](#do-command)
- [`do-ex`](#do-ex)
- [`do-viml`](#do-viml)

## `cre-command`
Function signature:

```
(cre-command name callback desc ?args)
```

Macro -- Creates a user command

```
@name: |string| ### Name for user command
@callback: |string| ### The function that gets called on fire of user command
@desc: |string| ### Description of user command
@?args: |opt table| ### Opts table for vim.api.nvim_create_user_command
```

## `def-command`
Function signature:

```
(def-command name command desc ?args)
```

Macro -- Defines a user command with a returned value

```
@name: |string| ### Name for user command
@callback: |string| ### The function that gets called on fire of user command
@desc: |string| ### Description of user command
@?args: |opt table| ### Opts table for vim.api.nvim_create_user_command
```

Returns a string of the user-command name

## `del-command!`
Function signature:

```
(del-command! name ?buffer)
```

Macro -- delete a user command

```
@name: |string| ### Name for user command
@?buffer(optional): |int| or |boolean| ### Use a buffer
```

Buffer created user commands will fail if ?buffer is not provided

## `do-command`
Function signature:

```
(do-command command# ...)
```

Macro -- Runs a user command
```
@command#: |string| ### Name for user command
@... ### Arguments for user command
```

## `do-ex`
Function signature:

```
(do-ex function ...)
```

Macro -- Runs a Ex command

```
@function: |Ex| ### Ex function
@... ### Arguments for Ex command
```

Can accept a table for functions that take key=val args

## `do-viml`
Function signature:

```
(do-viml function ...)
```

Macro -- Runs a VimL function

```
@function: |Vimscript| ### Vimscript function
@... ### Arguments for Vimscript command
```

Returns boolean for builtin truthy/falsy functions such as 'has()'


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
