-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- local on_move_events = function(events)
--   local function on_move(data)
--     Snacks.rename.on_rename_file(data.source, data.destination)
--   end
--   -- local events = require('neo-tree.events')
--   return {
--     { event = events.FILE_MOVED, handler = on_move },
--     { event = events.FILE_RENAMED, handler = on_move },
--   }
-- end
---@module 'lazy'
---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-tree/nvim-web-devicons", lazy = true }, -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
    },
    -- init = function()
    -- vim.api.nvim_create_autocmd('BufEnter', {
    --   -- make a group to be able to delete it later
    --   group = vim.api.nvim_create_augroup('NeoTreeInit', { clear = true }),
    --   callback = function()
    --     local f = vim.fn.expand('%:p')
    --     if vim.fn.isdirectory(f) ~= 0 then
    --       vim.cmd('Neotree current dir=' .. f)
    --       -- neo-tree is loaded now, delete the init autocmd
    --       vim.api.nvim_clear_autocmds({ group = 'NeoTreeInit' })
    --     end
    --   end,
    -- })
    -- end,
    opts = function(_, opts)
      -- inform LSP clients that the file has been moved/renamed
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      return opts
    end,
    config = function(_, opts)
      require("neo-tree").setup(vim.tbl_deep_extend("force", opts, {
        -- Automatically clean up broken neo-tree buffers saved in sessions
        auto_clean_after_session_restore = true,
        close_if_last_window = true,
        filesystem = {
          hijack_netrw_behavior = "open_current",
          follow_current_file = { enabled = true },
          hide_dotfiles = false,
          hide_gitignored = false,
          -- Remains visible even if other settings would normally hide it
          always_show = {
            ".gitignore",
          },
          -- Remains hidden even if visible is toggled to true
          -- This overrides `always_show`
          never_show = {
            ".DS_Store",
            "Thumbs.db",
          },
          window = {
            mappings = {
              ["\\"] = "close_window",
            },
          },
        },
      }))
    end,

    -- opts = {
    -- },
  },
}
