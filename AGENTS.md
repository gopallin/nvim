# Project Memory: Neovim Personal IDE Configuration

## Core Concepts
- Personal Neovim IDE setup managed with `lazy.vim`.
- Configuration is written in Lua.

## System Behavior
- `init.lua` is the main entry point.
- Plugin management and loading are handled via `lazy.vim`.
- Dependency versions are pinned by `lazy-lock.json` for reproducible setups.

## Architecture
- `init.lua`: bootstrap and top-level configuration loading.
- `lua/`
  - `config/`: core editor settings (options, keymaps, defaults).
  - `plugins/`: plugin specifications and per-plugin setup.
  - `utility/`: shared helper utilities.

## Key Rules and Constraints
- Repository is intended to be cloned into `~/.config/nvim`.
- Plugin state should stay compatible with `lazy-lock.json` when reproducibility is needed.

## Future-Relevant Notes
- Prefer updating plugin behavior in `lua/plugins/`.
- Keep core behavior changes in `lua/config/`.
- Keep reusable logic in `lua/utility/`.

