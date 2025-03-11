---@type LazySpec
return {
  "nvim-lualine/lualine.nvim",
  -- event = {
  --   'BufReadPost',
  --   'BufNewFile',
  --   'BufWritePre',
  -- },
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  -- opts = function(_, optsw
  --
  --   return opts
  -- end,
  opts = {
    theme = "catppuccin",
    sections = {
      lualine_a = {
        {
          "mode",
        },
      },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = {
        -- { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
        -- {
        --   harpoon_comp,
        --   icons_enabled = true,
        -- },
      },
      lualine_x = {
          -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.command.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
          --   color = function() return { fg = Snacks.util.color("Statement") } end,
          -- },
          -- -- stylua: ignore
          -- {
          --   function() return require("noice").api.status.mode.get() end,
          --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
          --   color = function() return { fg = Snacks.util.color("Constant") } end,
          -- },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = function() return { fg = Snacks.util.color("Debug") } end,
          },
          -- stylua: ignore
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function() return { fg = Snacks.util.color("Special") } end,
          },
      },
      lualine_y = {
        { "progress", separator = " ", padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
        { "filetype", padding = { left = 1, right = 1 } },
      },
      lualine_z = { "hostname" },
    },
    extensions = { "neo-tree", "lazy", "fzf" },
    options = {
      disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      -- component_separators = { left = '', right = '' },
      -- section_separators = { left = '', right = '' },
    },
  },
  config = function(_, opts)
    -- local harpoon_comp = function()
    --   -- simplified version of this https://github.com/letieu/harpoon-lualine
    --   local options = {
    --     icon = '󰀱 ',
    --     indicators = { '1', '2', '3', '4', '5' },
    --     active_indicators = { '[1]', '[2]', '[3]', '[4]', '[5]' },
    --     separator = ' ',
    --   }
    --   local list = require('harpoon'):list()
    --   local root_dir = list.config:get_root_dir()
    --   local current_file_path = vim.api.nvim_buf_get_name(0)
    --
    --   local length = math.min(list:length(), #options.indicators)
    --
    --   local status = {}
    --   local get_full_path = function(root, value)
    --     return root .. vim.g.path_separator .. value
    --   end
    --
    --   for i = 1, length do
    --     local value = list:get(i).value
    --     local full_path = get_full_path(root_dir, value)
    --
    --     -- if full_path == current_file_path then
    --     --   table.insert(status, options.active_indicators[i])
    --     -- else
    --     --   table.insert(status, options.indicators[i])
    --     -- end
    --     if full_path == current_file_path then
    --       table.insert(status, '%#HarpoonStatuslineActive#' .. options.active_indicators[i] .. '%#Normal#')
    --     else
    --       table.insert(status, '%#HarpoonStatuslineInactive#' .. options.indicators[i] .. '%#Normal#')
    --     end
    --   end
    --
    --   return table.concat(status, options.separator)
    -- end

    require("lualine").setup(vim.tbl_deep_extend("force", opts, {}))
  end,
}
