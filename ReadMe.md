# nvim-anisole macros
These are fennel macros for neovim. Care has been taken to make each macro easily understandable as much as possible.

# Reference

- [Autocommands](/doc/reference/fnl/nvim-anisole-macros/autocmds.md)
- [Commands](/doc/reference/fnl/nvim-anisole-macros/commands.md)
- [Maps](/doc/reference/fnl/nvim-anisole-macros/maps.md)
- [Options](/doc/reference/fnl/nvim-anisole-macros/options.md)

# Documentation

- [Naming Conventions](/doc/namingconventions.md)
- [Signatures](/doc/signatures.md)
- [Neovim Maps](/doc/neovim/maps.md)
- [Neovim Commands](/doc/neovim/commands.md)
- [Neovim Options](/doc/neovim/options.md)
- [Neovim Autocommands](/doc/neovim/autocmds.md)

# Usage
These macros are primarily meant for Neovim, but can be used for anything if needed.

## This Repo as a Neovim Package
If using these macros, say for Neovim configs or a standalone Fennel project (through Hotpot or Tangerine), simply add this repo to your package manager. This will allow access to these macros globally without requiring integration into your project directly. This method is not suggested for plugins as macros can become out of sync, whereas a git subtree only updates whenever the plugin is updated by you.

Since these are compile time dependencies, you may find that your Fennel config files won't be able to compile, you can add this repo to your `init.lua` bootstrap before the compile call. See below for an example:

```lua
local execute = vim.api.nvim_command
local fn = vim.fn
local fmt = string.format

-- make the package path ~/.local/share/nvim/plug
local packer_path = fn.stdpath("data") .. "/site/pack"

function ensure (user, repo)
	local install_path = fmt("%s/packer/start/%s", packer_path, repo, repo)
	if fn.empty(fn.glob(install_path)) > 0 then
		execute(fmt("!git clone https://github.com/%s/%s %s", user, repo, install_path))
		execute(fmt("packadd %s", repo))
	end
end
ensure("wbthomason", "packer.nvim")
ensure("katawful", "nvim-anisole-macros")
-- load compiler
ensure("Olical", "aniseed")
-- load aniseed environment
vim.g["aniseed#env"] = {module = "init"}
```

The path for this method is: `nvim-anisole-macros.macro-path`.

# Development
To test these macros, run the script in `scripts/setup-test-deps.sh`. Then run `make test` using the makefile. Plenary and an installation of Olical/nfnl is used for testing.

Compilation is provided through Olical/nfnl

# License
This is licensed under Unlicense.
