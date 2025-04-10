---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "cssls",
        "cssmodules_ls",
        "tailwindcss",
      },
    },
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    name = "tailwind-tools",
    lazy = true,
    -- event = "BufRead",
    build = ":UpdateRemotePlugins",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "css",
      "scss",
      "html",
    },
    -- enabled = function()
    --   -- disable on dashboard and prompt
    --   return not vim.tbl_contains({ 'snacks_dashboard' }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
    -- end,
    -- init = function()
    --   vim.api.nvim_create_autocmd('LspAttach', {
    --     callback = function(args)
    --       local client = vim.lsp.get_client_by_id(args.data.client_id)
    --       if client and client.name == 'tailwindcss' then
    --         require('tailwind-tools')
    --         return true
    --       end
    --     end,
    --   })
    -- end,
    ---@module "tailwind-tools"
    ---@type TailwindTools.Option
    opts = {
      server = {
        settings = {
          classAttributes = { "class", "class.*", ".*Class.*", ".*Class", ".*Style.*" },
          emmetCompletions = true,
          experimental = {
            classRegex = {
              { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              "(?:enter|leave)(?:From|To)?=\\s*(?:\"|')([^(?:\"|')]*)",
              { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            },
          },
          lint = {
            cssConflict = "error",
          },
        },
      },
      extension = {
        patterns = {
          -- { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          -- "(?:enter|leave)(?:From|To)?=\\s*(?:\"|')([^(?:\"|')]*)",
          -- { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          -- { "cx\\(((?:[^()]|\\([^()]*\\))*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          -- typescriptreact = { "clsx%(([^)]+)%)" },
          -- typescriptreact = { "cn%(([^)]+)%)", "clsx%(([^)]+)%)", 'cva%({["^"]}%)', "tw%(([^)]+)%)", "tw%`([^`]+)%`" },
          -- typescript = { "clsx%(([^)]+)%)", 'tv%({["^"]}%)', 'cva%({["^"]}%)' },
          -- tsx = { "clsx%(([^)]+)%)", 'tv%({["^"]}%)', 'cva%({["^"]}%)' },
        },
      },
      cmp = {
        highlight = "foreground", -- color preview style, "foreground" | "background"
      },
    },
    config = function(_, opts)
      require("tailwind-tools").setup(opts)
    end,
    keys = {
      { "<leader>ctc", "<cmd>TailwindConcealToggle<CR>", desc = "Toggle tailwind conceal" },
      { "<leader>cts", "<cmd>TailwindSort<CR>", desc = "Sort tailwind classes" },
      { "<leader>ctp", "<cmd>TailwindPrevClass<CR>", desc = "Move to the next class" },
      { "<leader>ctn", "<cmd>TailwindNextClass<CR>", desc = "Move to the previous class" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          filetypes_include = {},
          filetypes_exclude = { "markdown" },
        },
      },
    },
    setup = {
      tailwindcss = function(_, opts)
        local tw = require("lspconfig.configs.tailwindcss")

        -- Add default filetypes
        vim.list_extend(opts.filetypes, tw.default_config.filetypes)

        -- Remove excluded filetypes
        --- @param ft string
        opts.filetypes = vim.tbl_filter(function(ft)
          return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
        end, opts.filetypes)
      end,
    },
  },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      -- 'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-path',
      -- 'hrsh7th/cmp-nvim-lsp-signature-help',
      "tailwind-tools",
      "onsails/lspkind-nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      ---@diagnostic disable: missing-fields
      opts.formatting = {
        format = require("lspkind").cmp_format({
          before = require("tailwind-tools.cmp").lspkind_format,
        }),
      }
      ---@diagnostic enable: missing-fields
      return opts
    end,
  },
}
