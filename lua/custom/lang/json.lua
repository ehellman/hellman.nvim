---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "json5", "jsonc" } },
  },
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "jsonls",
        "jsonlint",
        "prettierd",
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        json = { "jsonlint" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        json = { "prettierd" },
        jsonc = { "prettierd" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    --   'williamboman/mason.nvim',
    --   'nvim-treesitter/nvim-treesitter',
    --   'b0o/SchemaStore.nvim',
    --   'mfussenegger/nvim-lint',
    -- },
    opts = {
      -- make sure mason installs the server
      servers = {
        jsonls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
      },
    },
  },
}
