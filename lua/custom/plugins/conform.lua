---@type LazySpec
return {
  -- {
  --   'williamboman/mason.nvim',
  --   opts = {
  --     ensure_installed = {
  --       'stylua',
  --     },
  --   },
  -- },
  {
    ---@module "conform"
    "stevearc/conform.nvim",
    event = { "BufReadPost" },
    cmd = { "ConformInfo" },
    init = function()
      -- Install the conform formatter on VeryLazy
      HellVim.on_very_lazy(function()
        HellVim.format.register({
          name = "conform.nvim",
          priority = 100,
          primary = true,
          format = function(buf)
            require("conform").format({
              bufnr = buf,
            })
          end,
          sources = function(buf)
            local ret = require("conform").list_formatters(buf)
            ---@param v conform.FormatterInfo
            return vim.tbl_map(function(v)
              return v.name
            end, ret)
          end,
        })
      end)
    end,
    keys = {
      {
        "<leader>cf",
        function()
          HellVim.format({ force = true })
          -- require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "[F]ormat buffer",
      },
    },
    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      -- format_on_save = {
      --   timeout_ms = 3000,
      --   -- timeout_ms = 30,
      --   async = false, -- change when moving to lazyvim utils.format
      --   -- async = false, -- not recommended to change
      --   quiet = false, -- not recommended to change00,
      --   lsp_format = "fallback",
      -- },

      -- log_level = vim.log.levels.DEBUG,
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   local lsp_format_opt
      --   if disable_filetypes[vim.bo[bufnr].filetype] then
      --     lsp_format_opt = 'never'
      --   else
      --     lsp_format_opt = 'last'
      --     -- lsp_format_opt = 'fallback'
      --   end
      --   return {
      --     timeout_ms = 500,
      --     lsp_format = lsp_format_opt,
      --   }
      -- end,
      -- formatters_by_ft = {
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      -- python = { 'black' },
      -- }
    },
    config = function(_, opts)
      require("conform").setup(opts)
    end,
  },
}
