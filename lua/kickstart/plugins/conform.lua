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
    'stevearc/conform.nvim',
    -- event = { 'BufWritePre' },
    event = 'VeryLazy',
    cmd = { 'ConformInfo' },
    dependencies = {
      -- 'williamboman/mason.nvim',
    },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    -- opts_extend = { 'formatters_by_ft' },

    ---@type conform.setupOpts
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
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
      formatters_by_ft = {
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- python = { 'black' },
        --
        -- yaml = { 'yamlfmt' },
        javascriptreact = { 'prettier', stop_after_first = true },
        typescriptreact = { 'prettier', stop_after_first = true },
        javascript = { 'prettier', stop_after_first = true },
        typescript = { 'prettier', stop_after_first = true },
      },
    },
    config = function(_, opts)
      -- print('conform formatters', vim.inspect(opts))
      require('conform').setup(opts)
    end,
  },
}
