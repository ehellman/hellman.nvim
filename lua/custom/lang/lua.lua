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
        ["lua"] = { "stylua" },
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
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              inlay_hints = {
                enable = true,
              },
              telemetry = {
                enable = false,
              },
              hover = { expandAlias = false },
              type = {
                castNumberToInteger = true,
              },
              hint = {
                paramName = "All",
                paramType = true,
                arrayIndex = "Disable",
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
