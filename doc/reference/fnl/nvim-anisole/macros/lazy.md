# Lazy.fnl (prerelease)

**Table of contents**

- [`load.cmd`](#loadcmd)
- [`load.command`](#loadcommand)
- [`load.event`](#loadevent)
- [`load.filetype`](#loadfiletype)
- [`load.ft`](#loadft)
- [`load.map`](#loadmap)
- [`load.module?`](#loadmodule)
- [`repo.branch`](#repobranch)
- [`repo.commit`](#repocommit)
- [`repo.dir`](#repodir)
- [`repo.directory`](#repodirectory)
- [`repo.gh`](#repogh)
- [`repo.github`](#repogithub)
- [`repo.submodules?`](#reposubmodules)
- [`repo.tag`](#repotag)
- [`repo.url`](#repourl)
- [`repo.version`](#repoversion)
- [`spec.build`](#specbuild)
- [`spec.condition`](#speccondition)
- [`spec.config`](#specconfig)
- [`spec.dependencies`](#specdependencies)
- [`spec.dev?`](#specdev)
- [`spec.enable?`](#specenable)
- [`spec.init`](#specinit)
- [`spec.lazy?`](#speclazy)
- [`spec.module`](#specmodule)
- [`spec.name`](#specname)
- [`spec.optional?`](#specoptional)
- [`spec.opts`](#specopts)
- [`spec.priority`](#specpriority)
- [`spec.startup`](#specstartup)

## `load.cmd`
Function signature:

```
(load.cmd command#)
```

Macro -- Load plugin on a command. Alias of `spec.load.command`
```
@command: |string| or |seq table| or |function| ### What command(s) to load on
- string command (e.g. `:Neorg`)
- sequential table of command strings
- function that returns the above
```

## `load.command`
Function signature:

```
(load.command command#)
```

Macro -- Load plugin on a command
```
@command: |string| or |seq table| or |function| ### What comamnd(s) to load on
- string command (e.g. `:Neorg`)
- sequential table of command strings
- function that returns the above
```

## `load.event`
Function signature:

```
(load.event event#)
```

Macro -- What events to load this plugin on
```
@event: |string| or |function| or |sequential table| ### What events to load plugin on
- string
- sequential table of event strings
- function that returns the above
- sequential table of event and patterns
```

## `load.filetype`
Function signature:

```
(load.filetype filetype#)
```

Macro -- Load plugin on a filetype
```
@filetype: |string| or |seq table| or |function| ### What filetype(s) to load on
- string filetype
- sequential table of filetype strings
- function that returns the above
```

## `load.ft`
Function signature:

```
(load.ft filetype#)
```

Macro -- Load plugin on a filetype. Alias of `spec.load.filetype`
```
@filetype: |string| or |seq table| or |function| ### What filetypes(s) to load on
- string filetype
- sequential table of filetype strings
- function that returns the above
```

## `load.map`
Function signature:

```
(load.map map#)
```

Macro -- Load a plugin using a keymapping
This macro is unique in that it takes in a keymap seq table based on the rules
established in `maps.create`. While this is mostly similar, it establishes a few rules
that lazy.nvim does not:
- Description is always required. Suggested to use the plugin name for this
- Description table is not specified by a key `desc`
- Options are always contained in an opts table, not as keys of the seq table
- Mode is required, but can be specified for an entire map table if all the same
- If mixed modes, specify inside
There are similarities however:
- Can specify filetype with `filetype` key (instead of `ft` key)
- 
```
@map: |anisole-map| ### Map table from maps.create
```

## `load.module?`
Function signature:

```
(load.module? module?#)
```

Macro -- Load this module when it is a dependency?
```
@module?: |boolean| ### Load this module when it is a dependency?
```

## `repo.branch`
Function signature:

```
(repo.branch branch#)
```

Macro -- The repo branch to use for this plugin
```
@branch: |string| ### The branch name
```

## `repo.commit`
Function signature:

```
(repo.commit commit#)
```

Macro -- The repo commit to use for this plugin
```
@commit: |string| ### The commit name
```

## `repo.dir`
Function signature:

```
(repo.dir directory#)
```

Macro -- Use a github repo for your spec
```
@directory: |string| ### A filesystem path to a repository
```

## `repo.directory`
Function signature:

```
(repo.directory directory#)
```

Macro -- Use a github repo for your spec
```
@directory: |string| ### A filesystem path to a repository
```

## `repo.gh`
Function signature:

```
(repo.gh name#)
```

Macro -- Use a github repo for your spec
```
@name: |string| ### The github path for the repository
```

## `repo.github`
Function signature:

```
(repo.github name#)
```

Macro -- Use a github repo for your spec
```
@name: |string| ### The github path for the repository
```

## `repo.submodules?`
Function signature:

```
(repo.submodules? submodules?#)
```

Macro -- Use submodules?
```
submodules?: |boolean| ### Use submodules
```

## `repo.tag`
Function signature:

```
(repo.tag tag#)
```

Macro -- The repo tag to use for this plugin
```
@tag: |string| ### The tag name
```

## `repo.url`
Function signature:

```
(repo.url url#)
```

Macro -- Use a github repo for your spec
```
@url |string| ### A URL to a git repository
```

## `repo.version`
Function signature:

```
(repo.version version#)
```

Macro -- The repo version to use for this plugin
```
@version: |string| ### The version name
```

## `spec.build`
Function signature:

```
(spec.build build#)
```

Macro -- Runs when the plugin is installed or update only

- A Lua function
- A string representing a Vim command-line function (e.g. `:function`)
- A sequential table of commands

This is not needed if the plugin contains a `build.lua` file in its module
```
@build: |function| or |string| or |seq table| ### Gets run on install or update of plugin
```

## `spec.condition`
Function signature:

```
(spec.condition condition#)
```

Macro -- Enable this spec with a condition
```
@condition: |boolean| or |function ### Enable or disable this spec
```

## `spec.config`
Function signature:

```
(spec.config config#)
```

Macro -- Set the config function, or use the default value with `true`
```
@config: |boolean| or |function| ### The function passed has the args:
- `LazyPlugin`
- `opts`
```

## `spec.dependencies`
Function signature:

```
(spec.dependencies dependencies#)
```

Macro -- Sequential table of plugin names or specs for dependencies
```
@dependencies: |seq table| ### Contains specs or plugin names
```

## `spec.dev?`
Function signature:

```
(spec.dev? use?#)
```

Macro -- Use a local plugin directory? Defaults to false
```
@use?: |boolean| ### Use a local plugin directory for your spec
```

## `spec.enable?`
Function signature:

```
(spec.enable? enable?#)
```

Macro -- Enable this spec. Defaults to true
```
@enable?: |boolean| or |function| ### Enable or disable this spec
```

## `spec.init`
Function signature:

```
(spec.init spec# ...)
```

Macro -- Construct a spec then fill with entries

## `spec.lazy?`
Function signature:

```
(spec.lazy? lazy?#)
```

Macro -- Lazy load this spec? Defaults to false
```
@lazy?#: |boolean| ### Lazy load this spec
```

## `spec.module`
Function signature:

```
(spec.module module#)
```

Macro -- Set the module name to use for `spec.opts` and `spec.config`
Used when it cannot be determined automatically
```
@module: |string| ### The module name to use
```

## `spec.name`
Function signature:

```
(spec.name name#)
```

Macro -- Use a custom display and directory name for the plugin
```
@name: |string| ### Name to use
```

## `spec.optional?`
Function signature:

```
(spec.optional? optional?#)
```

**Undocumented**

## `spec.opts`
Function signature:

```
(spec.opts opts#)
```

Macro -- Set the opts table for a spec
```
@opts: |key/val table| or |function| ### The opts table to be passed to the `spec.config` function
```

## `spec.priority`
Function signature:

```
(spec.priority priority#)
```

**Undocumented**

## `spec.startup`
Function signature:

```
(spec.startup startup#)
```

Macro -- Function to run during plugin startup
```
@startup: |function| ### Function to run
```


---

License: [Unlicense](https://github.com/katawful/nvim-anisole-macros/blob/main/LICENSE)


<!-- Generated with Fenneldoc v1.0.1
     https://gitlab.com/andreyorst/fenneldoc -->
