return {
  -- {
  --   'williamboman/mason.nvim',
  --   opts_extend = { 'ensure_installed' },
  --   opts = {
  --     ui = { border = 'rounded' },
  --     ensure_installed = { 'stylua', 'shfmt' },
  --   },
  --   ---@param opts MasonSettings | {ensure_installed: string[]}
  --   config = function(_, opts)
  --     require('mason').setup(opts)
  --
  --     local mason_registry = require('mason-registry')
  --
  --     mason_registry:on('package:install:success', function()
  --       vim.defer_fn(function()
  --         -- trigger FileType event to possibly load this newly installed LSP server
  --         require('lazy.core.handler.event').trigger({
  --           event = 'FileType',
  --           buf = vim.api.nvim_get_current_buf(),
  --         })
  --       end, 100)
  --     end)
  --
  --     mason_registry.refresh(function()
  --       for _, tool in ipairs(opts.ensure_installed) do
  --         local p = mason_registry.get_package(tool)
  --         if not p:is_installed() then
  --           p:install()
  --         end
  --       end
  --     end)
  --   end,
  -- },
  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   dependencies = {
  --     -- 'williamboman/mason.nvim',
  --     'neovim/nvim-lspconfig',
  --   },
  --   opts = {
  --     automatic_installation = true,
  --   },
  --   -- config = function(_, opts)
  --   --   -- mlsp.setup({
  --   --   --   ensure_installed = ensure_installed,
  --   --   --   -- ensure_installed = vim.tbl_keys(servers or {}),
  --   --   --   automatic_installation = true,
  --   --   --   handlers = {
  --   --   --     function(server_name)
  --   --   --       local server = servers[server_name] or {}
  --   --   --       -- This handles overriding only values explicitly passed
  --   --   --       -- by the server configuration above. Useful when disabling
  --   --   --       -- certain features of an LSP (for example, turning off formatting for ts_ls)
  --   --   --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  --   --   --       require('lspconfig')[server_name].setup(server)
  --   --   --     end,
  --   --   --   },
  --   --   -- })
  --   --   require('mason-lspconfig').setup(opts)
  --   -- end,
  --
  --   -- config = function()
  --   --   require('mason-lspconfig').setup({
  --   --     ensure_installed = { ... },
  --   --   })
  --   --
  --   --   -- Custom server setup
  --   --   require('mason-lspconfig').setup_handlers({
  --   --     -- Default handler
  --   --     function(server_name)
  --   --       require('lspconfig')[server_name].setup({})
  --   --     end,
  --   --
  --   --     -- Custom handlers for specific servers
  --   --     ['lua_ls'] = function()
  --   --       require('lspconfig').lua_ls.setup({
  --   --         settings = {
  --   --           Lua = {
  --   --             diagnostics = {
  --   --               globals = { 'vim' },
  --   --             },
  --   --           },
  --   --         },
  --   --       })
  --   --     end,
  --   --   })
  --   -- end,
  -- },
}
