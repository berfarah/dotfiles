vim.g.loaded_netrw = 1
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

local api = require("nvim-tree.api")

vim.keymap.set("n", "<leader>n", api.tree.toggle)
vim.keymap.set("n", "<leader>\\", (function()
  api.tree.toggle({find_file = true})
end))
