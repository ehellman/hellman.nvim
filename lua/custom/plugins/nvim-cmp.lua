-- See `:help cmp`

---@type LazySpec
return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    version = false, -- latest release is too old
    enabled = vim.g.cmp_variant == "cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- cmp source for nvim-lsp
      "hrsh7th/cmp-buffer", -- cmp source for buffer words
      "hrsh7th/cmp-path", -- cmp source for filesystem paths
      "hrsh7th/cmp-nvim-lsp-signature-help", -- display current function parameter emphasized
      -- Snippet Engine & its associated nvim-cmp source
      -- {
      --   "L3MON4D3/LuaSnip",
      --   build = (function()
      --     -- Build Step is needed for regex support in snippets.
      --     -- This step is not supported in many windows environments.
      --     -- Remove the below condition to re-enable on windows.
      --     if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
      --       return
      --     end
      --     return "make install_jsregexp"
      --   end)(),
      --   dependencies = {
      --     -- `friendly-snippets` contains a variety of premade snippets.
      --     --    See the README about individual language/framework/plugin snippets:
      --     --    https://github.com/rafamadriz/friendly-snippets
      --     {
      --       "rafamadriz/friendly-snippets",
      --       config = function()
      --         require("luasnip.loaders.from_vscode").lazy_load()
      --       end,
      --     },
      --   },
      -- },
      -- "saadparwaiz1/cmp_luasnip",

      -- Tailwind
      -- 'tailwind-tools',
      -- 'onsails/lspkind-nvim',
    },
    ----@param opts cmp.ConfigSchema
    opts_extend = { "sources" },
    opts = function(_, opts)
      -- set the ghost text color to the same as comments
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

      local cmp = require("cmp")
      -- local luasnip = require("luasnip").config.setup({})

      local defaults = require("cmp.config.default")()

      local auto_select = true

      --- @type cmp.ConfigSchema
      return vim.tbl_deep_extend("force", opts or {}, {
        auto_brackets = {}, -- TODO: needs main = util.cmp
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = HellVim.cmp.confirm({ select = auto_select }),
          ["<C-y>"] = HellVim.cmp.confirm({ select = true }),
          ["<S-CR>"] = HellVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<tab>"] = function(fallback)
            return HellVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
          end,
        }),
        sources = cmp.config.sources({
          { name = "lazydev" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "nvim_lsp_signature_help" }, -- TODO: does order matter?
        }, {
          { name = "buffer" },
        }),
        formatting = {
          ---@diagnostic disable-next-line: unused-local
          format = function(entry, item)
            local icons = HellVim.config.icons.kinds

            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end

            local widths = {
              -- TODO: add these to global config
              abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
              menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
            }

            for key, width in pairs(widths) do
              if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
              end
            end

            return item
          end,
        },
        experimental = {
          ghost_text = vim.g.ai_cmp and {
            hl_group = "CmpGhostText",
          } or false,
        },
        sorting = defaults.sorting,
      })
      -- cmp.setup(vim.tbl_deep_extend("force", opts or {}, {
      --   snippet = {
      --     -- expand = function(args)
      --     --   luasnip.lsp_expand(args.body)
      --     -- end,
      --   },
      --   completion = { completeopt = "menu,menuone,noinsert" },
      --
      --   window = {
      --     performance = {
      --       debounce = 500,
      --       throttle = 550,
      --       fetching_timeout = 80,
      --     },
      --     completion = {
      --       -- border = { '', '', '', '', '', '', '', '' },
      --       -- border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
      --       border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --       winhighlight = "Normal:CmpNormal,FloatBorder:CmpBorder,FloatTitle:CmpBorderTitle,CursorLine:CmpSelect",
      --       side_padding = 1,
      --       keyword_length = 3,
      --     },
      --     documentation = {
      --       border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --       winhighlight = "Normal:CmpDocNormal,FloatBorder:CmpDocBorder",
      --     },
      --   },
      --
      --   formatting = {
      --     fields = { "abbr", "menu", "kind" },
      --     expandable_indicator = true,
      --     max_width = 25,
      --     ellipsis_char = "...",
      --     format = require("lspkind").cmp_format({
      --       -- mode = 'symbol_text',
      --       -- mode = 'symbol',
      --       -- before = require('tailwind-tools.cmp').lspkind_format,
      --       -- menu = {
      --       --   buffer = '[ buf]',
      --       --   cmp_git = '[ git]',
      --       --   cody = '[cody]',
      --       --   nvim_lsp = '[ lsp]',
      --       --   nvim_lua = '[nvim]',
      --       --   path = '[path]',
      --       --   shell = '[ sh]',
      --       -- },
      --       --
      --     }),
      --   },
      --
      --   -- For an understanding of why these mappings were
      --   -- chosen, you will need to read `:help ins-completion`
      --   --
      --   -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --   mapping = cmp.mapping.preset.insert({
      --     -- Select the [n]ext item
      --     ["<C-n>"] = cmp.mapping.select_next_item(),
      --     -- Select the [p]revious item
      --     ["<C-p>"] = cmp.mapping.select_prev_item(),
      --
      --     -- Scroll the documentation window [b]ack / [f]orward
      --     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --     ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --
      --     -- Accept ([y]es) the completion.
      --     --  This will auto-import if your LSP supports it.
      --     --  This will expand snippets if the LSP sent a snippet.
      --     ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      --
      --     -- If you prefer more traditional completion keymaps,
      --     -- you can uncomment the following lines
      --     --['<CR>'] = cmp.mapping.confirm { select = true },
      --     --['<Tab>'] = cmp.mapping.select_next_item(),
      --     --['<S-Tab>'] = cmp.mapping.select_prev_item(),
      --
      --     -- Manually trigger a completion from nvim-cmp.
      --     --  Generally you don't need this, because nvim-cmp will display
      --     --  completions whenever it has completion options available.
      --     ["<C-Space>"] = cmp.mapping.complete({}),
      --
      --     -- Think of <c-l> as moving to the right of your snippet expansion.
      --     --  So if you have a snippet that's like:
      --     --  function $name($args)
      --     --    $body
      --     --  end
      --     --
      --     -- <c-l> will move you to the right of each of the expansion locations.
      --     -- <c-h> is similar, except moving you backwards.
      --     ["<C-l>"] = cmp.mapping(function()
      --       if luasnip.expand_or_locally_jumpable() then
      --         luasnip.expand_or_jump()
      --       end
      --     end, { "i", "s" }),
      --     ["<C-h>"] = cmp.mapping(function()
      --       if luasnip.locally_jumpable(-1) then
      --         luasnip.jump(-1)
      --       end
      --     end, { "i", "s" }),
      --
      --     -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --     --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      --   }),
      --   sources = {
      --     {
      --       name = "lazydev",
      --       -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
      --       group_index = 0,
      --     },
      --     { name = "nvim_lsp" },
      --     { name = "luasnip" },
      --     { name = "path" },
      --     { name = "nvim_lsp_signature_help" },
      --   },
      -- }))
    end,
    main = "custom.util.cmp",
  },

  -- snippets
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        opts = {
          friendly_snippets = true,
        },
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(item)
          return HellVim.cmp.expand(item.body)
        end,
      }
      -- if HellVim.has("nvim-snippets") then
      --   table.insert(opts.sources, { name = "snippets" })
      -- end
    end,
  },
}
