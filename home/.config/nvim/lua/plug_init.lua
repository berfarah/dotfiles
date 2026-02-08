-- Install vim-plug if we don't already have it
vim.cmd([[
if empty(glob("~/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.config/nvim/init.lua
endif
]])

local Plug = vim.fn['plug#']
vim.call("plug#begin", "~/.config/nvim/plugged")

-- Theme
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

-- Tooling
Plug '/opt/homebrew/opt/fzf'
Plug('junegunn/fzf.vim', {['do'] = vim.fn['fzf#install']})
Plug 'tpope/vim-surround'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'eugen0329/vim-esearch'

-- Syntax
Plug 'sheerun/vim-polyglot'
Plug 'darfink/vim-plist'

-- Linting
Plug 'dense-analysis/ale'

-- LSP
Plug 'neovim/nvim-lspconfig'

-- Autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'

-- Snippets
Plug 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
Plug 'L3MON4D3/LuaSnip' -- Snippets plugin

-- Git
Plug 'lewis6991/gitsigns.nvim'
Plug 'tyru/open-browser.vim'
Plug 'tyru/open-browser-github.vim'

vim.call("plug#end")
