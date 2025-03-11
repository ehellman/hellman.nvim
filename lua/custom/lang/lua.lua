---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "stylua",
        -- 'luacheck',
        -- 'selene',
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "luadoc",
        "luap",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@module "lspconfig"
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              -- inlay_hints = {
              --   enable = true,
              -- },
              codelens = {
                enable = true,
              },
              telemetry = {
                enable = false,
              },
              completion = {
                -- Whether to show call snippets or not. When disabled, only the function name will be completed. When enabled, a "more complete" snippet will be offered.
                -- default: "Disable"
                -- options:
                ---- 'Disable' - only show function name
                ---- 'Replace' - only show the call snippet
                ---- 'Both' - show function name and snippet
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
              },
              hint = {
                -- enable inline hints
                enable = true,
                --
                -- whether parameter names should be hinted when typing out a function call.
                -- default: "All"
                -- options: 'Disable', 'All', 'Literal'
                paramName = "All",
                --
                -- show a hint for parameter types at a function definition. requires the parameters to be defined with @param
                -- default: true
                paramType = true,
                --
                -- whether to show a hint to add a semicolon to the end of a statement.
                -- default: "Sameline"
                -- options: 'Disable', 'Sameline', 'Everyline'
                -- semicolon = "Sameline",
                --
                -- show a hint next to array members displaying their index
                -- default: 'Auto'
                -- options: 'Auto', 'Disable', 'Enable'
                arrayIndex = "Disable",
                --
                -- show a hint to display the type being applied at assignment operations.
                -- default: false
                setType = true,
              },
              diagnostics = {
                unusedLocalExclude = { "_*" },
                disable = {
                  "inject-field",
                  "missing-fields",
                },
              },
            },
          },
        },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        -- ['lua'] = { 'luacheck', 'selene', 'stylua' },
      },
    },
  },
}
