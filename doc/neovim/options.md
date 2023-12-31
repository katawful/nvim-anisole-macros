# options
Handles setting of options and scoped variables.

[Reference](../reference/fnl/nvim-anisole/macros/options.md)

## `set`
Sets options and variables, in a simplified singular form and an extensive multiple form. For options, local setting is preferred (`vim.opt_local` vs `vim.opt`).

### `set` For a Single Option
This sets one option, taking optional `append`, `prepend`, or `remove` flags.

### Syntax
```fennel
(options.set option_local value)
(tset vim.opt_local option_local value)

(options.set option_global value)
(tset vim.opt_global option_global value)

(options.set option value :append)
(: (. vim.opt_global :option) :append value)
```

### `set` For Multiple Options
This sets multiple options, taking optional `append`, `prepend`, or `remove` flags.
The options are stored inside a key/value table, where the key is the option and value is the option value.
This handles option scoping the same as for a singular option.

#### Syntax
```fennel
(options.set {option_local value option_global value})
(do (tset vim.opt_local option_local value) (do (tset vim.opt_global option_global value)))

(options.set {option1 value option2 value} :append)
(do (: (. vim.opt_local :option_local) :append value)
    (do (: (. vim.opt_global :option_global) :append value)))
```

### `set` For a Single Variable
This will set a single variable, including being able to index a scope (e.g. `(. b 1)`).

#### Syntax
```fennel
(options.set :g variable value)
(tset (. vim :g) :variable value)

(options.set (. b 1) :variable value)
(tset (. (. vim :b) 1) :variable value)
```

### `set` For Multiple Variables
This will set multiple variables, including being able to index a scope (e.g. `(. b 1)`).
The variables are stored inside a key/value table, where the key is the name of the variable and the value is the variable value.

#### Syntax
```fennel
(options.set :g {variable1 value variable2 value})
(do (tset (. vim :g) :variable1 value) (do (tset (. vim :g) :variable2 value)))
```

## `get`
This gets the value of a single option or variable.

### `get` For an Option
This just takes the option name, and returns any value it contains.

#### Syntax
```fennel
(options.get option)
(: (. vim.opt :option) :get)
```

### `get` For a Vim Variable
This takes the scope, which can be indexed (e.g. `(. b 1)`), and the variable name

#### Syntax
```fennel
(options.get :g variable)
(. (. vim :g) :variable)

(options.get (. b 1) variable)
(. (. (. vim :b) 1) :variable))
```
