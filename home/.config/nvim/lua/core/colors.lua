-- Syntax on by default
vim.opt.syntax = 'enable'

vim.opt.termguicolors = true
vim.opt.background = 'dark'
vim.cmd([[colorscheme hybrid_material]])
vim.g.hybrid_transparent_background = 1
vim.g.enable_italic_font = 1
vim.g.enable_bold_font = 1

vim.cmd([[
  hi DiffAdd    guibg=#333333 guifg=#d2ebbe ctermbg=none
  hi DiffChange guibg=#333333 guifg=#dad085 ctermbg=none
  hi DiffDelete guibg=#333333 guifg=#f0a0c0 ctermbg=none
]])
