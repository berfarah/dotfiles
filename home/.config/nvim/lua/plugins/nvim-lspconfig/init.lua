vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess:append "c" -- Don't include things like "1/2 results" in completion
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

vim.lsp.config('*', {
  flags = {debounce_text_changes = 150},
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('plugins/nvim-lspconfig.go')
require('plugins/nvim-lspconfig.lua')
require('plugins/nvim-lspconfig.js')
