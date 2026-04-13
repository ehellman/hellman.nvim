---@type LazyPluginSpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  version = false,
  enabled = true,
  lazy = false,
  priority = 1000,
  ---@module "catppuccin"
  ---@type CatppuccinOptions
  opts = {
    flavour = "mocha",
    no_italic = true,
    term_colors = false,
    color_overrides = {
      mocha = {
        -- Background scale (dark to light)
        base = "#000000",
        mantle = "#0a0a0a",
        crust = "#050505",
        surface0 = "#171717",
        surface1 = "#222222",
        surface2 = "#333333",

        -- Foreground scale (bright to dim)
        text = "#ffffff",
        subtext1 = "#ededed",
        subtext0 = "#a1a1a1",
        overlay2 = "#888888",
        overlay1 = "#666666",
        overlay0 = "#444444",

        -- Syntax colors (GitHub Dark approach: high sat + high lightness for black bg)
        lavender = "#ffffff", -- variables, UI borders
        mauve = "#d2a8ff", -- keywords: bright purple (GitHub Dark)
        pink = "#d2a8ff", -- keyword.function: match mauve (unified keyword color)
        blue = "#79c0ff", -- functions: sky blue (GitHub Dark)
        sapphire = "#56b3ff", -- constructors: deeper blue
        sky = "#7dcfff", -- operators: light cyan
        teal = "#7ee8d4", -- type builtins: bright seafoam
        green = "#7ee787", -- strings: bright green (GitHub Dark)
        yellow = "#ffd580", -- types: warm gold
        peach = "#ffa657", -- numbers: orange (GitHub Dark)
        rosewater = "#ffcb8b", -- markup: warm tan
        flamingo = "#ffa198", -- brackets: soft coral
        red = "#ff7b72", -- errors: salmon (GitHub Dark)
        maroon = "#f47067", -- error accents (GitHub Dark)
      },
    },
    custom_highlights = function(colors)
      return {

        -- Inlay hints / git blame (brighter so they don't disappear on black)
        LspInlayHint = { fg = colors.overlay1, bg = colors.surface0 },
        GitSignsCurrentLineBlame = { fg = colors.overlay1 },

        -- Export keyword should match other keywords
        ["@keyword.export"] = { link = "@keyword" },

        -- Snacks.dim
        SnacksDim = { fg = colors.surface2 },

        WinSeparator = { fg = colors.surface1, style = { "bold" } },

        FlashMatch = { fg = colors.lavender },
        FlashCurrent = { fg = colors.green },
        -- FlashBackdrop = { fg = colors.overlay0, bg = colors.base },
        FlashLabel = { fg = colors.crust, bg = colors.red },

        LineNr = { fg = colors.overlay0 },
        CursorLineNr = { fg = colors.subtext0, bold = true },

        -- Harpoon Lualine
        HarpoonStatuslineActive = { fg = colors.lavender },
        HarpoonStatuslineInactive = { fg = colors.overlay0 },
        -- Blink
        -- BlinkCmpMenu = { bg = colors.base },
        -- BlinkCmpMenuBorder = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpMenuSelection = { fg = colors.lavender, bg = colors.base },
        -- BlinkCmpScrollBarThumb = { bg = colors.surface1 },
        -- BlinkCmpScrollBarGutter = { bg = colors.surface0 },
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
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin-nvim")
  end,
}
