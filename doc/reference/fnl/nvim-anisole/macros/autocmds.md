# Autocmds.fnl (prerelease)

**Table of contents**

- [`cmd.clear!`](#cmdclear)
- [`cmd.clear<-buffer!`](#cmdclear-buffer)
- [`cmd.clear<-event!`](#cmdclear-event)
- [`cmd.clear<-group!`](#cmdclear-group)
- [`cmd.clear<-pattern!`](#cmdclear-pattern)
- [`cmd.create`](#cmdcreate)
- [`cmd.get`](#cmdget)
- [`cmd.get<-event`](#cmdget-event)
- [`cmd.get<-group`](#cmdget-group)
- [`cmd.get<-pattern`](#cmdget-pattern)
- [`cmd.run`](#cmdrun)
- [`group.define`](#groupdefine)
- [`group.delete!`](#groupdelete)
- [`group.fill`](#groupfill)

## `cmd.clear!`
Function signature:

```
(cmd.clear! tbl)
```

Macro -- Clears autocommands

```
@tbl: |table| ### Options table for vim.api.nvim_clear_autocmds
```

## `cmd.clear<-buffer!`
Function signature:

```
(cmd.clear<-buffer! buffers)
```

Macro -- Clears autocommands from buffers

```
@buffers: |number| or |boolean| ### Buffer number or current buffer
```

## `cmd.clear<-event!`
Function signature:

```
(cmd.clear<-event! events)
```

Macro -- Clears autocommands from events

```
@events: |string| or |seq table| ### Events
```

## `cmd.clear<-group!`
Function signature:

```
(cmd.clear<-group! groups)
```

Macro -- Clears autocommands from group

```
@groups: |string| or |number| ### Augroups
```

## `cmd.clear<-pattern!`
Function signature:

```
(cmd.clear<-pattern! patterns)
```

Macro -- Clears autocommands from patterns

```
@patterns: |string| or |seq table| ### File patterns to match
```

## `cmd.create`
Function signature:

```
(cmd.create events pattern callback desc ?args)
```

Macro -- Creates an autocmd

```
@events: |string| or |seq of strings| ### The autocmd event(s) to use
@pattern: |string| or |seq of strings| ### The file pattern(s) to match against
@callback: |function| or |string| ### The function or vimscript that gets called on fire of autocmd
@desc: |string| ### Description of autocmd
@?args: |opt table| ### Table of options for `vim.api.nvim_create_autocmd`
```

## `cmd.get`
Function signature:

```
(cmd.get tbl)
```

Macro -- Gets autocommands

```
@tbl: |table| ### Options table for vim.api.nvim_clear_autocmds
```

## `cmd.get<-event`
Function signature:

```
(cmd.get<-event events)
```

Macro -- Gets autocommands from events

```
@events: |string| or |seq table| ### Events
```

## `cmd.get<-group`
Function signature:

```
(cmd.get<-group groups)
```

Macro -- Gets autocommand from group

```
@groups: |string| or |number| ### Augroups
```

## `cmd.get<-pattern`
Function signature:

```
(cmd.get<-pattern patterns)
```

Macro -- Gets autocommands from patterns

```
@patterns: |string| or |seq table| ### File patterns to match
```

## `cmd.run`
Function signature:

```
(cmd.run events ?args)
```

Macro -- Runs an autocommand

```
@events: |string| or |seq table| ### Events
@?args: |key/val table| ### Options table for vim.api.nvim_exec_autocmds
```

## `group.define`
Function signature:

```
(group.define name ?no-clear)
```

Macro -- Defines an auto group and returns the id

```
@name: |string| ### Name of group
@?no-clear(optional): |boolean| ### If true, don't clear out group. Opposite of default
```

## `group.delete!`
Function signature:

```
(group.delete! augroup)
```

Macro -- Deletes augroup by id or name

```
@augroup: |string| or |number| ### Augroup
```

## `group.fill`
Function signature:

```
(group.fill group ...)
```

Macro -- Fills cmd.create calls with an augroup

```
@group: |number| ### id of augroup
@... ### `cmd.create` calls only
```


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
