-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Helpers: load lua/plugins/<name>.lua before or after a plugin loads
local function init(mod) return function() require('plugins/' .. mod) end end
local function config(mod) return function() require('plugins/' .. mod) end end

require("lazy").setup({
  -- Theme
  { 'kristijanhusak/vim-hybrid-material', lazy = false, priority = 1000 },
  { 'vim-airline/vim-airline', lazy = false, dependencies = { 'vim-airline/vim-airline-themes' }, init = init('airline') },

  -- Tooling
  { 'junegunn/fzf.vim', dependencies = {{ dir = vim.fn.system('brew --prefix fzf'):gsub('%s+$', '') }}, init = init('fzf') },
  'tpope/vim-surround',
  { 'nvim-tree/nvim-tree.lua', dependencies = { 'lewis6991/gitsigns.nvim' }, config = config('nvim-tree') },
  { 'eugen0329/vim-esearch', config = config('esearch') },

  -- Syntax
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', config = config('treesitter') },
  'darfink/vim-plist',

  -- Linting
  { 'dense-analysis/ale', init = init('ale') },

  -- LSP & Completion
  { 'saghen/blink.cmp', version = '*' },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      require('plugins/blink-cmp')
      require('plugins/nvim-lspconfig')
    end,
  },

  -- Git
  { 'lewis6991/gitsigns.nvim', config = config('gitsigns') },
  { 'tyru/open-browser-github.vim', dependencies = { 'tyru/open-browser.vim' } },
})
