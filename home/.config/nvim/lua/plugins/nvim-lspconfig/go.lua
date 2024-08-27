local util = require "lspconfig/util"
local org_imports = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({buffer=bufnr})
  for _, client in pairs(clients) do

    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = {only = {"source.organizeImports"}}

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end

local lspconfig = require('lspconfig')
lspconfig.gopls.setup({
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
          org_imports()
          vim.lsp.buf.format({async=false})
        end
    })
    lspconfig.util.default_config.on_attach()
  end,
  settings = {
    gopls = {
      ["local"] = "samsaradev.io",
      staticcheck = false,
      usePlaceholders = true,
      memoryMode = "DegradeClosed",
      codelenses = {
        gc_details = false,
        generate = false,
        regenerate_cgo = true,
        tidy = false,
        upgrade_dependency = false,
        vendor = false,
        test = false,
      },
    },
  },
})
