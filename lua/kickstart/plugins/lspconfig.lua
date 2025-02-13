-- LSP Plugins
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
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    -- event = {
    --   'BufReadPost',
    --   'BufNewFile',
    --   'BufWritePre',
    -- },
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- vim.g.enable_snacks_picker and 'folke/snacks.nvim' or {},

      -- Allowg extra capabilities provided by nvim-cmp
      -- 'hrsh7th/cmp-nvim-lsp',
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- local buffer = event.buf
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- Auto-enable inlay hints for the current buffer if the client supports it
          -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          -- end

          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local lsp_references = vim.g.enable_snacks_picker and require('snacks.picker').lsp_references or require('telescope.builtin').lsp_references

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', lsp_references, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', lsp_references, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', lsp_references, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>csd', lsp_references, '[D]ocument Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>csw', vim.g.enable_snacks_picker and function()
            require('snacks.picker').lsp_references((function(lsp_opts)
              vim.tbl_extend('force', lsp_opts, { workspace = true })
            end)())
          end or require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace Symbols')

          -- TODO: Figure out what this does..

          map('<leader>cA', function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = { 'source' },
                diagnostics = {},
              },
            })
          end, 'Source [A]ction')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>cr', vim.lsp.buf.rename, '[r]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, 'Code [a]ction', { 'n', 'x' })

          map('<leader>cc', vim.lsp.codelens.run, 'Run [c]odelens', { 'n', 'v' })
          map('<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display [C]odelens', { 'n' })

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'kickstart-lsp-highlight', buffer = event2.buf })
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>uh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Change diagnostic symbols in the sign column (gutter)
      if vim.g.have_nerd_font then
        local signs = { ERROR = '', WARN = '', INFO = '', HINT = '' }
        local diagnostic_signs = {}
        for type, icon in pairs(signs) do
          diagnostic_signs[vim.diagnostic.severity[type]] = icon
        end
        vim.diagnostic.config({ signs = { text = diagnostic_signs } })
      end

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_extend(
        'force',
        capabilities,
        vim.g.cmp_variant == 'blink' and require('blink.cmp').get_lsp_capabilities() or require('cmp_nvim_lsp').update_capabilities(capabilities)
      )
      -- if vim.g.cmp_variant == 'blink' then
      --   capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())
      --   -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      -- else
      --   capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      -- end

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        --
        -- Ansible
        ansiblels = {},
        --
        -- Terraform
        terraformls = {},
        --
        -- Rust
        rust_analyzer = {},
        --
        -- TOML
        taplo = {},
        --
        -- Python
        pyright = {},
        --
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- TypeScript
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayEnumMemberValueHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayVariableTypeHints = false,
              },
            },
          },
        },
        eslint = {},
        --
        -- CSS
        cssls = {},
        tailwindcss = {
          filetypes_exclude = { 'markdown' },
          root_dir = require('lspconfig').util.root_pattern(
            'tailwind.config.js',
            'tailwind.config.cjs',
            'tailwind.config.ts',
            'postcss.config.js',
            'postcss.config.cjs',
            'postcss.config.ts'
          ),
        },
        --
        -- C#
        csharp_ls = {},
        --
        -- HTML
        html = {},
        -- emmet_language_server = {},
        emmet_ls = {},
        -- Docker
        docker_compose_language_service = {},
        dockerls = {},
        --
        -- Bash
        bashls = {},
        -- JSON
        jsonls = {
          -- TODO: continue fixing this
          settings = {
            json = {
              format = { enable = true },
              schemaStore = {
                enable = false,
                url = '',
              },
              schemas = require('schemastore').json.schemas({
                -- use only subset instead of entire catalog
                -- select = {
                --   '.eslintrc',
                --   'package.json',
                -- },
              }),
              validate = { enable = true },
            },
          },
        },
        --
        -- YAML
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                -- TODO: Might be needed to support line folding
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          settings = {
            yaml = {
              -- format = {
              --   enable = true,
              -- },
              schemaStore = {
                -- Built-in schemastore support must be disabled to use b0o/SchemaStore.nvim
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined
                url = '',
              },
              schemas = require('schemastore').yaml.schemas({
                -- extra = {
                -- Add custom schemas here
                -- {
                --   name = 'Custom Docker Compose',
                --   description = 'Custom Docker Compose',
                --   fileMatch = { 'custom-compose.yml', },
                --   url = 'https://custom-schema-url',
                -- },
                -- },
                -- replace specific configs
                -- replace = {
                --   ['docker-compose.yml'] = {
                --     description = 'Docker Compose Override',
                --     fileMatch = { 'docker-compose.yml', 'compose.yml' },
                --     name = 'Docker Compose',
                --     url = "https://custom-schema-url"
                --   },
                -- },
                -- ignore schemas from the catalog
                -- ignore = { 'docker-compose.yml' }
              }),
              validate = { enable = true },
            },
          },
        },
        --
        -- Lua
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {

              completion = {
                callSnippet = 'Replace',
              },
              inlay_hints = {
                -- Enable inlay hints for all files
                enable = true,
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'ansible-lint',
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers or {}),
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
