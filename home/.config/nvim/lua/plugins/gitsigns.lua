require('gitsigns').setup {
  current_line_blame = true,
}

-- Override the Sign Column to defautl to reasonable colors
vim.cmd("hi! SignColumn guibg=NONE guifg=NONE ctermfg=NONE")
