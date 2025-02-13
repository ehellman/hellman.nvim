return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      -- add blink.compat to dependencies
      -- {
      --   'saghen/blink.compat',
      --   optional = true, -- make optional so it's only enabled if any extras need it
      --   opts = {},
      --   version = not vim.g.lazyvim_blink_main and '*',
      -- },
      'onsails/lspkind.nvim',
    },
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      completion = {
        accept = { auto_brackets = { enabled = false } },
        documentation = {
          window = {
            -- border = 'padded',
          },
          treesitter_highlighting = true,
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = false },
        -- preselect first line
        list = { selection = { preselect = true, auto_insert = true } },
        menu = {
          auto_show = true,
          -- border = 'padded',
          draw = {
            treesitter = { 'lsp' },
            -- https://cmp.saghen.dev/configuration/completion.html#available-components
            columns = {
              { 'kind_icon', gap = 1 },
              { 'label', gap = 1, 'kind' },
            },
          },
        },
      },
      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
        kind_icons = {
          Copilot = '',
          Text = '󰉿',
          Method = '󰊕',
          Function = '󰊕',
          Constructor = '󰒓',

          Field = '󰜢',
          Variable = '󰆦',
          Property = '󰖷',

          Class = '󱡠',
          Interface = '󱡠',
          Struct = '󱡠',
          Module = '󰅩',

          Unit = '󰪚',
          Value = '󰦨',
          Enum = '󰦨',
          EnumMember = '󰦨',

          Keyword = '󰻾',
          Constant = '󰏿',

          Snippet = '󱄽',
          Color = '󱓻', -- '󰏘',
          File = '󰈔',
          Reference = '󰬲',
          Folder = '󰉋',
          Event = '󱐋',
          Operator = '󰪚',
          TypeParameter = '󰬛',
        },
      },
      keymap = {
        preset = 'default',
      },
      -- Use a preset for snippets, check the snippets documentation for more information
      -- 'default' | 'luasnip' | 'mini_snippets'
      snippets = { preset = 'default' },
      -- Experimental signature help support
      signature = { enabled = true },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
    },
    opts_extend = {
      'sources.completion.enabled_providers',
      'sources.default',
    },
  },
  -- {
  --   'saghen/blink.cmp',
  --   version = not vim.g.lazyvim_blink_main and '*',
  --   build = vim.g.lazyvim_blink_main and 'cargo build --release',
  --   optional = true,
  --   enabled = vim.g.cmp_variant == 'blink',
  --   opts_extend = {
  --     'sources.completion.enabled_providers',
  --     'sources.compat',
  --     'sources.default',
  --   },
  --   dependencies = {
  --     'rafamadriz/friendly-snippets',
  --     -- add blink.compat to dependencies
  --     {
  --       'saghen/blink.compat',
  --       optional = true, -- make optional so it's only enabled if any extras need it
  --       opts = {},
  --       version = not vim.g.lazyvim_blink_main and '*',
  --     },
  --   },
  --   event = 'InsertEnter',
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     -- snippets = {
  --     -- expand = function(snippet, _)
  --     --   return LazyVim.cmp.expand(snippet)
  --     -- end,
  --     -- },
  --     appearance = {
  --       -- sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- useful for when your theme doesn't support blink.cmp
  --       -- will be removed in a future release, assuming themes add support
  --       use_nvim_cmp_as_default = false,
  --       -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = 'mono',
  --     },
  --     completion = {
  --       accept = {
  --         -- experimental auto-brackets support
  --         auto_brackets = {
  --           enabled = true,
  --         },
  --       },
  --       menu = {
  --         draw = {
  --           treesitter = { 'lsp' },
  --         },
  --       },
  --       documentation = {
  --         auto_show = true,
  --         auto_show_delay_ms = 200,
  --       },
  --       ghost_text = {
  --         enabled = vim.g.ai_cmp,
  --       },
  --     },
  --
  --     -- experimental signature help support
  --     -- signature = { enabled = true },
  --
  --     sources = {
  --       -- adding any nvim-cmp sources here will enable them
  --       -- with blink.compat
  --       compat = {},
  --       default = { 'lsp', 'path', 'snippets', 'buffer' },
  --       cmdline = {},
  --     },
  --
  --     keymap = {
  --       preset = 'default',
  --       -- ['<C-y>'] = { 'select_and_accept' },
  --       -- ["<C-c>"] = { "cancel" },
  --       ['<C-y>'] = { 'select_and_accept', 'fallback' },
  --       -- ['<C-y>'] = { 'accept', 'fallback' },
  --       ['<Tab>'] = { 'select_next', 'fallback' },
  --       ['<S-Tab>'] = { 'select_prev', 'fallback' },
  --       -- ["<Down>"] = { "select_next", "fallback" },
  --       -- ["<Up>"] = { "select_prev", "fallback" },
  --       -- ["<PageDown>"] = { "scroll_documentation_down" },
  --       -- ["<PageUp>"] = { "scroll_documentation_up" },
  --     },
  --   },
  --   ---@param opts blink.cmp.Config | { sources: { compat: string[] } }
  --   config = function(_, opts)
  --     -- setup compat sources
  --     local enabled = opts.sources.default
  --     for _, source in ipairs(opts.sources.compat or {}) do
  --       opts.sources.providers[source] = vim.tbl_deep_extend('force', { name = source, module = 'blink.compat.source' }, opts.sources.providers[source] or {})
  --       if type(enabled) == 'table' and not vim.tbl_contains(enabled, source) then
  --         table.insert(enabled, source)
  --       end
  --     end
  --
  --     -- add ai_accept to <Tab> key
  --     -- if not opts.keymap['<Tab>'] then
  --     --   if opts.keymap.preset == 'super-tab' then -- super-tab
  --     --     opts.keymap['<Tab>'] = {
  --     --       require('blink.cmp.keymap.presets')['super-tab']['<Tab>'][1],
  --     --       -- LazyVim.cmp.map({ 'snippet_forward', 'ai_accept' }),
  --     --       'fallback',
  --     --     }
  --     --   else -- other presets
  --     --     opts.keymap['<Tab>'] = {
  --     --       -- LazyVim.cmp.map({ 'snippet_forward', 'ai_accept' }),
  --     --       'fallback',
  --     --     }
  --     --   end
  --     -- end
  --
  --     -- Unset custom prop to pass blink.cmp validation
  --     opts.sources.compat = nil
  --
  --     -- check if we need to override symbol kinds
  --     for _, provider in pairs(opts.sources.providers or {}) do
  --       ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
  --       if provider.kind then
  --         local CompletionItemKind = require('blink.cmp.types').CompletionItemKind
  --         local kind_idx = #CompletionItemKind + 1
  --
  --         CompletionItemKind[kind_idx] = provider.kind
  --         ---@diagnostic disable-next-line: no-unknown
  --         CompletionItemKind[provider.kind] = kind_idx
  --
  --         ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
  --         local transform_items = provider.transform_items
  --         ---@param ctx blink.cmp.Context
  --         ---@param items blink.cmp.CompletionItem[]
  --         provider.transform_items = function(ctx, items)
  --           items = transform_items and transform_items(ctx, items) or items
  --           for _, item in ipairs(items) do
  --             item.kind = kind_idx or item.kind
  --           end
  --           return items
  --         end
  --         -- Unset custom prop to pass blink.cmp validation
  --         provider.kind = nil
  --       end
  --     end
  --
  --     require('blink.cmp').setup(opts)
  --   end,
  -- },
  --
  -- lazydev
  {
    'saghen/blink.cmp',
    opts = {
      sources = {
        -- add lazydev to your completion providers
        default = { 'lazydev' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
