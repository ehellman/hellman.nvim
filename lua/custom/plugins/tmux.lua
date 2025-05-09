---@type LazySpec
return {
  {
    -- only used for clipboard
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    enabled = HellVim.is_tmux_term(),
    config = function()
      local tmux = require("tmux")
      tmux.setup({
        copy_sync = {
          enable = true, -- sync clipboard through tmux
          -- TMUX >= 3.2: all yanks (and deletes) will get redirected to system
          -- clipboard by tmux
          redirect_to_clipboard = true, -- defaults to false
        },
        navigation = {
          enable_default_keybindings = false,
        },
        resize = {
          enable_default_keybindings = false,
        },
      })
    end,
  },
  {
    -- navigation between tmux and nvim
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    enabled = HellVim.is_tmux_term(),
    keys = {
      -- stylua: ignore start
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "navigate left" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "navigate down" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "navigate up" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "navigate right" },
      -- stylua: ignore end
    },
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
      })
    end,
  },
}
