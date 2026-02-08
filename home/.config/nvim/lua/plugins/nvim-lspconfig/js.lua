vim.lsp.enable('eslint')

-- Recognize the following as json files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "CODEREVIEW,CODEFREEZE,GLOBS,CODECOVERAGE",
  command = "set filetype=json"
})

-- Find root git directory for relative file links
local root_dir = vim.fs.dirname(vim.fs.find('.git', { path = startpath, upward = true })[1]) or ""

-- Installed via `npm i -g vscode-langservers-extracted`
vim.lsp.config('jsonls', {
  settings = {
    json = {
      schemas = {},
    },
  },
})

vim.lsp.enable('jsonls')
