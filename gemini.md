# Neovim Personal IDE Configuration

This project is a personal Integrated Development Environment (IDE) built on top of Neovim. It uses `lazy.vim` to manage plugins, and all configurations are written in Lua.

## Entry Point

The main entry point for this configuration is `init.lua`. All plugins and configuration files are loaded from this file.

## Project Structure

- `init.lua`: The starting point of the configuration.
- `lua/`: Contains all the Lua modules for configuration and plugins.
  - `lua/config/`: Core Neovim settings, autocommands, and keybindings.
  - `lua/plugins/`: Plugin specifications for `lazy.vim`.
  - `lua/utility/`: Utility functions used throughout the configuration.
- `lazy-lock.json`: The lockfile for `lazy.vim` to ensure reproducible plugin versions.

## Location

This configuration is intended to be located at `~/.config/nvim` on a user's local machine.

## Temporary Plugin Change

`fzf-lua` has been partially replaced by `telescope.nvim` as a temporary workaround for a bug.

**Bug Description:** After upgrading to Neovim 0.11, the floating window for `fzf-lua` no longer gains focus automatically, making it unusable.

**Current Status:** The root cause has not been identified, and various attempts to fix it have been unsuccessful. As a temporary measure, `telescope.nvim` is used for file finding (`<leader>ff`) and live grep (`<leader>fg`). This may be reverted if a solution for the `fzf-lua` bug is found.
