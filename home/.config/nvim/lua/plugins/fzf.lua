vim.g.fzf_buffers_jump = 1
vim.g.fzf_action = { ['enter'] = 'tab drop', ['ctrl-x'] = 'split', ['ctrl-v'] = 'vsplit'}

vim.g.fzf_colors = {
  ['fg'] = { 'fg', 'Normal' },
  ['bg'] = { 'bg', 'Normal' },
  ['hl'] = { 'fg', 'Comment' },
  ['fg+'] = { 'fg', 'CursorLine', 'CursorColumn', 'Normal' },
  ['bg+'] = { 'bg', 'Normal' },
  ['hl+'] = { 'fg', 'Statement' },
  ['info'] = { 'fg', 'PreProc' },
  ['prompt'] = { 'fg', 'Conditional' },
  ['pointer'] = { 'fg', 'CursorLine' },
  ['marker'] = { 'fg', 'Keyword' },
  ['spinner'] = { 'fg', 'Label' },
  ['header'] = { 'fg', 'Comment' },
}

-- Hide statusline for fzf terminal buffer
vim.cmd([[
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
]])

-- mappings
vim.keymap.set("n", "<C-p>", ":FZF<CR>")
vim.call('esearch#map', '<C-f>', 'esearch')
vim.keymap.set("n", "<Leader>b", ":Buffers")
vim.keymap.set("n", "gst", ":Gfiles?")
if not vim.g.esearch then
  vim.g.esearch = {}
end
vim.g.esearch.backend = 'nvim'
vim.g.esearch.adapter = 'rg'
vim.g.esearch.regex = true
vim.g.esearch.case = true
