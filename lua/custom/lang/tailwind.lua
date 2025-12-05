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
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          settings = {
            tailwindCSS = {
              classAttributes = { "class", "class.*", ".*Class.*", ".*Class", ".*Style.*" },
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
        },
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
    ---@module "tailwind-tools"
    ---@type TailwindTools.Option
    opts = {
      server = {
        override = false, -- Don't use lspconfig (deprecated), configure LSP separately
        settings = {
          classAttributes = { "class", "class.*", ".*Class.*", ".*Class", ".*Style.*" },
          classFunctions = {
            "clsx",
            "classnames",
            "cva",
            "cx",
            "cn",
            "twMerge",
            "twJoin",
          },
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
        -- a list of filetypes having custom `class` queries
        queries = {},
        -- a map of filetypes to Lua pattern lists
        patterns = {
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
