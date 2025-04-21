---@type LazySpec
return {
  {
    "akinsho/bufferline.nvim",
    -- event: should load when needed, no need to declare!
    event = {
      "BufReadPost",
      "BufNewFile",
      "BufWritePre",
    },
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "toggle [p]in" },
      { "<leader>bDp", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "non-[p]inned" },
      { "<leader>bDr", "<Cmd>BufferLineCloseRight<CR>", desc = "to the [r]ight" },
      { "<leader>bDl", "<Cmd>BufferLineCloseLeft<CR>", desc = "to the [l]eft" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "prev +buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "next -buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
    },
    opts = function(_, opts)
      opts = opts or {}

      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      end

      opts.options = opts.options or {}
      opts.options.close_command = function(n)
        require("snacks").bufdelete(n)
      end
      opts.options.right_mouse_command = function(n)
        require("snacks").bufdelete(n)
      end
      opts.options.diagnostics = "nvim_lsp"
      opts.options.always_show_bufferline = false
      opts.options.offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          highlight = "Directory",
          text_align = "left",
        },
        {
          filetype = "snacks_layout_box",
        },
      }
      return opts
    end,
    config = function(_, opts)
      require("bufferline").setup(opts)
      require("snacks")
        .toggle({
          name = "Bufferline",
          get = function()
            return vim.o.showtabline == 1 or vim.o.showtabline == 2
          end,
          set = function()
            if vim.o.showtabline == 2 then
              vim.o.showtabline = 0
            else
              vim.o.showtabline = 2
            end
          end,
        })
        :map("<leader>ub")

      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
