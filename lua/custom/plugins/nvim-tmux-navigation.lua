---@type LazySpec
return {
  'alexghergh/nvim-tmux-navigation',
  event = 'VeryLazy',
  config = function()
    require('nvim-tmux-navigation').setup({
      disable_when_zoomed = true, -- defaults to false
    })

    vim.keymap.set('n', '<C-h>', '<Cmd>NvimTmuxNavigateLeft<CR>', {})
    vim.keymap.set('n', '<C-j>', '<Cmd>NvimTmuxNavigateDown<CR>', {})
    vim.keymap.set('n', '<C-k>', '<Cmd>NvimTmuxNavigateUp<CR>', {})
    vim.keymap.set('n', '<C-l>', '<Cmd>NvimTmuxNavigateRight<CR>', {})
  end,
}
