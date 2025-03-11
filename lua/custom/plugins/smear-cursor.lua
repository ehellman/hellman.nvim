---@type LazySpec
return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  cond = vim.g.neovide == nil,
  opts = {
    -- Smear cursor when switching buffers or windows.
    -- smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    -- smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    -- scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    -- legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    -- smear_insert_mode = true,

    -- Attempt to hide the real cursor by drawing a character below it.
    -- Can be useful when not using `termguicolors`
    hide_target_hack = true,

    -- Smear cursor color. Defaults to Cursor GUI color if not set.
    -- Set to "none" to match the text color at the target cursor position.
    cursor_color = "none",

    -- stiffness = 0.8, -- 0.6      [0, 1]
    -- trailing_stiffness = 0.5, -- 0.3      [0, 1]
    -- distance_stop_animating = 0.5, -- 0.1      > 0
  },
  config = function(_, opts)
    require("smear_cursor").setup(opts)

    Snacks.toggle({
      name = "Smear Cursor",
      get = function()
        return require("smear_cursor").enabled
      end,
      set = function()
        require("smear_cursor").toggle()
      end,
    }):map("<leader>uc")
  end,
  specs = {
    -- disable mini.animate cursor
    {
      "echasnovski/mini.animate",
      optional = true,
      opts = {
        cursor = { enable = false },
      },
    },
  },
}
