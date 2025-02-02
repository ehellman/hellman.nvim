local base_minus_1 = '#262637'

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
    opts = {
      compile_path = vim.fn.stdpath 'cache' .. '/nvim/catppuccin',
      flavour = 'mocha',
      no_italic = 'true',
      term_colors = false,
      -- transparent_background = 'true',
      custom_highlights = function(colors)
        return {
          WinSeparator = { fg = colors.surface1, style = { 'bold' } },

          -- CursorLineNR = { fg = colors.mauve },
          -- CursorLine = { bg = colors.base },
          --
          -- LineNr = { fg = colors.surface2 },

          -- TelescopeNormal = { bg = colors.mantle },
          -- TelescopeBorder = { bg = colors.mantle, fg = colors.mantle },
          --
          -- TelescopePrompt = { bg = colors.surface1 },
          -- TelescopePromptNormal = { bg = colors.surface0 },
          -- TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
          -- TelescopePromptPrefix = { bg = colors.surface0, fg = colors.peach },
          --
          -- TelescopePromptTitle = { bg = colors.peach, fg = colors.base, style = { 'bold' } },
          -- TelescopeResultsTitle = { bg = colors.mantle, fg = colors.base, style = { 'bold' } },
          -- TelescopePreviewTitle = { bg = colors.green, fg = colors.base, style = { 'bold' } },
          --
          -- TelescopeResults = { bg = colors.mantle },
          -- TelescopeResultsNormal = { bg = colors.mantle, fg = colors.subtext0 },
          -- TelescopeSelection = { bg = base_minus_1, fg = colors.lavender },
          -- TelescopeSelectionCaret = { bg = base_minus_1, fg = colors.lavender },
          -- TelescopeMatching = { fg = colors.green, style = { 'bold', 'underline' } },

          -- Comment = { fg = colors.flamingo },

          -- CmpNormal = { bg = colors.base },
          -- CmpBorder = { bg = colors.base, fg = colors.crust },
          -- CmpBorder = { bg = colors.base, fg = colors.red, style = { 'bold' } },
          CmpNormal = { bg = colors.base },
          CmpBorder = { bg = colors.base, fg = colors.surface0 },
          CmpBorderTitle = { fg = colors.green, bg = colors.surface0, style = { 'bold' } },
          CmpSelect = { bg = colors.surface1, fg = colors.text },

          -- CmpItemAbbr = { fg = colors.subtext1 },
          -- CmpItemKindKeyword = { fg = colors.subtext1 },
          -- CmpItemAbbrMatch = { fg = colors.blue },

          CmpDocNormal = { bg = colors.base, fg = colors.subtext0 },
          CmpDocBorder = { bg = colors.base, fg = colors.surface0, style = { 'bold' } },
          -- CmpDocBorderTitle = { fg = colors.green, bg = colors.mantle, style = { 'bold' } },
          -- CmpDocSelect = { bg = colors.base },
        }
      end,
      highlight_overrides = {
        all = function(colors)
          return {}
        end,
      },
      integrations = {
        -- indent_blankline = {
        --   enabled = true,
        --   colored_indent_levels = false,
        --   scope_color = 'lavender',
        -- },
        cmp = true,
        gitsigns = true,
        mini = {
          enabled = true,
          indentscope_color = 'lavender',
        },
        treesitter = true,
        dap = {
          enabled = true,
          enable_ui = true, -- enable nvim-dap-ui
        },
        telescope = {
          enabled = true,
        },
        harpoon = true,
        neotree = true,
        which_key = true,
        -- blink_cmp = true,
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
