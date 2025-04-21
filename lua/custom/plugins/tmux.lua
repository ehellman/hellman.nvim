---@type LazySpec
return {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
  config = function()
    local tmux = require("tmux")
    tmux.setup({
      copy_sync = {
        enable = true, -- sync clipboard through tmux
      },
      navigation = {
        cycle_navigation = false,
        enable_default_keybindings = false,
        persist_zoom = true,
      },
      resize = {
        enable_default_keybindings = false,
      },
    })
  end,
}
