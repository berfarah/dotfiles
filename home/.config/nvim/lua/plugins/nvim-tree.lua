vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    renderer = {
      icons = {
        glyphs = {
          folder = {
            arrow_closed = "▸",
            arrow_open = "▾",
          },
        },
        show = {
          file = false,
          folder = false,
          git = false,
        },
      },
    },
    filters = {
      dotfiles = false,
    },
})

local nt_api = require("nvim-tree.api")
local nt = require("nvim-tree")

vim.keymap.set("n", "<leader>n", nt_api.tree.toggle)
vim.keymap.set("n", "<leader>\\", (function()
  nt.find_file(true)
end))
