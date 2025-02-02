return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim', -- optional
    'neovim/nvim-lspconfig', -- optional
  },
  opts = {},
  keys = {
    { '<leader>ttc', '<cmd>TailwindConcealToggle<CR>', desc = 'Toggle tailwind conceal' },
    { '<leader>tts', '<cmd>TailwindSort<CR>', desc = 'Sort tailwind classes' },
    { '<leader>ttp', '<cmd>TailwindPrevClass<CR>', desc = 'Move to the next class' },
    { '<leader>ttn', '<cmd>TailwindNextClass<CR>', desc = 'Move to the previous class' },
  },
}
