# maps
Allows a Vimscript-esque syntax to simplify the amount of needed information. Unlike the Lua function that these macros use, a description **must** be provided, but the opts table is **optional**.

[Reference](../reference/fnl/nvim-anisole/macros/maps.md)

## `cre-map`
Creates a single map, with a specified mode as a string or sequential table.

### Syntax
```fennel
(cre-map :n lhs rhs "Description")
(vim.keymap.set :n lhs rhs {:desc "Description"})

(cre-map [:n :v] lhs rhs "Description")
(vim.keymap.set :n lhs rhs {:desc "Description"})

(cre-map :n lhs rhs "Description" {:remap true})
(vim.keymap.set :n lhs rhs {:desc "Description" :remap true})
```

Note how the opts-table argument is entirely optional.

## `cre-maps`
Creates multiple maps, all for the same passed mode.
Each map is stored in a sequential table, with the same arguments as `cre-map` but without the mode argument.

### Syntax
```fennel
(cre-maps :n [lhs rhs "Description"]
             [lhs rhs "Description"])
(do (vim.keymap.set :n lhs rhs {:desc "Description"})
    (do (vim.keymap.set :n lhs rhs {:desc "Description"})))
```

While the macro expansion does look bulky, the do lists will simply squash down into regular Lua script without added bulk.

