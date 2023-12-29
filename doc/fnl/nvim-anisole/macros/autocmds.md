# Autocmds.fnl (prerelease)

**Table of contents**

- [`cle-autocmd!`](#cle-autocmd)
- [`cle-autocmd<-buffer!`](#cle-autocmd-buffer)
- [`cle-autocmd<-event!`](#cle-autocmd-event)
- [`cle-autocmd<-group!`](#cle-autocmd-group)
- [`cle-autocmd<-pattern!`](#cle-autocmd-pattern)
- [`cre-autocmd!`](#cre-autocmd)
- [`def-augroup!`](#def-augroup)
- [`del-augroup!`](#del-augroup)
- [`do-augroup`](#do-augroup)
- [`do-autocmd`](#do-autocmd)
- [`get-autocmd`](#get-autocmd)
- [`get-autocmd<-event`](#get-autocmd-event)
- [`get-autocmd<-group`](#get-autocmd-group)
- [`get-autocmd<-pattern`](#get-autocmd-pattern)

## `cle-autocmd!`
Function signature:

```
(cle-autocmd! tbl)
```

Macro -- clear autocommands

@tbl: |table| ### Options table for vim.api.nvim_clear_autocmds

## `cle-autocmd<-buffer!`
Function signature:

```
(cle-autocmd<-buffer! buffers)
```

Macro -- clear autocommands from buffers

@buffers: |number| or |boolean| ### Buffer number or current buffer

## `cle-autocmd<-event!`
Function signature:

```
(cle-autocmd<-event! events)
```

Macro -- clear autocommands from events

@events: |string| or |seq table| ### Events

## `cle-autocmd<-group!`
Function signature:

```
(cle-autocmd<-group! groups)
```

Macro -- clear autocommands from group

@groups: |string| or |number| ### Augroups

## `cle-autocmd<-pattern!`
Function signature:

```
(cle-autocmd<-pattern! patterns)
```

Macro -- clear autocommands from patterns

@patterns: |string| or |seq table| ### File patterns to match

## `cre-autocmd!`
Function signature:

```
(cre-autocmd! events pattern callback desc ?args)
```

Macro -- Creates an autocmd

@events: |string| or |seq of strings| ### The autocmd event(s) to use   
@pattern: |string| or |seq of strings| ### The file pattern(s) to match against   
@callback: |function| or |string| ### The function or vimscript that gets called on fire of autocmd   
@desc: |string| ### Description of autocmd   
@?args: |opt table| ### Table of options for `vim.api.nvim_create_autocmd`   

## `def-augroup!`
Function signature:

```
(def-augroup! name ?no-clear)
```

Macro -- Defines an auto group and returns the id

@name: |string| ### Name of group
@?no-clear(optional): |boolean| ### If true, don't clear out group. Opposite of default

## `del-augroup!`
Function signature:

```
(del-augroup! augroup)
```

Macro -- delete augroup by augroup or name

@augroup: |string| or |number| ### Augroup

## `do-augroup`
Function signature:

```
(do-augroup group ...)
```

Macro -- Inserts an auto group into autocmd calls

@group: |number| ### id of augroup
@... ### `cre-autocmd!` calls only

## `do-autocmd`
Function signature:

```
(do-autocmd events ?args)
```

Macro -- do autocommand

@events: |string| or |seq table| ### Events   
@?args: |key/val table| ### Options table for vim.api.nvim_exec_autocmds

## `get-autocmd`
Function signature:

```
(get-autocmd tbl)
```

Macro -- get autocommands

@tbl: |table| ### Options table for vim.api.nvim_clear_autocmds

## `get-autocmd<-event`
Function signature:

```
(get-autocmd<-event events)
```

Macro -- get autocommands from events

@events: |string| or |seq table| ### Events

## `get-autocmd<-group`
Function signature:

```
(get-autocmd<-group groups)
```

Macro -- get autocommand from group

@groups: |string| or |number| ### Augroups

## `get-autocmd<-pattern`
Function signature:

```
(get-autocmd<-pattern patterns)
```

Macro -- get autocommands from patterns

@patterns: |string| or |seq table| ### File patterns to match


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
