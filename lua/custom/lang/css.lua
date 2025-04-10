---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "cssls",
        "cssmodules_ls",
        "prettierd",
        "tailwindcss",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "css", "scss" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {
          enabled = true,
          settings = {
            css = {
              lint = {
                -- useful for waybar, tailwind etc
                unknownAtRules = "ignore",
              },
            },
          },
        },
        cssmodules_ls = {},
        -- css_variables = {
        --   settings = {
        --     cssVariables = {
        --       blacklistFolders = {
        --         "**/.cache",
        --         "**/.DS_Store",
        --         "**/.git",
        --         "**/.cache",
        --         "**/.hg",
        --         "**/.next",
        --         "**/.svn",
        --         "**/bower_components",
        --         "**/CVS",
        --         "**/dist",
        --         "**/node_modules",
        --         "**/tests",
        --         "**/tmp",
        --       },
        --     },
        --   },
        -- },
        tailwindcss = {
          autostart = false,
        },
      },
    },
  },
  {
    -- conform
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        css = { "prettierd" },
        scss = { "prettierd" },
        less = { "prettierd" },
      },
    },
  },
}
