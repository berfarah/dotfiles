-- Installed via `npm i -g vscode-langservers-extracted`
vim.lsp.enable('ts_ls')
vim.lsp.enable('eslint')
vim.lsp.enable('jsonls')

-- Recognize the following as json files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "CODEREVIEW,CODEFREEZE,GLOBS,CODECOVERAGE",
  command = "set filetype=json"
})
