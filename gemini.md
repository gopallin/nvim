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
