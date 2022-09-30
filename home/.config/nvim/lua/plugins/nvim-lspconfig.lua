vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.shortmess:append "c" -- Don't include things like "1/2 results" in completion
vim.g.completion_matching_strategy_list = {"exact", "substring", "fuzzy"}

local lspconfig = require('lspconfig')
require('nvim-lsp-installer').setup({})

local lsp_defaults = {
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = require('cmp_nvim_lsp').update_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}

lspconfig.util.default_config = vim.tbl_deep_extend(
  'force',
  lspconfig.util.default_config,
  lsp_defaults
)

lspconfig.sumneko_lua.setup({
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

local util = require "lspconfig/util"

lspconfig.gopls.setup({
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      staticcheck = false,
      experimentalWorkspaceModule = true,
      experimentalUseInvalidMetadata = true,
      usePlaceholders = true,
      -- build.memoryMode = "DegradeClosed",
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

lspconfig.eslint.setup({})

lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = {
        taskrunner = {
          fileMatch = {"/*.taskrunner.json"},
          url = "./go/src/samsaradev.io/vendor/github.com/samsarahq/taskrunner/schema.json"
        },
        {
          fileMatch = {"*/CODEREVIEW"},
          url = "./go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/codereview_schema.json"
        },
        {
          fileMatch = {"*/CODEFREEZE"},
          url = "./go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/codefreeze_schema.json"
        },
        {
          fileMatch = {"*/GLOBS"},
          url = "./go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/globs_schema.json"
        },
        {
          fileMatch = {"*/CODECOVERAGE"},
          url = "./go/src/samsaradev.io/infra/devtools/cmd/coveragechecker/generatecoverageschema/coveragechecker_schema.json"
        },
        {
          fileMatch = {"**/feature_flags.json"},
          url = "./go/src/samsaradev.io/infra/releasemanagement/internal/backendfeaturescompiler/featureflags_schema.json"
        },
        {
          fileMatch = {"dataplatform/notebooks/**/*.metadata.json"},
          url = "./dataplatform/_json_schemas/metadata_schema.json"
        },
        {
          fileMatch = {"dataplatform/tables/sqlview/**/*.json"},
          url = "./dataplatform/_json_schemas/s3view_schema.json"
        },
        {
          fileMatch = {"dataplatform/tables/s3data/**/*.json"},
          url = "./dataplatform/_json_schemas/s3table_schema.json"
        },
        {
          fileMatch = {"tui_config.json"},
          url = "./go/src/samsaradev.io/app/taskrunner/tuiconfig/tui_config_schema.json"
        }
      },
    },
  },
})

-- install jsonls for json-schema (replaces quramy vison)
