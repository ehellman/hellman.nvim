-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- enabled = vim.g.cmp_variant == 'cmp',
  enabled = false,
  lazy = true,
  -- Optional dependency
  -- dependencies = function()
  --   if vim.g.cmp_variant ~= 'cmp' then
  --     return {
  --       'hrsh7th/nvim-cmp',
  --     }
  --   else
  --     return {}
  --   end
  -- end,
  -- dependencies = {
  --   'hrsh7th/nvim-cmp',
  --   -- 'saghen/blink.cmp',
  -- },
  dependencies = {
    { 'hrsh7th/nvim-cmp', enabled = vim.g.cmp_variant == 'cmp' },
    { 'saghen/blink.cmp', enabled = vim.g.cmp_variant == 'blink' },
  },
  config = function()
    require('nvim-autopairs').setup({})
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
