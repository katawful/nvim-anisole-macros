# Commands.fnl (prerelease)

**Table of contents**

- [`create`](#create)
- [`define`](#define)
- [`delete!`](#delete)
- [`run.cmd`](#runcmd)
- [`run.command`](#runcommand)
- [`run.fn`](#runfn)
- [`run.function`](#runfunction)

## `create`
Function signature:

```
(create name callback desc ?args)
```

Macro -- Creates a user command

```
@name: |string| ### Name for user command
@callback: |string| ### The function that gets called on fire of user command
@desc: |string| ### Description of user command
@?args: |opt table| ### Opts table for vim.api.nvim_create_user_command
```

## `define`
Function signature:

```
(define name command desc ?args)
```

Macro -- Defines a user command with a returned value

```
@name: |string| ### Name for user command
@callback: |string| ### The function that gets called on fire of user command
@desc: |string| ### Description of user command
@?args: |opt table| ### Opts table for vim.api.nvim_create_user_command
```

Returns a string of the user-command name

## `delete!`
Function signature:

```
(delete! name ?buffer)
```

Macro -- delete a user command

```
@name: |string| ### Name for user command
@?buffer(optional): |int| or |boolean| ### Use a buffer
```

Buffer created user commands will fail if ?buffer is not provided

## `run.cmd`
Function signature:

```
(run.cmd function ...)
```

Macro -- Abbreviated M.run.command

## `run.command`
Function signature:

```
(run.command function ...)
```

Macro -- Runs a Ex command

```
@function: |Ex| ### Ex function
@... ### Arguments for Ex command
```

Can accept a table for functions that take key=val args

## `run.fn`
Function signature:

```
(run.fn function ...)
```

Macro -- Abbreviated M.run.function

## `run.function`
Function signature:

```
(run.function function ...)
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
