local function generate_harpoon_picker()
  local file_paths = {}
  for _, item in ipairs(require("harpoon"):list().items) do
    table.insert(file_paths, {
      text = item.value,
      file = item.value,
    })
  end
  return file_paths
end

-- dynamically set up 1-5 keys for harpoon, without loading harpoon

if vim.g.enable_harpoon then
  local wk = require("which-key")

  for i = 1, 5 do
    wk.add({
      {
        string.format("<leader>%d", i),
        function()
          require("harpoon"):list():select(i)
        end,
        desc = string.format("jump to harpooned [%d]", i),
      },
    })
  end
end

---@module 'lazy'
---@type LazySpec
return {
  {
    ---@module 'harpoon'
    "ThePrimeagen/harpoon",
    enabled = vim.g.enable_harpoon,
    branch = "harpoon2",
    version = false,
    dependencies = { "nvim-lua/plenary.nvim", "folke/which-key.nvim" },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      local harpoon = require("harpoon")
      harpoon:setup(opts)
    end,
  },
  {
    "folke/which-key.nvim",

    opts = function()
      if vim.g.enable_harpoon then
        return {
          spec = {

            -- {
            --   "<leader>h",
            --   group = "[h]arpoon",
            -- },
            {
              "<leader>h",
              function()
                vim.notify("harpooned file", vim.log.levels.INFO, { title = "harpoon" })
                require("harpoon"):list():add()
              end,
              desc = "[h]arpoon file",
            },
            {
              "<leader>hh",
              function()
                require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
              end,
              desc = "show [h]arpooned files",
            },
            {
              "<leader>hj",
              function()
                require("harpoon"):list():next()
              end,
              desc = "[n]ext file",
            },
            {
              "<leader>hk",
              function()
                require("harpoon"):list():prev()
              end,
              desc = "jump to [p]revious file",
            },
            {
              "<leader>hr",
              function()
                require("harpoon"):list():clear()
              end,
              desc = "[r]eset harpoon marks",
            },
          },
          icons = {
            ---@type wk.IconRule[]
            rules = {
              -- ignore [] and match against harpoon*
              {
                plugin = "ThePrimeagen/harpoon",
                pattern = "%f[%w]h?arpoon[a-z]*%f[%W]",
                icon = "󰀱",
                color = "orange",
              },
            },
          },
        }
      end
    end,
    -- opts = {
    --   spec = {
    --
    --     -- {
    --     --   "<leader>h",
    --     --   group = "[h]arpoon",
    --     -- },
    --     {
    --       "<leader>h",
    --       function()
    --         vim.notify("harpooned file", vim.log.levels.INFO, { title = "harpoon" })
    --         require("harpoon"):list():add()
    --       end,
    --       desc = "[h]arpoon file",
    --     },
    --     {
    --       "<leader>hh",
    --       function()
    --         require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
    --       end,
    --       desc = "show [h]arpooned files",
    --     },
    --     {
    --       "<leader>hj",
    --       function()
    --         require("harpoon"):list():next()
    --       end,
    --       desc = "[n]ext file",
    --     },
    --     {
    --       "<leader>hk",
    --       function()
    --         require("harpoon"):list():prev()
    --       end,
    --       desc = "jump to [p]revious file",
    --     },
    --     {
    --       "<leader>hr",
    --       function()
    --         require("harpoon"):list():clear()
    --       end,
    --       desc = "[r]eset harpoon marks",
    --     },
    --   },
    --   icons = {
    --     ---@type wk.IconRule[]
    --     rules = {
    --       -- ignore [] and match against harpoon*
    --       { plugin = "ThePrimeagen/harpoon", pattern = "%f[%w]h?arpoon[a-z]*%f[%W]", icon = "󰀱", color = "orange" },
    --     },
    --   },
    -- },
  },
}
