# Options.fnl (prerelease)

**Table of contents**

- [`get`](#get)
- [`private.get-opt`](#privateget-opt)
- [`private.get-var`](#privateget-var)
- [`private.set-opt-auto`](#privateset-opt-auto)
- [`private.set-opts-auto`](#privateset-opts-auto)
- [`private.set-var`](#privateset-var)
- [`private.set-vars`](#privateset-vars)
- [`set`](#set)

## `get`
Function signature:

```
(get ...)
```

Macro -- Gets the value of an option or a variable
1. Variable -> `(get scope variable)`
2. Option -> `(get option)`
```
@scope: |string| ### The scope of the variable
@variables: |key/val table| ### The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

## `private.get-opt`
Function signature:

```
(private.get-opt option)
```

Macro -- Get an option's value

```
@option: |object| or |string| ### The option, can be written literally
```

## `private.get-var`
Function signature:

```
(private.get-var scope variable)
```

Macro -- Get the value of a Vim variable

```
@scope: |string| ### The scope of the variable
@variables: |key/val table| ### The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

## `private.set-opt-auto`
Function signature:

```
(private.set-opt-auto option value ?flag)
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

`(M.private.set-opt-auto spell true)` -> will set spell locally   
`(M.private.set-opt-auto mouse :nvi)` -> will set mouse globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs.

## `private.set-opts-auto`
Function signature:

```
(private.set-opts-auto options ?flag)
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

`(M.private.set-opt-auto spell true)` -> will set spell locally   
`(M.set-opt-auto mouse :nvi)` -> will set mouse globally   

This macro is generally preferred when no specification is needed.
However, since it sets local options its generally avoided for system wide configs.

## `private.set-var`
Function signature:

```
(private.set-var scope variable value)
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

## `private.set-vars`
Function signature:

```
(private.set-vars scope variables)
```

Macro -- Plural of private.set-var for one scope

```
@scope: |string| ### The scope of the variable
@variables: |key/val table| ### The variables, where the key is the variable and val is the value
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

## `set`
Function signature:

```
(set ...)
```

Macro -- Sets one or multiple options or variables

Since this macro supports 4 different modes of operation, plus a flag for the option settings,
we need to handle all of those.

1. Single option -> `(set option value ?flag)`
2. Multiple options -> `(set {option1 value option2 value} ?flag)`
3. Single var -> `(set scope variable value)`
4. Multiple vars -> `(set scope {var1 value var2 value})`

1.
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


2.
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

3.
```
@scope: |string| ### The scope of the variable
@variable: |object| or |string| ### The variable itself. Can be string or literal object
@value: |any| ### The value of the option
```

For b, w, and t scope, they can be indexed like `(. b 1)` for their
Lua table equivalent. The other scopes can't take an index and will
return an error.

4.
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
