require('lspconfig').sumneko_lua.setup({
  settings = {
    Lua = {
      version = 'LuaJIT',
      diagnostics = { globals = { 'vim', 'require' } },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.stdpath('config') .. '/lua'] = true,
        },
      },
    }
  }
})
