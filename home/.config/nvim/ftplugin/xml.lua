vim.cmd([[
if executable('xmllint')
  command! Format :%!xmllint --format -
endif
]])
