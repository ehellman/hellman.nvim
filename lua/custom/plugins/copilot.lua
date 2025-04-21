---@type LazySpec
return {
  -- { "github/copilot.vim", event = "VeryLazy" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      suggestion = {
        enabled = not vim.g.ai_cmp,
        auto_trigger = true,
        hide_during_completion = vim.g.ai_cmp,
        keymap = {
          accept = false, -- handled by nvim-cmp / blink.cmp
          accept_word = "<C-l>",
          next = "<M-]>",
          prev = "<M-[>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  -- add ai_accept action
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      HellVim.cmp.actions.ai_accept = function()
        if require("copilot.suggestion").is_visible() then
          HellVim.create_undo()
          require("copilot.suggestion").accept()
          return true
        end
      end
    end,
  },
  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_x = {
          "copilot",
          HellVim.lualine.status(HellVim.config.icons.kinds.Copilot, function()
            local clients = package.loaded["copilot"] and HellVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
            if #clients > 0 then
              local status = require("copilot.status").data.status
              return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
            end
          end),
        },
      },
    },
    -- opts = function(_, opts)
    --   table.insert(
    --     opts.sections.lualine_x,
    --     2,
    --     HellVim.lualine.status(HellVim.config.icons.kinds.Copilot, function()
    --       local clients = package.loaded["copilot"] and HellVim.lsp.get_clients({ name = "copilot", bufnr = 0 }) or {}
    --       if #clients > 0 then
    --         local status = require("copilot.api").status.data.status
    --         return (status == "InProgress" and "pending") or (status == "Warning" and "error") or "ok"
    --       end
    --     end)
    --   )
    -- end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      icons = {
        rules = {
          { plugin = "copilot.lua", icon = " ", color = "orange" },
        },
      },
    },
  },
  vim.g.ai_cmp
      and {
        -- copilot cmp source
        {
          "hrsh7th/nvim-cmp",
          optional = true,
          dependencies = { -- this will only be evaluated if nvim-cmp is enabled
            {
              "zbirenbaum/copilot-cmp",
              opts = {},
              config = function(_, opts)
                local copilot_cmp = require("copilot_cmp")
                copilot_cmp.setup(opts)
                -- attach cmp source whenever copilot attaches
                -- fixes lazy-loading issues with the copilot cmp source
                HellVim.lsp.on_attach(function()
                  copilot_cmp._on_insert_enter({})
                end, "copilot")
              end,
              specs = {
                {
                  "hrsh7th/nvim-cmp",
                  ---@param opts cmp.ConfigSchema
                  opts = function(_, opts)
                    if opts.sources ~= nil then
                      table.insert(opts.sources, 1, {
                        name = "copilot",
                        group_index = 1,
                        priority = 100,
                      })
                    end
                  end,
                },
              },
            },
          },
        },
        {
          "saghen/blink.cmp",
          optional = true,
          dependencies = { "giuxtaposition/blink-cmp-copilot" },
          opts = {
            sources = {
              default = { "copilot" },
              providers = {
                copilot = {
                  name = "copilot",
                  module = "blink-cmp-copilot",
                  kind = "Copilot",
                  score_offset = 100,
                  async = true,
                },
              },
            },
          },
        },
      }
    or nil,
}
