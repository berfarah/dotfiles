vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.listchars = 'tab:  ,trail:·,nbsp:·'

vim.g.ale_fixers['go'] = {}
vim.g.ale_linters['go'] = {'go vet', 'gofmt'}

vim.cmd("compiler go")
