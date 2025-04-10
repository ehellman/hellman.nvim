---@type LazySpec
return {
  ---@module 'noice'
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    -- "rcarriga/nvim-notify",
  },
  opts = {
    -- cmdline = {
    --   -- enabled = true, -- enables the Noice cmdline UI
    --   view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    --   opts = {
    --     enter = true, -- automatically enter the cmdline when it opens
    --     format = "details", -- format for the cmdline. See section on formatting
    --     -- border = 'rounded', -- border style for the cmdline
    --     -- borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }, -- border characters for the cmdline
    --     -- win_options = { winblend = 10, winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder' },
    --   }, -- global options for the cmdline. See section on views
    --   ---@type table<string, CmdlineFormat>
    --   format = {
    --     -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
    --     -- view: (default is cmdline view)
    --     -- opts: any options passed to the view
    --     -- icon_hl_group: optional hl_group for the icon
    --     -- title: set to anything or empty string to hide
    --     -- cmdline = { pattern = '^:', icon = ' : ', lang = 'vim' },
    --     -- search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
    --     -- search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
    --     -- filter = { pattern = '^:%s*!', icon = '$', lang = 'bash' },
    --     -- lua = { pattern = { '^:%s*lua%s+', '^:%s*lua%s*=%s*', '^:%s*=%s*' }, icon = '', lang = 'lua' },
    --     -- help = { pattern = '^:%s*he?l?p?%s+', icon = '' },
    --     -- input = { view = 'cmdline_input', icon = '󰥻 ' }, -- Used by input()
    --     -- lua = false, -- to disable a format, set to `false`
    --   },
    -- },
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    views = {
      -- https://github.com/folke/noice.nvim/blob/main/lua/noice/config/views.lua#L121
      hover = {
        size = {
          max_width = math.floor(vim.o.columns * 0.4),
          max_height = math.floor(vim.o.lines * 0.5),
        },
      },
    },
    throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
    ------@type NoiceConfigViews
    ---views = {}, ---@see section on views
    ---@type NoiceRouteConfig[]
    routes = {
      -- {
      --   view = "notify",
      --   filter = { event = "msg_showmode" },
      -- },
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    }, --- @see section on routes

    lsp = {
      hover = {
        enabled = true,
        silent = true,
        ---@type NoiceViewOptions
        opts = {
          size = {
            max_width = math.floor(vim.o.columns * 0.4),
            max_height = math.floor(vim.o.lines * 0.5),
          },
        },
      },
      signature = {
        enabled = true,
        ---@type NoiceViewOptions
        opts = {}, -- merged with defaults from documentation
      },
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
  },
  keys = {
    { "<leader>sn", "", desc = "+noice" },
    {
      "<S-Enter>",
      function()
        require("noice").redirect(vim.fn.getcmdline())
      end,
      mode = "c",
      desc = "Redirect Cmdline",
    },
    {
      "<leader>snl",
      function()
        require("noice").cmd("last")
      end,
      desc = "Noice Last Message",
    },
    {
      "<leader>snh",
      function()
        require("noice").cmd("history")
      end,
      desc = "Noice History",
    },
    {
      "<leader>sna",
      function()
        require("noice").cmd("all")
      end,
      desc = "Noice All",
    },
    {
      "<leader>snd",
      function()
        require("noice").cmd("dismiss")
      end,
      desc = "Dismiss All",
    },
    {
      "<leader>snt",
      function()
        require("noice").cmd("pick")
      end,
      desc = "Noice Picker (Telescope/FzfLua)",
    },
    {
      "<c-f>",
      function()
        if not require("noice.lsp").scroll(4) then
          return "<c-f>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Forward",
      mode = { "i", "n", "s" },
    },
    {
      "<c-b>",
      function()
        if not require("noice.lsp").scroll(-4) then
          return "<c-b>"
        end
      end,
      silent = true,
      expr = true,
      desc = "Scroll Backward",
      mode = { "i", "n", "s" },
    },
  },
  config = function(_, opts)
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd([[messages clear]])
    end

    require("noice").setup(opts)
  end,
}
