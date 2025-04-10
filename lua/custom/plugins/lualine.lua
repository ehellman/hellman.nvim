---@type LazySpec
---@module 'lualine'
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {},
  config = function(_, opts)
    local lualine = require("lualine")
    local lualine_aug = vim.api.nvim_create_augroup("StatusLineWatchRecording", { clear = true })
    vim.api.nvim_create_autocmd("RecordingEnter", {
      group = lualine_aug,
      callback = function()
        lualine.refresh({ place = { "statusline" } })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      group = lualine_aug,
      callback = function()
        local timer = vim.loop.new_timer()
        timer:start(50, 0, function()
          vim.schedule_wrap(function()
            lualine.refresh({ place = { "statusline" } })
            timer:stop()
            timer:close()
          end)
        end)
      end,
    })

    local function macro_recording_component()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      end
      return "recording @" .. recording_register
    end

    lualine.setup(vim.tbl_deep_extend("force", opts, {
      theme = "catppuccin",
      extensions = { "neo-tree", "lazy", "fzf" },
      options = {
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- component_separators = { left = '', right = '' },
        -- section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          {
            "mode",
          },
          {
            macro_recording_component,
          },
        },
        lualine_b = {
          "branch",
          "diff",
          "diagnostics",
        },
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
    }))
  end,
}
