# options
Handles setting of options and scoped variables. All option macros can take a flag for `append`, `prepend` and `remove` to keep all functionality. These flags are always the last option of the macro.

[Reference](../reference/fnl/nvim-anisole/macros/options.md)

## Mono-option Macros
To simplify syntax, there are macros for setting only 1 option:

### `set-opt`
This sets a single option, not keeping in mind scope of the option (global & local)

#### Syntax
```fennel
(set-opt option value)
(tset vim.opt "option" value)

(set-opt option value :append)
(: (. vim.opt "option") "append" value)
```

### `set-local-opt`
This sets an option that has the `buf` or `win` scope as a local option. Returns an error if a global option is passed.

#### Syntax
```fennel
(set-local-opt spell true)
(tset vim.opt_local "spell" true)

(set-local-opt spell true :append)
(: (. vim.opt_local "spell") "append" true)
```

#### `set-global-opt`
This sets an option that has the `global` scope as a global option. Returns an error if a local option is passed.

##### Syntax
```fennel
(set-global-opt mouse :nvi)
(tset vim.opt_global "mouse" "nvi")

(set-global-opt mouse :nvi :append)
(: (. vim.opt_global "mouse") "append" "nvi")
```

### `set-opt-auto`
This automatically sets an option as either local or global.

#### Syntax
```fennel
(set-opt-auto mouse :nvi)
(tset vim.opt_global "mouse" "nvi")

(set-opt-auto spell true)
(tset vim.opt_local "spell" true)
```

## Plural-option Macros
These macros set multiple of options, following the same rules as the mono-option macros. These macros are sorted to always return the same order of operations. These are not sorted as the passed options, they are sorted with `table.sort`:

``` fennel
(set-opts {spell true mouse :nvi})
(do (tset vim.opt "spell" true) (do (tset vim.opt "mouse" "nvi")))
```

- `set-opts`
- `set-local-opts`
- `set-global-opts`
- `set-opts-auto`

## `get-opt`
Gets an option.

### Syntax
```fennel
(get-opt spell)
(: (. vim.opt "spell") "get")
```

## `set-var`
Sets a vim variable. Supports scope indexing. When using a scope index, returns an error on compilation if anything other than `b`, `w`, or `t` scope is used.

### Syntax
```fennel
(set-var :g variable "Value")
(tset (. vim "g") "variable" "Value")

(set-var (. :b 1) variable "Value")
(tset (. (. vim "b") 1) "variable" "Value")
```

## `set-vars`
Sets multiple vim variable using a key/value table. Supports scope indexing. When using a scope index, returns an error on compilation if anything other than `b`, `w`, or `t` scope is used.

### Syntax
```fennel
(option.set-vars :g {:variable_1 "Value" :variable_2 true})
(do (tset (. vim "g") "variable_2" true) (tset (. vim "g") "variable_1" "Value"))

(option.set-vars (. :b 1) {:variable_1 "Value" :variable_2 true})
(do (tset (. (. vim "b") 1) "variable_2" true) (tset (. vim "g") "variable_1" "Value"))
```

## `get-var`
Gets a vim variable. Supports scope indexing. When using a scope index, returns an error on compilation if anything other than `b`, `w`, or `t` scope is used.

### Syntax
```fennel
(get-var :g variable)
(. (. vim "g") "variable")

(get-var (. :b 1) variable)
(. (. (. vim "b") 1) "variable")
```

