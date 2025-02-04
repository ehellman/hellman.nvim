-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    -- Automatically clean up broken neo-tree buffers saved in sessions
    auto_clean_after_session_restore = true,
    close_if_last_window = true,
    filesystem = {
      follow_current_file = { enabled = true },
      hide_dotfiles = false,
      hide_gitignored = false,
      -- Remains visible even if other settings would normally hide it
      always_show = {
        '.gitignore',
      },
      -- Remains hidden even if visible is toggled to true
      -- This overrides `always_show`
      never_show = {
        '.DS_Store',
        'Thumbs.db',
      },
      window = {
        mappings = {
          ['\\'] = 'close_window',
        },
      },
    },
  },
}
