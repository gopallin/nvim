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
