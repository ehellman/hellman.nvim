return {
  'echasnovski/mini.surround',
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  -- event = { 'CursorHold', 'CursorHoldI' },
  event = {
    'BufReadPost',
    'BufNewFile',
    'BufWritePre',
  },
  config = function(_, opts)
    require('mini.surround').setup(vim.tbl_extend('force', opts, {
      mappings = {
        add = 'gza', -- Add surrounding in Normal and Visual modes
        delete = 'gzd', -- Delete surrounding
        find = 'gzf', -- Find surrounding (to the {}right)
        find_left = 'gzF', -- Find surrounding (to the left)
        highlight = 'gzh', -- Highlight surrounding
        replace = 'gzr', -- Replace surrounding
        update_n_lines = 'gzn', -- Update `n_lines`
      },
    }))
  end,
  keys = {
    { 'gz', '', desc = '+surround' },
  },
}
