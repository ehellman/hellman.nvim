-- local servers = vim.tbl_extend('force', {
--   -- clangd = {},
--   -- gopls = {},
--   -- pyright = {},
--   --
--   -- Ansible
--   ansiblels = {},
--   --
--   -- Terraform
--   terraformls = {},
--   --
--   -- Rust
--   rust_analyzer = {},
--   --
--   -- TOML
--   taplo = {},
--   --
--   -- Python
--   pyright = {},
--   --
--   -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
--   --
--   -- TypeScript
--   -- Some languages (like typescript) have entire language plugins that can be useful:
--   --    https://github.com/pmizio/typescript-tools.nvim
--   -- ts_ls = {
--   --   settings = {
--   --     typescript = {
--   --       inlayHints = {
--   --         includeInlayEnumMemberValueHints = true,
--   --         includeInlayFunctionLikeReturnTypeHints = true,
--   --         includeInlayFunctionParameterTypeHints = true,
--   --         includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
--   --         includeInlayParameterNameHintsWhenArgumentMatchesName = true,
--   --         includeInlayPropertyDeclarationTypeHints = true,
--   --         includeInlayVariableTypeHints = false,
--   --       },
--   --     },
--   --   },
--   -- },
--   -- vtsls = {
--   --   enabled = false,
--   --   -- explicitly add default filetypes, so that we can extend
--   --   -- them in related extras
--   --   filetypes = {
--   --     'javascript',
--   --     'javascriptreact',
--   --     'javascript.jsx',
--   --     'typescript',
--   --     'typescriptreact',
--   --     'typescript.tsx',
--   --   },
--   --   settings = {
--   --     complete_function_calls = true,
--   --     vtsls = {
--   --       enableMoveToFileCodeAction = true,
--   --       autoUseWorkspaceTsdk = true,
--   --       experimental = {
--   --         maxInlayHintLength = 30,
--   --         completion = {
--   --           enableServerSideFuzzyMatch = true,
--   --         },
--   --       },
--   --     },
--   --     typescript = {
--   --       updateImportsOnFileMove = { enabled = 'always' },
--   --       suggest = {
--   --         completeFunctionCalls = true,
--   --       },
--   --       inlayHints = {
--   --         enumMemberValues = { enabled = true },
--   --         functionLikeReturnTypes = { enabled = true },
--   --         parameterNames = { enabled = 'literals' },
--   --         parameterTypes = { enabled = true },
--   --         propertyDeclarationTypes = { enabled = true },
--   --         variableTypes = { enabled = false },
--   --       },
--   --     },
--   --   },
--   -- },
--   -- eslint = {
--   -- },
--   --
--   -- CSS
--   cssls = {},
--   tailwindcss = {
--     filetypes_exclude = { 'markdown' },
--     root_dir = require('lspconfig').util.root_pattern(
--       'tailwind.config.js',
--       'tailwind.config.cjs',
--       'tailwind.config.ts',
--       'postcss.config.js',
--       'postcss.config.cjs',
--       'postcss.config.ts'
--     ),
--   },
--   --
--   -- C#
--   csharp_ls = {},
--   --
--   -- HTML
--   html = {},
--   -- emmet_language_server = {},
--   emmet_ls = {},
--   -- Docker
--   docker_compose_language_service = {},
--   dockerls = {},
--   --
--   -- Bash
--   bashls = {},
--   -- JSON
--   -- jsonls = {
--   --   -- TODO: continue fixing this
--   --   settings = {
--   --     json = {
--   --       format = { enable = true },
--   --       schemaStore = {
--   --         enable = false,
--   --         url = '',
--   --       },
--   --       schemas = require('schemastore').json.schemas({
--   --         -- use only subset instead of entire catalog
--   --         -- select = {
--   --         --   '.eslintrc',
--   --         --   'package.json',
--   --         -- },
--   --       }),
--   --       validate = { enable = true },
--   --     },
--   --   },
--   -- },
--   --
--   -- YAML
--   -- yamlls = {
--   --   capabilities = {
--   --     textDocument = {
--   --       foldingRange = {
--   --         -- TODO: Might be needed to support line folding
--   --         dynamicRegistration = false,
--   --         lineFoldingOnly = true,
--   --       },
--   --     },
--   --   },
--   --   settings = {
--   --     yaml = {
--   --       -- format = {
--   --       --   enable = true,
--   --       -- },
--   --       schemaStore = {
--   --         -- Built-in schemastore support must be disabled to use b0o/SchemaStore.nvim
--   --         enable = false,
--   --         -- Avoid TypeError: Cannot read properties of undefined
--   --         url = '',
--   --       },
--   --       schemas = require('schemastore').yaml.schemas({
--   --         -- extra = {
--   --         -- Add custom schemas here
--   --         -- {
--   --         --   name = 'Custom Docker Compose',
--   --         --   description = 'Custom Docker Compose',
--   --         --   fileMatch = { 'custom-compose.yml', },
--   --         --   url = 'https://custom-schema-url',
--   --         -- },
--   --         -- },
--   --         -- replace specific configs
--   --         -- replace = {
--   --         --   ['docker-compose.yml'] = {
--   --         --     description = 'Docker Compose Override',
--   --         --     fileMatch = { 'docker-compose.yml', 'compose.yml' },
--   --         --     name = 'Docker Compose',
--   --         --     url = "https://custom-schema-url"
--   --         --   },
--   --         -- },
--   --         -- ignore schemas from the catalog
--   --         -- ignore = { 'docker-compose.yml' }
--   --       }),
--   --       validate = { enable = true },
--   --     },
--   --   },
--   -- },
--   --
--   -- Lua
--   lua_ls = {
--     -- cmd = { ... },
--     -- filetypes = { ... },
--     -- capabilities = {},
--     settings = {
--       Lua = {
--
--         completion = {
--           callSnippet = 'Replace',
--         },
--         inlay_hints = {
--           -- Enable inlay hints for all files
--           enable = true,
--         },
--         -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--         -- diagnostics = { disable = { 'missing-fields' } },
--       },
--     },
--   },
-- }, opts.servers)

-- local ensure_installed = vim.tbl_keys(servers or {})
-- vim.list_extend(ensure_installed, {
--   'stylua', -- Used to format Lua code
--   'ansible-lint',
--   'yamlfmt',
-- })
-- require('mason').setup()
-- require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
--
-- require('mason-lspconfig').setup({
--   ensure_installed = {},
--   -- ensure_installed = ensure_installed,
--   -- ensure_installed = vim.tbl_keys(servers or {}),
--   automatic_installation = false,
--   handlers = {
--     function(server_name)
--       local server = servers[server_name] or {}
--       -- This handles overriding only values explicitly passed
--       -- by the server configuration above. Useful when disabling
--       -- certain features of an LSP (for example, turning off formatting for ts_ls)
--       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--       require('lspconfig')[server_name].setup(server)
--     end,
--   },
-- })

---@type LazySpec
--TODO: Add helpers like https://github.com/Nitestack/dotfiles/blob/main/nix/modules/home/neovim/lua/utils/plugin.lua#L61
return {
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    ---@class PluginLspOpts
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      inlay_hints = {
        -- Enable inlay hints for all files
        enabled = true,
        -- Disable inlay hints for specific filetypes
        disabled_filetypes = { "markdown" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    -- TODO: VeryLazy should not be needed, but without it, initial file open does not work, second file open works.
    event = "VeryLazy",
    opts_extend = { "servers.*.keys" },
    -- event = "LazyFile",
    -- event = {
    --   "BufReadPost",
    --   "BufNewFile",
    --   "BufWritePre",
    -- },
    dependencies = {
      -- "mason.nvim",
      "mason-org/mason.nvim",
      --TODO: difference between 2 below?
      { "mason-org/mason.nvim", config = function() end },

      -- bottom right status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- { 'hrsh7th/cmp-nvim-lsp', enabled = vim.g.cmp_variant == 'cmp' },
    },
    opts = function()
      ---@class PluginLspOpts
      local _opts = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = "if_many",
            prefix = "●",
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = HellVim.config.icons.diagnostics.Error,
              [vim.diagnostic.severity.WARN] = HellVim.config.icons.diagnostics.Warn,
              [vim.diagnostic.severity.HINT] = HellVim.config.icons.diagnostics.Hint,
              [vim.diagnostic.severity.INFO] = HellVim.config.icons.diagnostics.Info,
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = true,
        },
        -- Enable LSP-based folding (Neovim 0.12+)
        folds = {
          enabled = true,
        },
        -- options for vim.lsp.buf.format
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        ---@alias hellvim.lsp.Config vim.lsp.Config|{mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
        ---@type table<string, hellvim.lsp.Config|boolean>
        servers = {
          -- global config applied to all servers via vim.lsp.config("*", ...)
          ["*"] = {
            capabilities = {
              workspace = {
                fileOperations = {
                  didRename = true,
                  willRename = true,
                  didChangeWatchedFiles = { dynamicRegistration = false },
                },
              },
            },
            -- stylua: ignore
            keys = {
              { "<leader>cli", function() Snacks.picker.lsp_config() end, desc = "[i]nfo" },
              { "<leader>clr", HellVim.lsp.restart_all, desc = "[r]estart" },
              { "<leader>clt", HellVim.lsp.stop_all, desc = "s[t]op" },
              { "<leader>cls", HellVim.lsp.start_all, desc = "[s]tart" },
              { "<leader>cll", function() vim.cmd("lsp log") end, desc = "[l]og" },
              { "gd", vim.lsp.buf.definition, desc = "goto [D]efinition", has = "definition" },
              { "gr", vim.lsp.buf.references, desc = "goto [R]eferences", nowait = true },
              { "gI", vim.lsp.buf.implementation, desc = "goto [I]mplementation" },
              { "gy", vim.lsp.buf.type_definition, desc = "t[y]pe Definition" },
              { "gD", vim.lsp.buf.declaration, desc = "goto [D]eclaration" },
              { "K", function() return vim.lsp.buf.hover() end, desc = "Hover" },
              { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
              { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
              { "<leader>ca", vim.lsp.buf.code_action, desc = "Code [a]ction", mode = { "n", "v" }, has = "codeAction" },
              { "<leader>cc", vim.lsp.codelens.run, desc = "run [c]odelens", mode = { "n", "v" }, has = "codeLens" },
              { "<leader>cC", function() vim.lsp.codelens.enable(true, { bufnr = 0 }) end, desc = "refresh & display [C]odelens", mode = { "n" }, has = "codeLens" },
              { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "[R]ename file", mode = { "n" }, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
              { "<leader>cr", vim.lsp.buf.rename, desc = "[r]ename", has = "rename" },
              { "<leader>cA", HellVim.lsp.action.source, desc = "source [A]ction", has = "codeAction" },
              { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
                desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
              { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
                desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
              { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
                desc = "Next Reference", enabled = function() return Snacks.words.is_enabled() end },
              { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
                desc = "Prev Reference", enabled = function() return Snacks.words.is_enabled() end },
            },
          },
          bashls = {},
        },
        -- return true to prevent this server from being configured via vim.lsp.config
        ---@type table<string, fun(server:string, opts:vim.lsp.Config):boolean?>
        setup = {},
      }

      return _opts
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      opts.servers = opts.servers or {}
      -- setup autoformat
      HellVim.format.register(HellVim.lsp.formatter())

      -- setup keymaps (Snacks.keymap.set handles LSP method checks and buffer attachment)
      local names = vim.tbl_keys(opts.servers) ---@type string[]
      table.sort(names)
      for _, server in ipairs(names) do
        local server_opts = opts.servers[server]
        if type(server_opts) == "table" and server_opts.keys then
          require("custom.plugins.lsp.keymaps").set({ name = server ~= "*" and server or nil }, server_opts.keys)
        end
      end

      -- toggle inlay hints
      if vim.lsp.inlay_hint then
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end

      -- inlay hints
      if opts.inlay_hints.enabled then
        Snacks.util.lsp.on({ method = "textDocument/inlayHint" }, function(buffer)
          if
            vim.api.nvim_buf_is_valid(buffer)
            and vim.bo[buffer].buftype == ""
            and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
          then
            vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          end
        end)
      end

      -- code lens
      if opts.codelens.enabled and vim.lsp.codelens then
        Snacks.util.lsp.on({ method = "textDocument/codeLens" }, function(buffer)
          vim.lsp.codelens.enable(true, { bufnr = buffer })
        end)
      end

      -- LSP-based folding
      if opts.folds.enabled then
        Snacks.util.lsp.on({ method = "textDocument/foldingRange" }, function()
          vim.wo.foldmethod = "expr"
          vim.wo.foldexpr = "v:lua.vim.lsp.foldexpr()"
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = function(diagnostic)
          local icons = HellVim.config.icons.diagnostics
          for d, icon in pairs(icons) do
            if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
              return icon
            end
          end
          return "●"
        end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      -- apply global ("*") server config
      if opts.servers["*"] then
        vim.lsp.config("*", opts.servers["*"])
      end

      -- merge completion plugin capabilities into global config
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local has_blink, blink = pcall(require, "blink.cmp")
      if has_cmp then
        vim.lsp.config("*", { capabilities = cmp_nvim_lsp.default_capabilities() })
      end
      if has_blink then
        vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason = HellVim.has("mason-lspconfig.nvim")
      local mason_all = have_mason
          and vim.tbl_keys(require("mason-lspconfig.mappings").get_mason_map().lspconfig_to_package)
        or {} --[[@as string[] ]]
      local mason_exclude = {} ---@type string[]

      ---@return boolean? exclude from automatic mason setup
      local function configure(server)
        if server == "*" then
          return false
        end
        local sopts = opts.servers[server]
        sopts = sopts == true and {} or (not sopts) and { enabled = false } or sopts --[[@as hellvim.lsp.Config]]

        if sopts.enabled == false then
          mason_exclude[#mason_exclude + 1] = server
          return
        end

        local use_mason = sopts.mason ~= false and vim.tbl_contains(mason_all, server)
        local setup = opts.setup[server] or opts.setup["*"]
        if setup and setup(server, sopts) then
          mason_exclude[#mason_exclude + 1] = server
        else
          vim.lsp.config(server, sopts)
          if not use_mason then
            vim.lsp.enable(server)
          end
        end
        return use_mason
      end

      local install = vim.tbl_filter(configure, vim.tbl_keys(opts.servers))
      if have_mason then
        require("mason-lspconfig").setup({
          ensure_installed = vim.list_extend(install, HellVim.opts("mason-lspconfig.nvim").ensure_installed or {}),
          automatic_enable = { exclude = mason_exclude },
        })
      end
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {},
    },
    ---@param opts {ensure_installed: string[]}
    config = function(_, opts)
      require("mason-tool-installer").setup({
        ensure_installed = HellVim.dedup(opts.ensure_installed),
        -- auto_update = true,
      })

      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        once = true,
        callback = function()
          -- vim.notify("Sending MasonToolsInstall cmd", vim.log.levels.INFO)
          vim.cmd("MasonToolsInstall")
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsStartingInstall",
        callback = function(event)
          -- vim.notify(
          --   "Starting Mason tool installation of: " .. vim.inspect(event),
          --   vim.log.levels.INFO,
          --   { title = "MasonToolInstaller" }
          -- )
          -- vim.notify("Starting Mason tool installation", vim.log.levels.INFO)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsUpdateCompleted",
        ---@class MasonToolsUpdateResult
        ---@field buf number Buffer number associated with the event
        ---@field data string[] Package names
        ---@field event string Event name (User etc)
        ---@field file string File associated with the event (typically "MasonToolsUpdateCompleted")
        ---@field id number Event ID
        ---@field match string Matching event pattern
        callback = function(result)
          -- print('Mason trigger tools update result:', vim.inspect(result))
          local successes = {}
          local failed = {}
          for tool, success in pairs(result.data) do
            if success then
              table.insert(successes, tool)
              -- vim.notify("Successfully updated: " .. tool, vim.log.levels.INFO, { title = "MasonToolInstaller" })
            else
              table.insert(failed, tool)
              -- vim.notify("Failed to install: " .. tool, vim.log.levels.ERROR, { title = "MasonToolInstaller" })
            end
          end
          if #successes > 0 then
            vim.notify(
              "Successfully installed/updated " .. table.concat(successes, ", "),
              vim.log.levels.INFO,
              { title = "MasonToolInstaller" }
            )
          end
          if #failed > 0 then
            vim.notify(
              "Failed to install/update: " .. table.concat(failed, ", "),
              vim.log.levels.ERROR,
              { title = "MasonToolInstaller" }
            )
          end
        end,
      })
    end,
  },
  -- {
  --   'mason-org/mason-lspconfig.nvim',
  --   -- dependencies = {
  --   --   'mason-org/mason-lspconfig.nvim',
  --   --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   -- },
  --   -- opts_extend = { 'ensure_installed' },
  --   ---@module 'mason-lspconfig'
  --   ---@type MasonLspconfigSettings
  --   opts = {
  --     -- ensure_installed = {
  --     --   'stylua',
  --     --   'shfmt',
  --     -- },
  --   },
  --   config = function(_, opts)
  --     require('mason-lspconfig').setup()
  --   end,
  -- },
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>pm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    dependencies = {
      --   'mason-org/mason-lspconfig.nvim',
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts_extend = { "ensure_installed", "registries" },
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        border = "rounded",
      },
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
      -- ensure_installed = {
      --   'stylua',
      --   'shfmt',
      -- },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function(package)
        vim.defer_fn(function()
          vim.notify(
            "Mason package (" .. package.name .. ") installed successfully",
            vim.log.levels.INFO,
            { title = "Mason" }
          )
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },
}
