vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      version = 'LuaJIT',
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        library = {
          vim.fn.expand('$VIMRUNTIME/lua'),
          vim.fn.stdpath('config') .. '/lua',
        },
      },
    }
  }
})
vim.lsp.enable('lua_ls')
