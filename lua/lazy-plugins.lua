local M = {}

---@type LazySpec
M.plugins = {
  -- Shows git changes in the sign column (added/removed/modified lines)
  require("kickstart/plugins/gitsigns"),
  -- Fuzzy finder for files, buffers, grep, and more
  require("kickstart/plugins/telescope"),
  -- Advanced syntax highlighting and code parsing
  -- require 'kickstart.plugins.debug',
  require("kickstart.plugins.neo-tree"),

  { import = "custom.plugins" },
  { import = "custom.lang" },
  { import = "custom.lint" },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}

---@module "lazy"
---@param opts LazyConfig
function M.load(opts)
  ---@type LazyConfig
  local _opts = {
    defaults = {
      lazy = true,
      version = false, -- always use latest git commit
    },
    install = {
      colorscheme = { "catppuccin", "habamax" },
    },
    -- checker = {
    --   enabled = true,
    --   notify = false,
    -- },
    change_detection = {
      notify = false,
    },
    performance = {
      cache = {
        enabled = true,
      },
      rtp = {
        disabled_plugins = {
          "gzip",
          -- "matchit",
          -- "matchparen",
          -- "netrwPlugin",
          "rplugin",
          "tarPlugin",
          "tohtml",
          "tutor",
          "zipPlugin",
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
        cmd = "⌘",
        config = "🛠",
        event = "📅",
        ft = "📂",
        init = "⚙",
        keys = "🗝",
        plugin = "🔌",
        runtime = "💻",
        require = "🌙",
        source = "📄",
        start = "🚀",
        task = "📌",
        lazy = "💤 ",
      },
      border = "rounded",
    },
  }

  require("lazy").setup(M.plugins, vim.tbl_deep_extend("force", _opts, opts or {}))
  require("filetypes")
end

return M
