local lspconfig = require('lspconfig')

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
