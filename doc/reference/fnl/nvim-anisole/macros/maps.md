# Maps.fnl (prerelease)

**Table of contents**

- [`create`](#create)
- [`private.create-multi-map`](#privatecreate-multi-map)
- [`private.create-single-map`](#privatecreate-single-map)

## `create`
Function signature:

```
(create modes ...)
```

Macro -- Creates a map. Supports single and multiple map creations.

Arguments for single maps:

```
@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes
@lhs: |string| ### Left hand of keymap
@rhs: |string| or |function| or |table| ### Right hand of keymap
@desc: |string| ### Description of keymap
@?args(optional): |opt table| ### Opts table for vim.keymap.set
```
Arguments for multiple maps:

```
@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes
@... ### Stored as sequential tables, each table is the arguments of single map mode
       minus the `modes` argument
```

## `private.create-multi-map`
Function signature:

```
(private.create-multi-map modes ...)
```

Internal Macro -- Creates multiple maps

```
@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes
@... ### Stored as sequential tables, each table is the arguments of `create-single-map`
       minus the `modes` argument
```

## `private.create-single-map`
Function signature:

```
(private.create-single-map modes lhs rhs desc ?args)
```

Internal Macro -- Creates a map

```
@modes: |string| or |seq table| ### String or seq table of strings corresponding
                                  to modes
@lhs: |string| ### Left hand of keymap
@rhs: |string| or |function| or |table| ### Right hand of keymap
@desc: |string| ### Description of keymap
@?args(optional): |opt table| ### Opts table for vim.keymap.set
```


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
