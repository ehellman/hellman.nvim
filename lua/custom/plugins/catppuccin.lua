---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = false,
  priority = 1000,
  init = function()
    -- set colorscheme
    -- vim.cmd.colorscheme('catppuccin')
    vim.cmd([[colorscheme catppuccin]])
  end,
  ---@module "catppuccin"
  ---@type CatppuccinOptions
  opts = {
    compile_path = vim.fn.stdpath("cache") .. "/nvim/catppuccin",
    flavour = "mocha",
    no_italic = true,
    term_colors = false,
    -- transparent_background = 'true',
    custom_highlights = function(colors)
      return {

        -- Snacks.dim
        SnacksDim = { fg = colors.surface2 },

        WinSeparator = { fg = colors.surface1, style = { "bold" } },

        FlashMatch = { fg = colors.lavender },
        FlashCurrent = { fg = colors.green },
        -- FlashBackdrop = { fg = colors.overlay0, bg = colors.base },
        FlashLabel = { fg = colors.crust, bg = colors.red },

        -- CursorLineNR = { fg = colors.mauve },
        -- CursorLine = { bg = colors.base },
        --
        -- LineNr = { fg = colors.surface2 },

        -- Harpoon Lualine
        HarpoonStatuslineActive = { fg = colors.lavender },
        HarpoonStatuslineInactive = { fg = colors.overlay0 },

        -- Blink
        BlinkCmpMenu = { bg = colors.base },
        -- BlinkCmpMenuBorder = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpMenuSelection = { fg = colors.lavender, bg = colors.base },
        BlinkCmpScrollBarThumb = { bg = colors.surface1 },
        BlinkCmpScrollBarGutter = { bg = colors.surface0 },
        -- BlinkCmpLabel = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpLabelDeprecated = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpLabelMatch = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpLabelDetail = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpLabelDescription = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpKind = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpSource = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpGhostText = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpDoc = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpDocBorder = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpDocSeparator = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpDocCursorLine = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpSignatureHelp = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpSignatureHelpBorder = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpSignatureHelpActiveParameter = { fg = colors.base, bg = colors.base },
        CmpNormal = { bg = colors.base },
        CmpBorder = { bg = colors.base, fg = colors.surface0 },
        CmpBorderTitle = { fg = colors.green, bg = colors.surface0, style = { "bold" } },
        CmpSelect = { bg = colors.surface1, fg = colors.text },

        CmpDocNormal = { bg = colors.base, fg = colors.subtext0 },
        CmpDocBorder = { bg = colors.base, fg = colors.surface0, style = { "bold" } },

        -- TODO: Run the command and keep replacing stuff
        -- Snacks.picker.highlights({pattern = "hl_group:^Snacks"})
        FloatBoarder = { fg = colors.red },

        -- Noice
        NoiceConfirmBorder = { fg = colors.lavender },
        NoiceCmdlinePopupBorder = { fg = colors.lavender },
        NoiceCmdlinePopupBorderSearch = { fg = colors.yellow },
        NoicePopupBorder = { fg = colors.lavender },
        NoicePopupmenuBorder = { fg = colors.lavender },

        -- WhichKey
        WhichKeyGroup = { fg = colors.lavender },
        WhichKeyBorder = { fg = colors.lavender },
        WhichKeyIconBlue = { fg = colors.blue },
        WhichKeyIconRed = { fg = colors.red },

        -- Snacks
        SnacksIndent = { fg = colors.surface0 },
        SnacksIndentScope = { fg = colors.lavender },

        SnacksInputIcon = { fg = colors.lavender },
        SnacksPickerCmd = { fg = colors.lavender },
        SnacksNotifierBorderInfo = { fg = colors.lavender },
        SnacksPickerBorder = { fg = colors.lavender },
        SnacksPickerBoxBorder = { fg = colors.lavender },
        SnacksPickerInputBorder = { fg = colors.lavender },
        SnacksPickerPreviewBorder = { fg = colors.lavender },
        SnacksWinBarNC = { fg = colors.lavender },
      }
    end,
    default_integrations = true,
    integrations = {
      bufferline = true,
      dashboard = true,
      cmp = vim.g.cmp_variant == "cmp",
      gitsigns = true,
      mini = {
        enabled = true,
        indentscope_color = "lavender",
      },
      treesitter = true,
      treesitter_context = true,
      neotest = true,
      illuminate = true,
      flash = true,
      dap_ui = true,
      dap = true,
      telescope = {
        enabled = not vim.g.enable_snacks_picker,
      },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      harpoon = true,
      neotree = true,
      which_key = true,
      blink_cmp = true,
      snacks = true,
      noice = true,
      notify = true,
    },
  },
}
