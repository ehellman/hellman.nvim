return {
  'luckasRanarison/tailwind-tools.nvim',
  lazy = true,
  -- event = 'VeryLazy',
  event = {
    'BufReadPost',
    'BufNewFile',
    'BufWritePre',
  },
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    -- 'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  init = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.name == 'tailwindcss' then
          require('tailwind-tools')
          return true
        end
      end,
    })
  end,
  opts = {
    -- conceal = {
    --   symbol = '…',
    -- },
  },
  config = function(_, opts)
    require('tailwind-tools').setup(opts)
    -- custom.cmp_format.before = require('tailwind-tools.cmp').lspkind_format
  end,
  keys = {
    { '<leader>ctc', '<cmd>TailwindConcealToggle<CR>', desc = 'Toggle tailwind conceal' },
    { '<leader>cts', '<cmd>TailwindSort<CR>', desc = 'Sort tailwind classes' },
    { '<leader>ctp', '<cmd>TailwindPrevClass<CR>', desc = 'Move to the next class' },
    { '<leader>ctn', '<cmd>TailwindNextClass<CR>', desc = 'Move to the previous class' },
  },
}
