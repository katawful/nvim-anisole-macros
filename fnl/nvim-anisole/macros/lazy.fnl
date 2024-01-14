;;; Macro file for easier management of lazy.nvim
;; [nfnl-macro]

;; Module
(local M {:spec {:repo {} :load {}}})

(local P {:spec {:repo {} :load {}}})

(fn which-macro [macro-call#]
  "Gets the direct macro name, without any scoping"
  (string.match macro-call# "spec[%.%a?]+"))

(fn is-map-mode? [map-mode#]
  "Is the string a map mode?"
  ;; Map modes can be contained in a table
  ;; Simply recurse through the table
  (if (= (type map-mode#) :table)
      (do
        (var is?# true)
        (each [_ v# (ipairs map-mode#) &until (= is?# false)]
          (if (not (is-map-mode? v#))
              (set is?# false)))
        is?#)
      (match map-mode#
        :n true
        :i true
        :c true
        :v true
        :x true
        :s true
        :o true
        :t true
        :l true
        _ false)))

;;; Private
;; NOTE: To keep clarity in exported macros, the actual functionality for
;; for this module is held P

(fn P.spec.repo.github [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# 1 ,(. name# 1)))

(fn P.spec.repo.directory [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# :dir ,(. name# 1)))

(fn P.spec.repo.url [name# spec#]
  "Macro -- Add a github repo to your spec"
  `(tset ,spec# :url ,(. name# 1)))

(fn P.spec.name [name# spec#]
  "Macro -- Use a different name for your spec"
  `(tset ,spec# :name ,(. name# 1)))

(fn P.spec.dev? [use?# spec#]
  "Macro -- Use a local plugin directory for your spec"
  `(tset ,spec# :dev ,(. use?# 1)))

(fn P.spec.lazy? [lazy?# spec#]
  "Macro -- Lazy load this spec"
  `(tset ,spec# :lazy ,(. lazy?# 1)))

(fn P.spec.enable? [enable?# spec#]
  "Macro -- Enable this spec"
  `(tset ,spec# :enabled ,(. enable?# 1)))

(fn P.spec.condition [condition# spec#]
  "Macro -- Enable this spec with a condition"
  `(tset ,spec# :cond ,(. condition# 1)))

(fn P.spec.dependencies [dependencies# spec#]
  "Macro -- Sequential table of plugin names or specs"
  `(tset ,spec# :dependencies ,(. dependencies# 1)))

(fn P.spec.startup [startup# spec#]
  "Macro -- Function to run during plugin startup"
  `(tset ,spec# :init ,(. startup# 1)))

(fn P.spec.opts [opts# spec#]
  "Macro -- Set the opts table for the spec using `spec.config`"
  `(tset ,spec# :opts ,(. opts# 1)))

(fn P.spec.config [config# spec#]
  "Macro -- Set the config function to use"
  `(tset ,spec# :config ,(. config# 1)))

(fn P.spec.module [module# spec#]
  "Macro -- The module name to use for `spec.opts` and `spec.config`"
  `(tset ,spec# :main ,(. module# 1)))

(fn P.spec.build [build# spec#]
  "Macro -- Runs on plugin install or update"
  `(tset ,spec# :build ,(. build# 1)))

(fn P.spec.repo.branch [branch# spec#]
  "Macro -- The branch to use for this repo"
  `(tset ,spec# :branch ,(. branch# 1)))

(fn P.spec.repo.tag [tag# spec#]
  "Macro -- The tag to use for this repo"
  `(tset ,spec# :tag ,(. tag# 1)))

(fn P.spec.repo.commit [commit# spec#]
  "Macro -- The commit to use for this repo"
  `(tset ,spec# :commit ,(. commit# 1)))

(fn P.spec.repo.version [version# spec#]
  "Macro -- The version to use for this repo"
  `(tset ,spec# :version ,(. version# 1)))

(fn P.spec.repo.submodules? [submodules?# spec#]
  "Macro -- Use submodules?"
  `(tset ,spec# :submodules ,(. submodules?# 1)))

(fn P.spec.load.event [event# spec#]
  "Macro -- What event to load plugin on"
  `(tset ,spec# :event ,(. event# 1)))

(fn P.spec.load.command [command# spec#]
  "Macro -- Load plugin on command"
  `(tset ,spec# :cmd ,(. command# 1)))

(fn P.spec.load.filetype [filetype# spec#]
  "Macro -- Load plugin on filetype"
  `(tset ,spec# :ft ,(. filetype# 1)))

(fn create-lazy-map [mode# lhs# rhs# desc# opts# spec#]
  "Create a Lazy map
The format from `maps.create` is used as it is a more fitting format"
  (let [map# {:mode mode# 1 lhs# 2 rhs# :desc desc#}]
    (when opts#
      (let [keys# (do
                    (local out# [])
                    (each [k# v# (pairs opts#)]
                      (table.insert out# k#))
                    (table.sort out#)
                    out#)]
        (each [k# v# (ipairs keys#)]
          (tset map# v# (?. opts# v#)))))
    map#))

(fn P.spec.load.map [map# spec#]
  "Macro -- Load a map"
  ;; Options:
  ;; 1a. 1 is string keymap, 2 is bare lhs for single map
  ;; lb. 1 is string keymap, 2 is table for maps. this will repeat
  ;; 2a. 1 is table of keymap, 2 is bare lhs for single map
  ;; 2b. 1 is table of keymap, 2 is table for map. this will repeat
  ;; 3. There is no mode first, it is supplied in each map table
  (let [mode?# (?. map# 1)
        map?# (?. map# 2)
        lazy-map# []]
    ;; For options 1a and 2a
    (if (and (or (= (type mode?#) :string) (= (type mode?#) :table))
             (= (type map?#) :string) (is-map-mode? mode?#))
        (table.insert lazy-map#
                      (create-lazy-map mode?# (. map# 2) (. map# 3) (. map# 4)
                                       (?. map# 5) spec#))
        ;; Por options 1b and 2b
        (and (or (= (type mode?#) :string) (= (type mode?#) :table))
             (= (type map?#) :table) (is-map-mode? mode?#))
        (let [maps# map#]
          (table.remove maps# 1)
          (each [_ v# (ipairs maps#)]
            (table.insert lazy-map#
                          (create-lazy-map mode?# (. v# 1) (. v# 2) (. v# 3)
                                           (?. v# 4) spec#))))
        ;; For option 3
        (and (= (type mode?#) :table) (not (is-map-mode? mode?#)))
        (let [maps# map#]
          (each [_ v# (ipairs maps#)]
            (table.insert lazy-map#
                          (create-lazy-map (. v# 1) (. v# 2) (. v# 3) (. v# 4)
                                           (?. v# 5) spec#)))))
    `(tset ,spec# :keys ,lazy-map#)))

(fn P.spec.load.module? [module?# spec#]
  "Macro -- Load this module when used as a dependency"
  `(tset ,spec# :module ,(. module?# 1)))

(fn P.spec.priority [priority# spec#]
  "Macro -- Priority of plugin"
  `(tset ,spec# :priority ,(. priority# 1)))

(fn P.spec.optional? [optional?# spec#]
  "Macro -- Optional spec?"
  `(tset ,spec# :optional ,(. optional?# 1)))

;;; NOTE: To keep simplicity of macros, and to not freak out the fennel
;; compiler, we will simply define dummy macros. The actual macros are
;; contained inside the private module P
;; TODO: Document these for fenneldoc
(fn M.spec.repo.github [name#]
  "Macro -- Use a github repo for your spec
```
@name: |string| # The github path for the repository
```"
  nil)

(fn M.spec.repo.gh [name#]
  "Macro -- Use a github repo for your spec
```
@name: |string| # The github path for the repository
```"
  nil)

(fn M.spec.repo.directory [directory#]
  "Macro -- Use a github repo for your spec
```
@directory: |string| # A filesystem path to a repository
```"
  nil)

(fn M.spec.repo.dir [directory#]
  "Macro -- Use a github repo for your spec
```
@directory: |string| # A filesystem path to a repository
```"
  nil)

(fn M.spec.repo.url [url#]
  "Macro -- Use a github repo for your spec
```
@url |string| # A URL to a git repository
```"
  nil)

(fn M.spec.name [name#]
  "Macro -- Use a custom display and directory name for the plugin
```
@name: |string| # Name to use
```"
  nil)

(fn M.spec.dev? [use?#]
  "Macro -- Use a local plugin directory? Defaults to false
```
@use?: |boolean| # Use a local plugin directory for your spec
```"
  nil)

(fn M.spec.lazy? [lazy?#]
  "Macro -- Lazy load this spec? Defaults to false
```
@lazy?#: |boolean| # Lazy load this spec
```"
  nil)

(fn M.spec.enable? [enable?#]
  "Macro -- Enable this spec. Defaults to true
```
@enable?: |boolean| or |function| # Enable or disable this spec
```"
  nil)

(fn M.spec.condition [condition#]
  "Macro -- Enable this spec with a condition
```
@condition: |boolean| or |function # Enable or disable this spec
```"
  nil)

(fn M.spec.dependencies [dependencies#]
  "Macro -- Sequential table of plugin names or specs for dependencies
```
@dependencies: |seq table| # Contains specs or plugin names
```"
  nil)

(fn M.spec.startup [startup#]
  "Macro -- Function to run during plugin startup
```
@startup: |function| # Function to run
```"
  nil)

(fn M.spec.opts [opts#]
  "Macro -- Set the opts table for a spec
```
@opts: |key/val table| or |function| # The opts table to be passed to the `spec.config` function
```"
  nil)

(fn M.spec.config [config#]
  "Macro -- Set the config function, or use the default value with `true`
```
@config: |boolean| or |function| # The function passed has the args:
- `LazyPlugin`
- `opts`
```"
  nil)

(fn M.spec.module [module#]
  "Macro -- Set the module name to use for `spec.opts` and `spec.config`
Used when it cannot be determined automatically
```
@module: |string| # The module name to use
```"
  nil)

(fn M.spec.build [build#]
  "Macro -- Runs when the plugin is installed or update only

- A Lua function
- A string representing a Vim command-line function (e.g. `:function`)
- A sequential table of commands

This is not needed if the plugin contains a `build.lua` file in its module
```
@build: |function| or |string| or |seq table| # Gets run on install or update of plugin
```"
  nil)

(fn M.spec.repo.branch [branch#]
  "Macro -- The repo branch to use for this plugin
```
@branch: |string| # The branch name
```"
  nil)

(fn M.spec.repo.tag [tag#]
  "Macro -- The repo tag to use for this plugin
```
@tag: |string| # The tag name
```"
  nil)

(fn M.spec.repo.commit [commit#]
  "Macro -- The repo commit to use for this plugin
```
@commit: |string| # The commit name
```"
  nil)

(fn M.spec.repo.version [version#]
  "Macro -- The repo version to use for this plugin
```
@version: |string| # The version name
```"
  nil)

(fn M.spec.repo.submodules? [submodules?#]
  "Macro -- Use submodules?
```
submodules?: |boolean| # Use submodules
```"
  nil)

(fn M.spec.load.event [event#]
  "Macro -- What events to load this plugin on
```
@event: |string| or |function| or |sequential table| # What events to load plugin on
- string
- sequential table of event strings
- function that returns the above
- sequential table of event and patterns
```"
  nil)

(fn M.spec.load.command [command#]
  "Macro -- Load plugin on a command
```
@command: |string| or |seq table| or |function| # What comamnd(s) to load on
- string command (e.g. `:Neorg`)
- sequential table of command strings
- function that returns the above
```"
  nil)

(fn M.spec.load.cmd [command#]
  "Macro -- Load plugin on a command. Alias of `spec.load.command`
```
@command: |string| or |seq table| or |function| # What command(s) to load on
- string command (e.g. `:Neorg`)
- sequential table of command strings
- function that returns the above
```"
  nil)

(fn M.spec.load.filetype [filetype#]
  "Macro -- Load plugin on a filetype
```
@filetype: |string| or |seq table| or |function| # What filetype(s) to load on
- string filetype
- sequential table of filetype strings
- function that returns the above
```"
  nil)

(fn M.spec.load.ft [filetype#]
  "Macro -- Load plugin on a filetype. Alias of `spec.load.filetype`
```
@filetype: |string| or |seq table| or |function| # What filetypes(s) to load on
- string filetype
- sequential table of filetype strings
- function that returns the above
```"
  nil)

(fn M.spec.load.map [map#]
  "Macro -- Load a plugin using a keymapping
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
@map: |anisole-map| # Map table from maps.create
```"
  nil)

;;; FIXME: Make this usable
; (fn M.spec.use [spec#]
;   "Macro -- Use a previously constructed spec"
;   `,spec#)

(fn M.spec.load.module? [module?#]
  "Macro -- Load this module when it is a dependency?
```
@module?: |boolean| # Load this module when it is a dependency?
```"
  nil)

(fn M.spec.priority [priority#]
  "Macro -- Set the priority of a non-lazy plugin
```
@priority: |number| # The priority, higher is more priority
```")

(fn M.spec.optional? [optional?#]
  "Macro -- Spec won't be use
```
@optional?: |boolean| # Use spec?
```")

(fn quote-macro [spec# macro-name# call-args#]
  "Quotes a macro for use during compilation.
This simplifies the macro names we use, since we can direct to P macros"
  ;; FIXME: A large match use like this should be replaced with something else
  (match macro-name#
    ;; :spec.use `,(M.spec.use spec#)
    ;; spec.repo
    :spec.repo.github
    `,(P.spec.repo.github call-args# spec#)
    :spec.repo.gh
    `,(P.spec.repo.github call-args# spec#)
    :spec.repo.directory
    `,(P.spec.repo.directory call-args# spec#)
    :spec.repo.dir
    `,(P.spec.repo.directory call-args# spec#)
    :spec.repo.url
    `,(P.spec.repo.url call-args# spec#)
    ;; spec.name
    :spec.name
    `,(P.spec.name call-args# spec#)
    ;; spec.dev?
    :spec.dev?
    `,(P.spec.dev? call-args# spec#)
    ;; spec.lazy?
    :spec.lazy?
    `,(P.spec.lazy? call-args# spec#)
    ;; spec.enable?
    :spec.enable?
    `,(P.spec.enable? call-args# spec#)
    ;; spec.condition
    :spec.condition
    `,(P.spec.condition call-args# spec#)
    ;; spec.dependencies
    :spec.dependencies
    `,(P.spec.dependencies call-args# spec#)
    ;; spec.startup
    :spec.startup
    `,(P.spec.startup call-args# spec#)
    ;; spec.opts
    :spec.opts
    `,(P.spec.opts call-args# spec#)
    ;; spec.config
    :spec.config
    `,(P.spec.config call-args# spec#)
    ;; spec.module
    :spec.module
    `,(P.spec.module call-args# spec#)
    ;; spec.build
    :spec.build
    `,(P.spec.build call-args# spec#)
    ;; spec.repo.branch
    :spec.repo.branch
    `,(P.spec.repo.branch call-args# spec#)
    ;; spec.repo.tag
    :spec.repo.tag
    `,(P.spec.repo.tag call-args# spec#)
    ;; spec.repo.commit
    :spec.repo.commit
    `,(P.spec.repo.commit call-args# spec#)
    ;; spec.repo.version
    :spec.repo.version
    `,(P.spec.repo.version call-args# spec#)
    ;; spec.repo.submodules?
    :spec.repo.submodules?
    `,(P.spec.repo.submodules? call-args# spec#)
    ;; spec.load.event
    :spec.load.event
    `,(P.spec.load.event call-args# spec#)
    ;; spec.load.command
    :spec.load.command
    `,(P.spec.load.command call-args# spec#)
    ;; spec.load.cmd
    :spec.load.cmd
    `,(P.spec.load.command call-args# spec#)
    ;; spec.load.filetype
    :spec.load.filetype
    `,(P.spec.load.filetype call-args# spec#)
    ;; spec.load.ft
    :spec.load.ft
    `,(P.spec.load.filetype call-args# spec#)
    ;; spec.load.map
    :spec.load.map
    `,(P.spec.load.map call-args# spec#)
    ;; spec.load.module?
    :spec.load.module?
    `,(P.spec.load.module? call-args# spec#)
    ;; spec.priority
    :spec.priority
    `,(P.spec.priority call-args# spec#)
    ;; spec.optional?
    :spec.optional?
    `,(P.spec.optional? call-args# spec#)))

(fn M.spec.init [spec# ...]
  "Macro -- Construct a spec then fill with entries"
  (let [calls# [...]
        size# (length calls#)]
    (fn recurse-output [call# i#]
      (if (>= size# i#)
          (let [current-call# (. call# i#)
                call-args# (if (= (type current-call#) :table)
                               (do
                                 (local out# [])
                                 (each [k# v# (ipairs current-call#)]
                                   (if (not= k# 1)
                                       (table.insert out# v#)))
                                 out#)
                               current-call#)
                macro-name# (. (. current-call# 1) 1)]
            ;; For the first iteration we will add a local variable to add our calls to
            ;; It uses the spec name we desire
            ;; FIXME: Since this will compile to a do-end block, we will need to use a function
            ;; wrap to actually return this for lazy. This should be fixed so a function call
            ;; is not required
            (if (= i# 1)
                (if (not= size# i#)
                    `(do
                       (local ,spec# {})
                       ,(quote-macro spec# (which-macro macro-name#) call-args#)
                       ,(recurse-output call# (+ i# 1)))
                    `(do
                       (local ,spec# {})
                       ,(quote-macro spec# (which-macro macro-name#) call-args#)
                       ,spec#))
                ;; If at the last iteration, simply end the recursion
                (= size# i#)
                `(do
                   ,(quote-macro spec# (which-macro macro-name#) call-args#)
                   ,spec#)
                ;; Recurse as much as possible
                `(do
                   ,(quote-macro spec# (which-macro macro-name#) call-args#)
                   ,(recurse-output call# (+ i# 1)))))))

    (when (> size# 0)
      (recurse-output calls# 1))))

M
