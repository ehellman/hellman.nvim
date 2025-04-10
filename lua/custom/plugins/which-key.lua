return {
  { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    lazy = true,
    event = "VimEnter", -- Sets the loading event to 'VimEnter'
    opts_extend = { "spec", "icons" },
    ---@module 'which-key'
    ---@type wk.Opts
    opts = {
      -- classic | modern | helix
      preset = "helix",
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = "<Up> ",
          Down = "<Down> ",
          Left = "<Left> ",
          Right = "<Right> ",
          C = "<C-…> ",
          M = "<M-…> ",
          D = "<D-…> ",
          S = "<S-…> ",
          CR = "<CR> ",
          Esc = "<Esc> ",
          ScrollWheelDown = "<ScrollWheelDown> ",
          ScrollWheelUp = "<ScrollWheelUp> ",
          NL = "<NL> ",
          BS = "<BS> ",
          Space = "<Space> ",
          Tab = "<Tab> ",
          F1 = "<F1>",
          F2 = "<F2>",
          F3 = "<F3>",
          F4 = "<F4>",
          F5 = "<F5>",
          F6 = "<F6>",
          F7 = "<F7>",
          F8 = "<F8>",
          F9 = "<F9>",
          F10 = "<F10>",
          F11 = "<F11>",
          F12 = "<F12>",
        },

        ---@type wk.IconRule[]
        rules = {
          -- ignore [] and match against harpoon*
          -- { plugin = "ThePrimeagen/harpoon", pattern = "%f[%w]h?arpoon[a-z]*%f[%W]", icon = "󰀱", color = "orange" },
          -- ignore [] and match against git
          { pattern = "%f[%w]git%f[%W]", icon = "", color = "red" },
          {
            -- plugin = "otavioschwanck/arrow.nvim",
            pattern = "%f[%w]h?arpoon[a-z]*%f[%W]",
            icon = "",
            color = "orange",
          },
        },
      },

      -- Document existing key chains
      spec = {
        { "<leader>c", group = "[c]ode", mode = { "n", "x" } },
        { "<leader>ct", group = "[t]ailwind" },
        { "<leader>d", group = "[d]ocument" },
        { "<leader>s", group = "[s]earch" },
        { "<leader>g", group = "[g]it" },
        { "gz", group = "[z]urround", mode = { "n", "v" } },
        { "<leader>p", group = "[p]lugins" },
        { "<leader>u", group = "[u]i" },
        { "<leader>w", group = "[w]rite" },
        { "<leader>W", group = "[W]indow" },
        { "<leader>H", group = "Git [H]unk", mode = { "n", "v" } },
        {
          "<leader>b",
          group = "[b]uffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Keymaps (which-key)",
      },
    },
  },
}
