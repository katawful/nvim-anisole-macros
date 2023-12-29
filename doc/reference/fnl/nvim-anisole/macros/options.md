# Options.fnl (prerelease)

**Table of contents**

- [`get-opt`](#get-opt)
- [`get-var`](#get-var)
- [`set-global-opt`](#set-global-opt)
- [`set-global-opts`](#set-global-opts)
- [`set-local-opt`](#set-local-opt)
- [`set-local-opts`](#set-local-opts)
- [`set-opt`](#set-opt)
- [`set-opt-auto`](#set-opt-auto)
- [`set-opts`](#set-opts)
- [`set-opts-auto`](#set-opts-auto)
- [`set-var`](#set-var)
- [`set-vars`](#set-vars)

## `get-opt`
Function signature:

```
(get-opt option)
```

Macro -- Get an option's value

```
@option: |object| or |string| ### The option, can be written literally
```

## `get-var`
Function signature:

```
(get-var scope variable)
```

Macro -- Get the value of a Vim variable

```
@scope: |string| ### The scope of the variable
@variables: |key/val table| ### The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

## `set-global-opt`
Function signature:

```
(set-global-opt option value ?flag)
```

Macro -- Sets a global option

```
@option: |object| or |string| ### The option, can be written literally
@value: |any| ### The value of the option
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

## `set-global-opts`
Function signature:

```
(set-global-opts options ?flag)
```

Macro -- Plural of set-global-opt

```
@options: |key/val table| ### The options, where the key is the option and val is the value
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

Takes key-value table of options

## `set-local-opt`
Function signature:

```
(set-local-opt option value ?flag)
```

Macro -- Sets a local option

```
@option: |object| or |string| ### The option, can be written literally
@value: |any| ### The value of the option
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

## `set-local-opts`
Function signature:

```
(set-local-opts options ?flag)
```

Macro -- Plural of set-local-opt

```
@options: |key/val table| ### The options, where the key is the option and val is the value
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

Takes key-value table of options

## `set-opt`
Function signature:

```
(set-opt option value ?flag)
```

Macro -- Sets an option

```
@option: |object| or |string| ### The option, can be written literally
@value: |any| ### The value of the option
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

## `set-opt-auto`
Function signature:

```
(set-opt-auto option value ?flag)
```

Macro -- Sets an option with auto scope

```
@option: |object| or |string| ### The option, can be written literally
@value: |any| ### The value of the option
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   
`(M.set-opt spell true)`      -> will set spell globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs.

## `set-opts`
Function signature:

```
(set-opts options ?flag)
```

Macro -- Plural of set-opt

```
@options: |key/val table| ### The options, where the key is the option and val is the value
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

Takes key-value table of options

## `set-opts-auto`
Function signature:

```
(set-opts-auto options ?flag)
```

Macro -- Plural of set-opt-auto

```
@options: |key/val table| ### The options, where the key is the option and val is the value
@?flag(optional): |string| ### A flag (append, prepend, remove) for the option
```

Takes key-value table of options
Generally, `set` from Vim will try to use the global scope for anything.
If you want a local scope you have to use `setlocal`. This is generally
not particularly clean, as you then have to remember what is what kind of
scope. This macro fixes this by always preferring the local scope if available
but not restricting the use of global-only scoped options

`(M.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   
`(M.set-opt spell true)`      -> will set spell globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs.

## `set-var`
Function signature:

```
(set-var scope variable value)
```

Macro -- Sets a Vim variable

```
@scope: |string| ### The scope of the variable
@variable: |object| or |string| ### The variable itself. Can be string or literal object
@value: |any| ### The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

## `set-vars`
Function signature:

```
(set-vars scope variables)
```

Macro -- Plural of set-var for one scope

```
@scope: |string| ### The scope of the variable
@variables: |key/val table| ### The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
