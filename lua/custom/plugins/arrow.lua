if vim.g.enable_arrow then
  HellVim.on_load("which-key.nvim", function()
    vim.notify("which-key.nvim loaded", vim.log.levels.INFO, { title = "arrow.nvim" })
    vim.schedule(function()
      local wk = require("which-key")

      for i = 1, 5 do
        wk.add({
          {
            string.format("<leader>%d", i),
            function()
              require("arrow.persist").go_to(i)
            end,
            desc = string.format("jump to harpooned [%d]", i),
          },
        })
      end
    end)
  end)
end

return {
  {
    ---@module 'arrow'
    "otavioschwanck/arrow.nvim",
    enabled = vim.g.enable_arrow,
    event = "VeryLazy",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "folke/which-key.nvim" },
    },
    ---@type PluginKeySpec
    keys = {
      {
        "<leader>hh",
        function()
          require("arrow.ui").toggle_quick_menu()
        end,
        desc = "[h]arpoon",
      },
      {
        "<leader>h",
        function()
          local filename = require("arrow.utils").get_current_buffer_path()
          if require("arrow.persist").is_saved(filename) then
            vim.notify("unharpooned file", vim.log.levels.INFO, { title = "arrow.nvim" })
            require("arrow.persist").remove(filename)
          else
            vim.notify("harpooned file", vim.log.levels.INFO, { title = "arrow.nvim" })
            require("arrow.persist").save(filename)
          end
        end,
        desc = "[h]arpoon file",
      },
      {
        "<leader>hh",
        function()
          require("arrow.ui").openMenu()
        end,
        desc = "show [h]arpooned files",
      },
      {
        "<leader>hj",
        function()
          require("arrow.persist").next()
        end,
        desc = "[n]ext file",
      },
      {
        "<leader>hk",
        function()
          require("arrow.persist").previous()
        end,
        desc = "jump to [p]revious file",
      },
      {
        "<leader>hr",
        function()
          require("arrow.persist").clear()
        end,
        desc = "[r]eset harpoon marks",
      },
    },
    --
    opts = {
      mappings = {
        toggle = "a",
      },
      show_icons = true,
      leader_key = "<leader>hh", -- Recommended to be a single key
      buffer_leader_key = "m", -- Per Buffer Mappings
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     -- spec = {
  --
  --     -- {
  --     --   "<leader>h",
  --     --   group = "[h]arpoon",
  --     -- },
  --     icons = {
  --       ---@type wk.IconRule[]
  --       rules = {
  --         -- ignore [] and match against harpoon*
  --         {
  --           plugin = "otavioschwanck/arrow.nvim",
  --           pattern = "%f[%w]h?arpoon[a-z]*%f[%W]",
  --           icon = "󱡁",
  --           color = "orange",
  --         },
  --         {
  --           plugin = "otavioschwanck/arrow.nvim",
  --           icon = "󱡁",
  --           color = "orange",
  --         },
  --       },
  --     },
  --   },
  -- },
}
