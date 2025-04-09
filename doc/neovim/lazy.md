# Lazy

lazy.nvim is a popular Neovim plugin manager.
Being built around Lua paradigms, there are a lot of weird Fennel usages when using lazy.nvim for Fennel configs.
This macro file intends to improve upon lazy.nvim, giving a more idiomatic and consistent experience for Fennel users.

[Reference](../reference/fnl/nvim-anisole/macros/lazy.md)

# Changes
To provide better readability of the lazy plugin spec, a number of changes have been made overall:

## Boolean Functions Have `?` Suffixes
Fennel convention implies that `?` ending functions are boolean options.
All boolean lazy keys have a `?` appended:

- `spec.load.module?` - for `module` key: same features
- `spec.repo.submodules?` - for `submodules` key: same features
- `spec.dev?` - for `dev` key: same features
- `spec.enable?` - for `enabled` key: same features
- `spec.lazy?` - for `lazy` key: same features

## Moduled Naming
To imply what a key in the spec operates on, there are 3 modules within this macro file:

1. `load`: controls how the plugin loads (i.e. lazy loading)
2. `repo`: controls how the repo is installed
3. other: everything else is not contained in a module

## Direct Key Renames
Some keys are simply outright renamed:

- `1`/github key -> `spec.repo.github`/`spec.repo.gh`: This removes needing to use `1` as a key in the spec
- `cond` -> `spec.condition`: Simple unshorten of key
- `main` -> `spec.module`: Better implies that you're setting the module to call
- `init` -> `spec.startup`: Tells you that this function is run during startup of plugin
- `keys` -> `spec.load.map`: Signifies both that the format it takes has changed and is consistent with nvim-anisole

# Using
This is used a bit differently from other plugin managers.
The plugin spec must be **explicitly** defined.
This lets us use function/list calls to structure our spec, rather than relying on table behavior that is not clean to use in Fennel.

```fennel
(import-macros lazy :nvim-anisole/macros/lazy)
(lazy.spec.init plugin
                (lazy.spec.repo.gh :author/plugin))
```

While it is more verbose with unconfigured plugins, as soon as you start providing more features it becomes much clearer what the purpose of each call should be.
For example, we can take the original lazy.nvim example plugin specs and convert them back to these macros and simple raw Fennel:

```lua
return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  { "folke/which-key.nvim", lazy = true },

  {
    "nvim-neorg/neorg",
    ft = "norg",
    opts = {
      load = {
        ["core.defaults"] = {},
      },
    },
  },

  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "stevearc/dressing.nvim", event = "VeryLazy" },

  {
    "Wansmer/treesj",
    keys = {
      { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
    },
    opts = { use_default_keymaps = false, max_join_length = 150 },
  },

  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", { "<C-x>", mode = "n" } },
  },

  { dir = "~/projects/secret.nvim" },

  { url = "git@github.com:folke/noice.nvim.git" },

  { "folke/noice.nvim", dev = true },
}
```

The Lua is very readable, make good use of syntactical sugars.
However, converting directly to Fennel issues start to arise:

```fennel
[{1 :folke/tokyonight.nvim
  :config #(vim.cmd "colorscheme tokyonight"))
  :lazy false
  :priority 1000}
 {1 :folke/which-key.nvim
  :lazy true}
 {1 :nvim-neorg/neorg
  :ft :norg
  :opts {:load {:core.defaults {}}}}
 {1 :dstein64/vim-startuptime
  :cmd :StartupTime
  :init #(set vim.g.startuptime_tries 10))}
 {1 :hrsh7th/nvim-cmp
  :config (fn [])
  :dependencies [:hrsh7th/cmp-nvim-lsp :hrsh7th/cmp-buffer]
  :event :InsertEnter}
 {1 :nvim-tree/nvim-web-devicons
  :lazy true}
 {1 :stevearc/dressing.nvim
  :event :VeryLazy}
 {1 :Wansmer/treesj
  :keys [{1 :J
          2 :<cmd>TSJToggle<cr>
          :desc "Join Toggle"}]
  :opts {:max_join_length 150
         :use_default_keymaps false}}
 {1 :monaqa/dial.nvim
  :keys [:<C-a>
         {1 :<C-x>
          :mode :n}]}
 {:dir "~/projects/secret.nvim"}
 {:url "git@github.com:folke/noice.nvim.git"}
 [:folke/noice.nvim]]	
```

While simply unconfigured plugins are easy to read, those with configs become significantly less readable due the unnecessary character from using mixed tables.

Converting to the macros:

```fennel
[
(lazy.spec.init tokyonight
                (lazy.spec.repo.gh :folke/tokyonight.nvim)
                (lazy.spec.config #(vim.cmd "colorscheme tokyonight"))
                (lazy.spec.lazy? false)
                (lazy.spec.priority 1000))
(lazy.spec.init which-key
                (lazy.spec.repo.gh :folke/which-key.nvim)
                (lazy.spec.lazy? true))
(lazy.spec.init neorg
                (lazy.spec.repo.gh :nvim-neorg/neorg)
                (lazy.spec.load.ft :norg)
                (lazy.spec.opts {:load {:core.defaults {}}}))
(lazy.spec.init vim-startuptime
                (lazy.spec.repo.gh :dstein64/vim-startuptime)
                (lazy.spec.load.cmd :StartupTime)
                (lazy.spec.startup #(set vim.g.startuptime_tries 10)))
(lazy.spec.init nvim-cmp
                (lazy.spec.repo.gh :hrsh7th/nvim-cmp)
                (lazy.spec.config (fn []))
                (lazy.spec.dependencies [:hrsh7th/cmp-nvim-lsp :hrsh7th/cmp-buffer])
                (lazy.spec.load.event :InsertEnter))
(lazy.spec.init nvim-web-devicons
                (lazy.spec.repo.gh :nvim-tree/nvim-web-devicons)
                (lazy.spec.lazy? true))
(lazy.spec.init dressing
                (lazy.spec.repo.gh :stevearc/dressing.nvim)
                (lazy.spec.load.event :VeryLazy))
(lazy.spec.init treesj
                (lazy.spec.repo.gh :Wansmer/treesj)
                (lazy.spec.load.map :n :J :<cmd>TSJToggle<cr> "Join Toggle")
                (lazy.spec.opts {:max_join_length 150
                                 :use_default_keymaps false}))
(lazy.spec.init dial
                (lazy.spec.repo.gh :monaqa/dial.nvim)
                (lazy.spec.load.map [[:<C-a> nil "dial.nvim increment"]
                                     [:n :<C-x> "dial.nvim decrement"]]))
(lazy.spec.init secret
                (lazy.spec.repo.dir "~/projects/secret.nvim"))
(lazy.spec.init (lazy.spec.repo.url "git@github.com:folke/noice.nvim.git"))
(lazy.spec.init noice (lazy.spec.repo.gh :folke/noice.nvim))
]	
```
