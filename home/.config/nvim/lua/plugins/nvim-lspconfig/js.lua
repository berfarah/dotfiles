local lspconfig = require('lspconfig')


lspconfig.eslint.setup({})


-- Recognize the following as json files
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "CODEREVIEW,CODEFREEZE,GLOBS,CODECOVERAGE",
  command = "set filetype=json"
})

-- Find root git directory for relative file links
local root_dir = lspconfig.util.find_git_ancestor(vim.fn.getcwd()) or ""

-- Installed via `npm i -g vscode-langservers-extracted`
lspconfig.jsonls.setup({
  settings = {
    json = {
      schemas = {
        {
          description = "Taskrunner Config",
          fileMatch = {"*.taskrunner.json"},
          url = root_dir .. "/go/src/samsaradev.io/vendor/github.com/samsarahq/taskrunner/schema.json"
        },
        {
          description = "Codereview Owners",
          fileMatch = {"CODEREVIEW"},
          url = root_dir .. "/go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/codereview_schema.json"
        },
        {
          description = "Codefreeze Owners",
          fileMatch = {"CODEFREEZE"},
          url = root_dir .. "/go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/codefreeze_schema.json"
        },
        {
          description = "Codefreeze Globs",
          fileMatch = {"GLOBS"},
          url = root_dir .. "/go/src/samsaradev.io/infra/devtools/internal/codereviewmachine/config/globs_schema.json"
        },
        {
          description = "Code Coverage Configuration",
          fileMatch = {"CODECOVERAGE"},
          url = root_dir .. "/go/src/samsaradev.io/infra/devtools/cmd/coveragechecker/generatecoverageschema/coveragechecker_schema.json"
        },
        {
          description = "Backend Feature Flags",
          fileMatch = {"**/feature_flags.json"},
          url = root_dir .. "/go/src/samsaradev.io/infra/releasemanagement/internal/backendfeaturescompiler/featureflags_schema.json"
        },
        {
          description = "Databricks Notebooks",
          fileMatch = {"dataplatform/notebooks/**/*.metadata.json"},
          url = root_dir .. "/dataplatform/_json_schemas/metadata_schema.json"
        },
        {
          description = "Databricks Views",
          fileMatch = {"dataplatform/tables/sqlview/**/*.json"},
          url = root_dir .. "/dataplatform/_json_schemas/s3view_schema.json"
        },
        {
          description = "Databricks Tables",
          fileMatch = {"dataplatform/tables/s3data/**/*.json"},
          url = root_dir .. "/dataplatform/_json_schemas/s3table_schema.json"
        },
        {
          description = "Taskrunner TUI Config",
          fileMatch = {"tui_config.json"},
          url = root_dir .. "/go/src/samsaradev.io/app/taskrunner/tuiconfig/tui_config_schema.json"
        }
      },
    },
  },
})
