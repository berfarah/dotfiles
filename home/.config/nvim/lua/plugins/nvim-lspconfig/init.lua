vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess:append "c" -- Don't include things like "1/2 results" in completion
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
   lspconfig.util.default_config,
   {
     flags = {debounce_text_changes = 150},
     capabilities = require('cmp_nvim_lsp').default_capabilities(),
     on_attach = function()
      vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
     end
   }
)

require('plugins/nvim-lspconfig.go')
require('plugins/nvim-lspconfig.lua')
require('plugins/nvim-lspconfig.js')
