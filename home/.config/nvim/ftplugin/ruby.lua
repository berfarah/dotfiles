vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.expandtab = true

vim.g.ruby_path = vim.cmd("system('rbenv prefix')")
vim.g.ale_fixers.ruby = {'rubocop'}
vim.g.rubycomplete_rails = 0
