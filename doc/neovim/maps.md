# maps
Allows a Vimscript-esque syntax to simplify the amount of needed information. Unlike the Lua function that these macros use, a description **must** be provided, but the opts table is **optional**.

[Reference](../reference/fnl/nvim-anisole/macros/maps.md)

## `create`
Creates maps, supporting single and multiple maps. For multi-mode maps, each set of calls must be contained inside a sequential table. For a single map, you can eliminate the need for the sequential table.

### Syntax
```fennel
(create :n lhs rhs "Description")
(vim.keymap.set :n lhs rhs {:desc "Description"})

(create [:n :v] lhs rhs "Description")
(vim.keymap.set :n lhs rhs {:desc "Description"})

(create :n lhs rhs "Description" {:remap true})
(vim.keymap.set :n lhs rhs {:desc "Description" :remap true})

(create :n [lhs rhs "Description"]
           [lhs rhs "Description"])
(do (vim.keymap.set :n lhs rhs {:desc "Description"})
    (do (vim.keymap.set :n lhs rhs {:desc "Description"})))
```

Note how the opts-table argument is entirely optional.

While the macro expansion for the multi-mode macro does look bulky, the do lists will simply squash down into regular Lua script without added bulk.

