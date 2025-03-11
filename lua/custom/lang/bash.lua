---@module 'lazy'
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    ---@type TSConfig
    opts = {
      ensure_installed = { "bash" },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {}, -- runs shellcheck
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "shellcheck", "shfmt" },
    },
  },
}
