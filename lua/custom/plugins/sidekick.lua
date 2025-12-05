---@module 'lazy'
---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = {},
      },
    },
  },
  -- {
  --   "nvim-lualine/lualine.nvim",
  --   optional = true,
  --   event = "VeryLazy",
  --   opts = function(_, opts)
  --     local icons = {
  --       Error = { " ", "DiagnosticError" },
  --       Inactive = { " ", "MsgArea" },
  --       Warning = { " ", "DiagnosticWarn" },
  --       Normal = { HellVim.config.icons.kinds.Copilot, "Special" },
  --     }
  --     table.insert(opts.sections.lualine_x, 2, {
  --       function()
  --         local status = require("sidekick.status").get()
  --         return status and vim.tbl_get(icons, status.kind, 1)
  --       end,
  --       cond = function()
  --         return require("sidekick.status").get() ~= nil
  --       end,
  --       color = function()
  --         local status = require("sidekick.status").get()
  --         local hl = status and (status.busy and "DiagnosticWarn" or vim.tbl_get(icons, status.kind, 2))
  --         return { fg = Snacks.util.color(hl) }
  --       end,
  --     })
  --   end,
  -- },
  {
    "saghen/blink.cmp",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {

      keymap = {
        ["<Tab>"] = {
          "snippet_forward",
          function() -- sidekick next edit suggestion
            return require("sidekick").nes_jump_or_apply()
          end,
          function() -- if you are using Neovim's native inline completions
            return vim.lsp.inline_completion.get()
          end,
          "fallback",
        },
      },
    },
  },
  {
    "folke/sidekick.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
      cli = {
        mux = {
          -- backend = "tmux",
          enabled = true,
        },
      },
    },
  -- stylua: ignore
  keys = {
    {
      "<tab>",
      function()
        -- if there is a next edit, jump to it, otherwise apply it if any
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>" -- fallback to normal tab
        end
      end,
      expr = true,
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<leader>aa",
      function() require("sidekick.cli").toggle() end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function() require("sidekick.cli").select() end,
      -- Or to select only installed tools:
      -- require("sidekick.cli").select({ filter = { installed = true } })
      desc = "Select CLI",
    },
    {
      "<leader>at",
      function() require("sidekick.cli").send({ msg = "{this}" }) end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>av",
      function() require("sidekick.cli").send({ msg = "{selection}" }) end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function() require("sidekick.cli").prompt() end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    {
      "<c-.>",
      function() require("sidekick.cli").focus() end,
      mode = { "n", "x", "i", "t" },
      desc = "Sidekick Switch Focus",
    },
    -- Example of a keybinding to open Claude directly
    {
      "<leader>ac",
      function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end,
      desc = "Sidekick Toggle Claude",
    },
  },
  },
}
