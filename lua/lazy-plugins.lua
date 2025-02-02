-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.

local M = {}

---@type LazySpec
M.plugins = {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --

  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua

  -- Shows git changes in the sign column (added/removed/modified lines)
  require 'kickstart/plugins/gitsigns',
  -- Displays available keybindings in a popup menu
  require 'kickstart/plugins/which-key',
  -- Fuzzy finder for files, buffers, grep, and more
  require 'kickstart/plugins/telescope',
  -- Language Server Protocol
  require 'kickstart/plugins/lspconfig',
  -- Code formatting engine with multi-language support
  require 'kickstart/plugins/conform',
  -- Autocompletion plugin with LSP integration
  require 'kickstart/plugins/cmp',
  -- kickstart default theme
  -- require 'kickstart/plugins/tokyonight',
  -- Highlight and search TODO/FIXME/NOTE/etc comments
  require 'kickstart/plugins/todo-comments',
  -- Collection of minimal, independent UI improvements
  require 'kickstart/plugins/mini',
  -- Advanced syntax highlighting and code parsing
  require 'kickstart/plugins/treesitter',

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}

---@param opts LazyConfig
function M.load(opts)
  opts = vim.tbl_deep_extend('force', {
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          'gzip',
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          'rplugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        },
      },
    },
    diff = {
      -- diff command <d> can be one of:
      -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
      --   so you can have a different command for diff <d>
      -- * git: will run git diff and open a buffer with filetype git
      -- * terminal_git: will open a pseudo terminal with git diff
      -- * diffview.nvim: will open Diffview to show the diff
      cmd = "git",
    },
    ui = {
      -- If you are using a Nerd Font: set icons to an empty table which will use the
      -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
      icons = vim.g.have_nerd_font and {} or {
        cmd = '⌘',
        config = '🛠',
        event = '📅',
        ft = '📂',
        init = '⚙',
        keys = '🗝',
        plugin = '🔌',
        runtime = '💻',
        require = '🌙',
        source = '📄',
        start = '🚀',
        task = '📌',
        lazy = '💤 ',
      },
    },
  }, opts or {})

  require('lazy').setup(M.plugins, opts)
end

return M

-- require('lazy').setup({
--   -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
--   'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
--
--   -- NOTE: Plugins can also be added by using a table,
--   -- with the first argument being the link and the following
--   -- keys can be used to configure plugin behavior/loading/etc.
--   --
--   -- Use `opts = {}` to force a plugin to be loaded.
--   --
--
--   -- modular approach: using `require 'path/name'` will
--   -- include a plugin definition from file lua/path/name.lua
--
--   -- Shows git changes in the sign column (added/removed/modified lines)
--   require 'kickstart/plugins/gitsigns',
--   -- Displays available keybindings in a popup menu
--   require 'kickstart/plugins/which-key',
--   -- Fuzzy finder for files, buffers, grep, and more
--   require 'kickstart/plugins/telescope',
--   -- Language Server Protocol
--   require 'kickstart/plugins/lspconfig',
--   -- Code formatting engine with multi-language support
--   require 'kickstart/plugins/conform',
--   -- Autocompletion plugin with LSP integration
--   require 'kickstart/plugins/cmp',
--   -- kickstart default theme
--   -- require 'kickstart/plugins/tokyonight',
--   -- Highlight and search TODO/FIXME/NOTE/etc comments
--   require 'kickstart/plugins/todo-comments',
--   -- Collection of minimal, independent UI improvements
--   require 'kickstart/plugins/mini',
--   -- Advanced syntax highlighting and code parsing
--   require 'kickstart/plugins/treesitter',
--
--   -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
--   -- init.lua. If you want these files, they are in the repository, so you can just download them and
--   -- place them in the correct locations.
--
--   -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
--   --
--   --  Here are some example plugins that I've included in the Kickstart repository.
--   --  Uncomment any of the lines below to enable them (you will need to restart nvim).
--   --
--   -- require 'kickstart.plugins.debug',
--   -- require 'kickstart.plugins.indent_line',
--   require 'kickstart.plugins.lint',
--   require 'kickstart.plugins.autopairs',
--   require 'kickstart.plugins.neo-tree',
--
--   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
--   --    This is the easiest way to modularize your config.
--   --
--   --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
--   { import = 'custom.plugins' },
--   --
--   -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
--   -- Or use telescope!
--   -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
--   -- you can continue same window with `<space>sr` which resumes last telescope search
-- }, {
--   performance = {
--     cache = {
--       enabled = true,
--     },
--     rtp = {
--       disabled_plugins = {
--         'nvim-neo-tree/neo-tree.nvim',
--         'gzip',
--         -- "matchit",
--         -- "matchparen",
--         -- "netrwPlugin",
--         'rplugin',
--         'tarPlugin',
--         'tohtml',
--         'tutor',
--         'zipPlugin',
--       },
--     },
--   },
--   ui = {
--     -- If you are using a Nerd Font: set icons to an empty table which will use the
--     -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
--     icons = vim.g.have_nerd_font and {} or {
--       cmd = '⌘',
--       config = '🛠',
--       event = '📅',
--       ft = '📂',
--       init = '⚙',
--       keys = '🗝',
--       plugin = '🔌',
--       runtime = '💻',
--       require = '🌙',
--       source = '📄',
--       start = '🚀',
--       task = '📌',
--       lazy = '💤 ',
--     },
--   },
-- })

-- vim: ts=2 sts=2 sw=2 et
