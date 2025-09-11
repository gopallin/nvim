# Neovim Personal IDE Configuration

This is a personal Integrated Development Environment (IDE) configuration for Neovim, managed with `lazy.vim` and Lua.

## Installation

Clone this repository to your `~/.config/nvim` directory:

```bash
git clone <repository-url> ~/.config/nvim
```

## Structure

- `init.lua`: The main entry point for the configuration.
- `lua/`: Contains all Lua modules.
  - `lua/config/`: Core Neovim settings (options, keybindings, etc.).
  - `lua/plugins/`: Plugin configurations for `lazy.vim`.
  - `lua/utility/`: Utility functions.
- `lazy-lock.json`: `lazy.vim` lockfile for reproducible builds.

## Temporary Plugin Change

Some functions of `fzf-lua` have been temporarily replaced with `telescope.nvim`. This is due to an unresolved bug with `fzf-lua`'s floating window focus that appeared after upgrading to Neovim 0.11. This may be revisited in the future.
