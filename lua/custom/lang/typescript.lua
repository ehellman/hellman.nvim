---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- "ts_ls",
        "vtsls",
        "prettier",
        "prettierd",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "javascript", "jsdoc", "typescript" } },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = { "javascriptreact", "typescriptreact" },
    opts = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = true,
        expose_as_code_action = "all",
        tsserver_max_memory = "auto",
        tsserver_file_preferences = {
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
      },
    },
    config = function(_, opts)
      require("typescript-tools").setup(vim.tbl_deep_extend("force", opts, {
        on_attach = function(client, bufnr)
          -- HellVim.lsp.on_attach(client, bufnr)
          require("custom.plugins.lsp.keymaps").on_attach(client, bufnr)
          -- add custom commands
          -- client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
          --   require("typescript-tools").refactor.move_to_file(command, ctx)
          -- end
        end,
      }))
    end,
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   optional = true,
  --   opts = {
  --     servers = {
  --       ---@type vim.lsp.ClientConfig
  --       ts_ls = {
  --         enabled = false,
  --         settings = {
  --           typescript = {
  --             inlayHints = {
  --               includeInlayEnumMemberValueHints = true,
  --               includeInlayFunctionLikeReturnTypeHints = true,
  --               includeInlayFunctionParameterTypeHints = true,
  --               includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
  --               includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --               includeInlayPropertyDeclarationTypeHints = true,
  --               includeInlayVariableTypeHints = false,
  --             },
  --           },
  --         },
  --       },
  --       ---@type vim.lsp.ClientConfig
  --       vtsls = {
  --         enabled = true,
  --         -- explicitly add default filetypes, so that we can extend
  --         -- them in related extras
  --         filetypes = {
  --           "javascript",
  --           "javascriptreact",
  --           "javascript.jsx",
  --           "typescript",
  --           "typescriptreact",
  --           "typescript.tsx",
  --         },
  --         settings = {
  --           complete_function_calls = true,
  --           vtsls = {
  --             enableMoveToFileCodeAction = true,
  --             autoUseWorkspaceTsdk = true,
  --             experimental = {
  --               maxInlayHintLength = 30,
  --               completion = {
  --                 enableServerSideFuzzyMatch = true,
  --               },
  --             },
  --           },
  --           typescript = {
  --             updateImportsOnFileMove = { enabled = "always" },
  --             suggest = {
  --               completeFunctionCalls = true,
  --             },
  --             inlayHints = {
  --               enumMemberValues = { enabled = true },
  --               functionLikeReturnTypes = { enabled = true },
  --               parameterNames = { enabled = "literals" },
  --               parameterTypes = { enabled = true },
  --               propertyDeclarationTypes = { enabled = true },
  --               variableTypes = { enabled = false },
  --             },
  --           },
  --         },
  --         keys = {
  --           {
  --             "gD",
  --             function()
  --               local params = vim.lsp.util.make_position_params()
  --               HellVim.lsp.execute({
  --                 command = "typescript.goToSourceDefinition",
  --                 arguments = { params.textDocument.uri, params.position },
  --                 open = true,
  --               })
  --             end,
  --             desc = "goto source [D]efinition",
  --           },
  --           {
  --             "gR",
  --             function()
  --               HellVim.lsp.execute({
  --                 command = "typescript.findAllFileReferences",
  --                 arguments = { vim.uri_from_bufnr(0) },
  --                 open = true,
  --               })
  --             end,
  --             desc = "file [R]eferences",
  --           },
  --           {
  --             "<leader>co",
  --             HellVim.lsp.action["source.organizeImports"],
  --             desc = "[o]rganize imports",
  --           },
  --           {
  --             "<leader>cM",
  --             HellVim.lsp.action["source.addMissingImports.ts"],
  --             desc = "add [M]issing imports",
  --           },
  --           {
  --             "<leader>cu",
  --             HellVim.lsp.action["source.removeUnused.ts"],
  --             desc = "remove [u]nused imports",
  --           },
  --           {
  --             "<leader>cx",
  --             HellVim.lsp.action["source.fixAll.ts"],
  --             desc = "fi[x] all diagnostics",
  --           },
  --           {
  --             "<leader>cV",
  --             function()
  --               HellVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
  --             end,
  --             desc = "select TS [V]ersion",
  --           },
  --         },
  --       },
  --     },
  --     setup = {
  --       ts_ls = function()
  --         -- disable tsserver
  --         return true
  --       end,
  --       vtsls = function(_, opts)
  --         HellVim.lsp.on_attach(function(client, buffer)
  --           client.commands["_typescript.moveToFileRefactoring"] = function(command, ctx)
  --             ---@type string, string, lsp.Range
  --             local action, uri, range = unpack(command.arguments)
  --
  --             local function move(newf)
  --               client.request(client, "workspace/executeCommand", {
  --                 command = command.command,
  --                 arguments = { action, uri, range, newf },
  --               })
  --             end
  --
  --             local fname = vim.uri_to_fname(uri)
  --             client.request(client, "workspace/executeCommand", {
  --               command = "typescript.tsserverRequest",
  --               arguments = {
  --                 "getMoveToRefactoringFileSuggestions",
  --                 {
  --                   file = fname,
  --                   startLine = range.start.line + 1,
  --                   startOffset = range.start.character + 1,
  --                   endLine = range["end"].line + 1,
  --                   endOffset = range["end"].character + 1,
  --                 },
  --               },
  --             }, function(_, result)
  --               ---@type string[]
  --               local files = result.body.files
  --               table.insert(files, 1, "Enter new path...")
  --               vim.ui.select(files, {
  --                 prompt = "Select move destination:",
  --                 format_item = function(f)
  --                   return vim.fn.fnamemodify(f, ":~:.")
  --                 end,
  --               }, function(f)
  --                 if f and f:find("^Enter new path") then
  --                   vim.ui.input({
  --                     prompt = "Enter move destination:",
  --                     default = vim.fn.fnamemodify(fname, ":h") .. "/",
  --                     completion = "file",
  --                   }, function(newf)
  --                     return newf and move(newf)
  --                   end)
  --                 elseif f then
  --                   move(f)
  --                 end
  --               end)
  --             end)
  --           end
  --         end, "vtsls")
  --         -- copy typescript settings to javascript
  --         opts.settings.javascript =
  --           vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
  --       end,
  --     },
  --   },
  -- },
  {
    "stevearc/conform.nvim",
    ---@module "conform"
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        typescriptreact = { "prettierd" },
        javascriptreact = { "prettierd" },
        vue = { "prettierd" },
      },
    },
  },
  {
    "OlegGulevskyy/better-ts-errors.nvim",
    ft = { "typescript", "typescriptreact" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = {
      keymaps = {
        toggle = "<leader>e", -- default '<leader>dd'
      },
    },
  },
  {
    "vuki656/package-info.nvim",
    enabled = false,
    -- event = 'VeryLazy',
    -- event = 'BufRead package.json',
    -- event = 'BufReadPost package.json',
    config = function()
      require("package-info").setup()
    end,
    -- config = function()
    --   local package_info = require('package-info')
    --   local opts = {
    --   }
    --   package_info.setup(opts)
    --   -- local c = require('package-info/utils/constants')
    --   -- vim.api.nvim_create_autocmd('User', {
    --   --   group = c.AUTOGROUP,
    --   --   pattern = c.LOAD_EVENT,
    --   --   callback = function()
    --   --     -- execute a groupless autocmd so heirline can update
    --   --     vim.cmd.doautocmd('User', 'DkoPackageInfoStatusUpdate')
    --   --   end,
    --   -- })
    -- end,
    keys = {
      {
        "<leader>pnt",
        "<cmd>lua require('package-info').get_status()<CR>",
        desc = "[g]et status",
        silent = true,
        noremap = true,
      },
      {
        "<leader>pns",
        "<cmd>lua require('package-info').show()<CR>",
        desc = "[S]how",
        silent = true,
        noremap = true,
      },
      {
        "<leader>pnh",
        "<cmd>lua require('package-info').hide()<CR>",
        desc = "[H]ide",
        silent = true,
        noremap = true,
      },
      {
        "<leader>pnt",
        "<cmd>lua require('package-info').toggle()<CR>",
        desc = "[T]oggle",
        silent = true,
        noremap = true,
      },
      -- {
      --   '<leader>pnh',
      --   require('package-info').hide,
      --   mode = 'n',
      --   desc = '[H]ide',
      -- silent = true, noremap = true },
      {
        "<leader>pnc",
        "<cmd>lua require('package-info').change_version()<CR>",
        desc = "[C]hange Package Version",
        silent = true,
        noremap = true,
      },
    },
  },
}
