---@module 'lazy'
---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "xml", "html" } },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "xml", "html" },
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        xml = { "prettierd" },
        html = { "prettierd" },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = { "prettierd" },
    },
  },
}
