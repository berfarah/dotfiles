require('nvim-treesitter').setup({
  ensure_installed = {
    'go', 'gomod',
    'javascript', 'typescript',
    'json', 'css', 'scss', 'graphql', 'xml',
    'markdown', 'markdown_inline',
    'lua', 'vim', 'vimdoc',
  },
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
