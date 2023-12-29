# Maps.fnl (prerelease)

**Table of contents**

- [`cre-map`](#cre-map)
- [`cre-maps`](#cre-maps)

## `cre-map`
Function signature:

```
(cre-map modes lhs rhs desc ?args)
```

Macro -- Creates a recursive map across multiple modes
  `
@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes   
@lhs: |string| ### Left hand of keymap   
@rhs: |string| or |function| or |table ### Right hand of keymap   
@desc: |string| ### Description of keymap   
@?args(optional): |opt table| ### Opts table for vim.keymap.set

## `cre-maps`
Function signature:

```
(cre-maps modes ...)
```

Macro -- Creates a recursive map across multiple modes

@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes   
@... ### Stored as sequential tables, each table is the arguments of `set-map`
       minus the `modes` argument


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
