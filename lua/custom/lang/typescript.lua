---@type LazySpec
return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'ts_ls',
        'prettier',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        ---@type vim.lsp.Config
        ts_ls = {
          enabled = true,
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
        -- vtsls = {
        --   enabled = false,
        -- },
      },
      -- setup = {
      --
      -- ts_ls = function()
      --
      --   return true
      -- end,
      -- vtsls = function()
      --   return true
      -- end,
      -- }
    },
  },
  -- {
  --   'vuki656/package-info.nvim',
  --   -- event = 'VeryLazy',
  --   -- event = 'BufRead package.json',
  --   -- event = 'BufReadPost package.json',
  --   config = function()
  --     require('package-info').setup()
  --   end,
  --   -- config = function()
  --   --   local package_info = require('package-info')
  --   --   local opts = {
  --   --   }
  --   --   package_info.setup(opts)
  --   --   -- local c = require('package-info/utils/constants')
  --   --   -- vim.api.nvim_create_autocmd('User', {
  --   --   --   group = c.AUTOGROUP,
  --   --   --   pattern = c.LOAD_EVENT,
  --   --   --   callback = function()
  --   --   --     -- execute a groupless autocmd so heirline can update
  --   --   --     vim.cmd.doautocmd('User', 'DkoPackageInfoStatusUpdate')
  --   --   --   end,
  --   --   -- })
  --   -- end,
  --   keys = {
  --     {
  --       '<leader>pnt',
  --       "<cmd>lua require('package-info').get_status()<CR>",
  --       desc = '[g]et status',
  --       silent = true,
  --       noremap = true,
  --     },
  --     {
  --       '<leader>pns',
  --       "<cmd>lua require('package-info').show()<CR>",
  --       desc = '[S]how',
  --       silent = true,
  --       noremap = true,
  --     },
  --     {
  --       '<leader>pnh',
  --       "<cmd>lua require('package-info').hide()<CR>",
  --       desc = '[H]ide',
  --       silent = true,
  --       noremap = true,
  --     },
  --     {
  --       '<leader>pnt',
  --       "<cmd>lua require('package-info').toggle()<CR>",
  --       desc = '[T]oggle',
  --       silent = true,
  --       noremap = true,
  --     },
  --     -- {
  --     --   '<leader>pnh',
  --     --   require('package-info').hide,
  --     --   mode = 'n',
  --     --   desc = '[H]ide',
  --     -- silent = true, noremap = true },
  --     {
  --       '<leader>pnc',
  --       "<cmd>lua require('package-info').change_version()<CR>",
  --       desc = '[C]hange Package Version',
  --       silent = true,
  --       noremap = true,
  --     },
  --   },
  -- },
}
