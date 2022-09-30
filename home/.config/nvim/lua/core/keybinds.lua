-- Define keymaps of Neovim and installed plugins.
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
vim.g.mapleader = ' '

-- Reselect visual block after indent/outdent
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "=", "=gv")

-- Key bindings

-- Make Y consistent with D
map("n", "Y", "y$")
-- Nobody ever uses "Ex" mode, and it's annoying to leave
map("", "Q", "<nop")
-- Paste using automatic indentation
map("", "<Leader>p", ":set paste<CR><esc>\"*]p:set nopaste<cr>")

-- Get full path of buffer
map("", "<Leader>cff", ":let @* = expand(\"%:p\")<CR>")
map("", "<Leader>cf", ":let @* = expand(\"%\")<CR>")

-- Get full directory of buffer
map("", "<Leader>cdd", ":let @* = expand(\"%:p:h\")<CR>")
map("", "<Leader>cd", ":let @* = expand(\"%:h\")<CR>")

map("n", "<Leader>aj", "<Plug>(ale_next_wrap)")
map("n", "<Leader>ak", "<Plug>(ale_previous_wrap)")

-- Remove highlight
map("", "<Leader>h", ":noh<CR>")

-- Open current file in GitHub
map("", "<Leader>gh", ":OpenGithubFile<CR>")
