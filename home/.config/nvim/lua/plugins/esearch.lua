vim.g.esearch = {
  backend = 'nvim',
  adapter = 'rg',
  regex = true,
  case = true,
}

vim.call('esearch#map', '<C-f>', 'esearch')
