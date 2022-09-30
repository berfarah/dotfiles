require('gitsigns').setup {
  current_line_blame = true,
  on_attach = function (bufnr)
    -- local gs = package.loaded.gitsigns

    -- local map = require('utils').map
    -- map('n
  end
}

-- Override the Sign Column to defautl to reasonable colors
vim.cmd("hi! SignColumn guibg=NONE guifg=NONE ctermfg=NONE")
