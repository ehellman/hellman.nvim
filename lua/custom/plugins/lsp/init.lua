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
    'folke/lazydev.nvim',
    ft = 'lua',
    ---@class PluginLspOpts
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
      inlay_hints = {
        -- Enable inlay hints for all files
        enabled = true,
        -- Disable inlay hints for specific filetypes
        disabled_filetypes = { 'markdown' },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    -- event = 'VeryLazy',
    -- event = 'LazyFile',
    event = {
      'BufReadPost',
      'BufNewFile',
      'BufWritePre',
    },
    dependencies = {
      'mason.nvim',
      -- 'williamboman/mason-lspconfig.nvim',
      -- 'williamboman/mason.nvim',
      --TODO: difference between 2 below?
      { 'williamboman/mason-lspconfig.nvim', config = function() end },
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- bottom right status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

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
            source = 'if_many',
            prefix = '●',
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
          exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
        },
        -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the code lenses.
        codelens = {
          enabled = true,
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
              -- PERF: didChangeWatchedFiles is too slow.
              -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
              didChangeWatchedFiles = { dynamicRegistration = false },
            },
          },
        },
        -- TODO: This is from LazyVim, probably not needed?
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        ---@type lspconfig.options
        servers = {},
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = { -- NOTE: without this propery on _opts indexing against opts.setup will not work
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }

      return _opts
    end,
    ---@param opts PluginLspOpts
    config = function(_, opts)
      opts.servers = opts.servers or {}
      -- setup autoformat
      HellVim.format.register(HellVim.lsp.formatter())

      -- setup keymaps callback for when lsp.on_attach runs
      HellVim.lsp.on_attach(function(client, buffer)
        require('custom.plugins.lsp.keymaps').on_attach(client, buffer)
      end)

      -- setup dynamic capabilities registration
      HellVim.lsp.setup()
      HellVim.lsp.on_dynamic_capability(require('custom.plugins.lsp.keymaps').on_attach)

      -- diagnostics signs
      -- if vim.fn.has("nvim-0.10.0") == 0 then -- TODO: delete
      --   if type(opts.diagnostics.signs) ~= "boolean" then
      --     for severity, icon in pairs(opts.diagnostics.signs.text) do
      --       local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
      --       name = "DiagnosticSign" .. name
      --       vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      --     end
      --   end
      -- end
      -- diagnostics signs
      if vim.fn.has('nvim-0.10') == 1 then
        -- inlay hints
        if opts.inlay_hints.enabled then
          HellVim.lsp.on_supports_method('textDocument/inlayHint', function(client, buffer)
            if
              vim.api.nvim_buf_is_valid(buffer)
              and vim.bo[buffer].buftype == ''
              and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[buffer].filetype)
            then
              vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
            end
          end)
        end

        -- code lens
        if opts.codelens.enabled and vim.lsp.codelens then
          HellVim.lsp.on_supports_method('textDocument/codeLens', function(client, buffer)
            vim.lsp.codelens.refresh()
            vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
              buffer = buffer,
              callback = vim.lsp.codelens.refresh,
            })
          end)
        end
      end -- TODO: end of nvim-0.10.0 check, maybe delete?

      if type(opts.diagnostics.virtual_text) == 'table' and opts.diagnostics.virtual_text.prefix == 'icons' then
        opts.diagnostics.virtual_text.prefix = vim.fn.has('nvim-0.10.0') == 0 and '●'
          or function(diagnostic)
            local icons = HellVim.config.icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local has_blink, blink = pcall(require, 'blink.cmp')

      local capabilities = vim.tbl_deep_extend(
        'force',
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        has_blink and blink.get_lsp_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local have_mason_tool_installer, mason_tool_installer = pcall(require, 'mason-tool-installer')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        vim.tbl_deep_extend(
          'force',
          ensure_installed,
          HellVim.opts('mason.nvim').ensure_installed or {},
          HellVim.opts('mason-lspconfig.nvim').ensure_installed or {}
        )
        if have_mason_tool_installer then
          --TODO: if i install with tool installer instead of mason,
          --it does not install the stuff from the merged ensure_installed in the
          --mason-tool-installer module declaration
          --   mason_tool_installer.setup({ ensure_installed = ensure_installed })
        end
        -- vim.notify('Installing LSP servers: ' .. table.concat(ensure_installed, ', '), 'info')
        mlsp.setup({
          ensure_installed = ensure_installed or {},
          -- ensure_installed = have_mason_tool_installer and {} or ensure_installed,
          automatic_installation = true,
          handlers = { setup },
        })
      end

      if HellVim.lsp.is_enabled('denols') and HellVim.lsp.is_enabled('vtsls') then
        local is_deno = require('lspconfig.util').root_pattern('deno.json', 'deno.jsonc')
        HellVim.lsp.disable('vtsls', is_deno)
        HellVim.lsp.disable('denols', function(root_dir, config)
          if not is_deno(root_dir) then
            config.settings.deno.enable = false
          end
          return false
        end)
      end
    end,
  },
  {
    ---@module 'mason-tool-installer'
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- cmd = {
    --   'MasonToolsInstall',
    --   'MasonToolsInstallSync',
    --   'MasonToolsUpdate',
    --   'MasonToolsUpdateSync',
    --   'MasonToolsClean',
    -- },
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    opts = {
      ensure_installed = {},
    },
    ---@param opts {ensure_installed: string[]}
    config = function(_, opts)
      -- print('MASONTOOLSENSUREINSTALLED', vim.inspect(opts.ensure_installed))
      require('mason-tool-installer').setup({
        ensure_installed = opts.ensure_installed,
        -- auto_update = true,
      })

      vim.api.nvim_create_autocmd({ 'BufEnter' }, {
        once = true,
        callback = function()
          -- vim.notify('Sending MasonToolsInstall cmd', vim.log.levels.INFO)
          vim.cmd('MasonToolsInstall')
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MasonToolsStartingInstall',
        callback = function()
          -- print('Mason trigger tools to install')
          -- vim.notify('Starting Mason tool installation', vim.log.levels.INFO)
        end,
      })

      vim.api.nvim_create_autocmd('User', {
        pattern = 'MasonToolsUpdateCompleted',
        ---@class MasonToolsUpdateResult
        ---@field buf number Buffer number associated with the event
        ---@field data string[] Package names
        ---@field event string Event name (User etc)
        ---@field file string File associated with the event (typically "MasonToolsUpdateCompleted")
        ---@field id number Event ID
        ---@field match string Matching event pattern
        callback = function(result)
          -- print('Mason trigger tools update result:', vim.inspect(result))
          -- vim.notify('Completed!', vim.log.levels.INFO, { title = 'MasonToolsUpdate' })
          for tool, success in pairs(result.data) do
            if not success then
              vim.notify('Failed to install: ' .. tool, vim.log.levels.ERROR, { title = 'MasonToolInstaller' })
            end
          end
        end,
      })
    end,
  },
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   -- dependencies = {
  --   --   'williamboman/mason-lspconfig.nvim',
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
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>pm', '<cmd>Mason<cr>', desc = 'Mason' } },
    build = ':MasonUpdate',
    -- dependencies = {
    --   'williamboman/mason-lspconfig.nvim',
    --   'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- },
    -- opts_extend = { 'ensure_installed' },
    ---@module 'mason'
    ---@type MasonSettings
    opts = {
      ui = {
        border = 'rounded',
      },
      -- ensure_installed = {
      --   'stylua',
      --   'shfmt',
      -- },
    },
  },
}
