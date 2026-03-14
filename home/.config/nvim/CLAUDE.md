# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim (0.11+) configuration written entirely in Lua. It is part of a larger dotfiles repo and lives at `home/.config/nvim/`. Plugins are managed with [lazy.nvim](https://github.com/folke/lazy.nvim) (auto-bootstrapped on first launch).

## Commands

- **Plugin UI:** `:Lazy` (install, update, clean, profile)
- **Check LSP status:** `:LspInfo`
- **Validate config syntax:** `nvim --headless -c 'quit'` (exits cleanly if no errors)

## Architecture

### Loading order (`init.lua`)

1. `plug_init` — bootstraps lazy.nvim and declares all plugins
2. `core/options` — editor settings (indentation, undo/backup paths, whitespace trimming)
3. `core/keybinds` — global keymaps (leader is `<Space>`)
4. `core/colors` — theme (`hybrid_material`, dark, transparent background)
5. `plugins/*` — individual plugin configurations

### Key directories

- `lua/core/` — editor fundamentals (options, keybinds, colors)
- `lua/plugins/` — per-plugin config files, each loaded explicitly from `init.lua`
- `lua/plugins/nvim-lspconfig/` — LSP server configs split by language (go, js, lua)
- `ftplugin/` — filetype-specific overrides (tab width, ALE fixers/linters, spell check)
- lazy.nvim installs plugins to `~/.local/share/nvim/lazy/` (not user-managed)

### Plugin stack

| Category | Plugins |
|---|---|
| Theme | `vim-hybrid-material`, `vim-airline` |
| Fuzzy finding | `fzf` + `fzf.vim`, `vim-esearch` (ripgrep backend) |
| LSP | `nvim-lspconfig` (gopls, eslint, jsonls, lua_ls) |
| Completion | `blink.cmp` with built-in sources: LSP, buffer, path, snippets |
| Linting | ALE (fix-on-save enabled; fixers configured per-filetype in `ftplugin/`) |
| File tree | `nvim-tree` |
| Git | `gitsigns.nvim` (inline blame), `open-browser-github.vim` |
| Editing | `vim-surround`, `nvim-treesitter` |

### Conventions

- Keybindings use `vim.keymap.set` throughout (defaults to `noremap`). `core/keybinds.lua` has a local `map` wrapper that adds `silent = true`.
- Filetype-specific ALE fixers/linters are set in `ftplugin/<lang>.lua` by mutating `vim.g.ale_fixers` / `vim.g.ale_linters`.
- LSP configs use the native `vim.lsp.config()` / `vim.lsp.enable()` API (not the older `lspconfig.server.setup()` pattern). `nvim-lspconfig` is kept for default server configs.
- LSP keymaps (gd, gr, K, etc.) are attached via an `LspAttach` autocmd in `plugins/blink-cmp.lua`.
- Diagnostics navigation uses `vim.diagnostic.jump()` (not the deprecated `goto_prev`/`goto_next`).
- Commenting uses Neovim's built-in `gc`/`gcc` (no plugin needed).
- Default indentation is 2 spaces; Go overrides to hard tabs (4-wide) in `ftplugin/go.lua`.
- Whitespace is auto-trimmed on every buffer write.
