---@type LazySpec
return {
  {
    ---@module 'blink.cmp'
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
      "copilotlsp-nvim/copilot-lsp",
      -- add blink.compat to dependencies
      {
        "saghen/blink.compat",
        optional = true, -- make optional so it's only enabled if any extras need it
        opts = {},
        version = "*",
      },
      "onsails/lspkind.nvim",
    },
    version = "*",
    -- build = vim.g.lazyvim_blink_main and "cargo build --release",
    optional = true,
    enabled = vim.g.cmp_variant == "blink",
    event = "InsertEnter",
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
      "sources.default",
    },
    ---@type blink.cmp.Config
    opts = {
      completion = {
        accept = {
          auto_brackets = {
            -- enabled = false,
            enabled = true,
          },
        },
        documentation = {
          window = {
            -- border = 'padded',
          },
          treesitter_highlighting = true,
          auto_show = true,
          auto_show_delay_ms = 200,
          -- auto_show_delay_ms = 500,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
          -- enabled = false,
        },
        -- preselect first line
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          auto_show = true,
          -- border = 'padded',
          draw = {
            treesitter = { "lsp" },
            -- https://cmp.saghen.dev/configuration/completion.html#available-components
            columns = {
              { "kind_icon", gap = 1 },
              { "label", gap = 1, "kind" },
            },
          },
        },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
        kind_icons = {
          Copilot = "",
          Text = "󰉿",
          Method = "󰊕",
          Function = "󰊕",
          Constructor = "󰒓",

          Field = "󰜢",
          Variable = "󰆦",
          Property = "󰖷",

          Class = "󱡠",
          Interface = "󱡠",
          Struct = "󱡠",
          Module = "󰅩",

          Unit = "󰪚",
          Value = "󰦨",
          Enum = "󰦨",
          EnumMember = "󰦨",

          Keyword = "󰻾",
          Constant = "󰏿",

          Snippet = "󱄽",
          Color = "󱓻", -- '󰏘',
          File = "󰈔",
          Reference = "󰬲",
          Folder = "󰉋",
          Event = "󱐋",
          Operator = "󰪚",
          TypeParameter = "󰬛",
        },
      },
      cmdline = {
        enabled = false,
      },
      keymap = {
        preset = "default",
        -- preset = "enter",
        -- ["<C-y>"] = { "select_and_accept" },
      },
      -- Use a preset for snippets, check the snippets documentation for more information
      -- 'default' | 'luasnip' | 'mini_snippets'
      snippets = {
        preset = "default",
        expand = function(snippet, _)
          return HellVim.cmp.expand(snippet)
        end,
      },
      -- Experimental signature help support
      signature = { enabled = true },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
    ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
    config = function(_, opts)
      -- setup compat sources
      local enabled = opts.sources.default
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- add ai_accept to <Tab> key
      if not opts.keymap["<Tab>"] then
        if opts.keymap.preset == "super-tab" then -- super-tab
          opts.keymap["<Tab>"] = {
            require("blink.cmp.keymap.presets")["super-tab"]["<Tab>"][1],
            HellVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        else -- other presets
          opts.keymap["<Tab>"] = {
            HellVim.cmp.map({ "snippet_forward", "ai_accept" }),
            "fallback",
          }
        end
      end

      -- Unset custom prop to pass blink.cmp validation
      opts.sources.compat = nil

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
          local kind_idx = #CompletionItemKind + 1

          CompletionItemKind[kind_idx] = provider.kind
          ---@diagnostic disable-next-line: no-unknown
          CompletionItemKind[provider.kind] = kind_idx

          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx or item.kind
              item.kind_icon = HellVim.config.icons.kinds[item.kind_name] or item.kind_icon or nil
            end
            return items
          end

          -- Unset custom prop to pass blink.cmp validation
          provider.kind = nil
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },
  -- lazydev
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { "lazydev" },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
