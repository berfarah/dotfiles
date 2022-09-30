vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false
vim.opt_local.listchars = 'tab:  ,trail:·,nbsp:·'

vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_arguments = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_generate_tags = 1
vim.g.go_highlight_methods = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_structs = 1
vim.g.go_highlight_types = 1

vim.g.go_def_mode="gopls"
vim.g.go_info_mode="gopls"

vim.g.ale_fixers['go'] = {}
vim.g.ale_linters['go'] = {'go vet', 'gofmt'}

vim.cmd("compiler go")
