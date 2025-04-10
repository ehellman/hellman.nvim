---@type HellPicker
local picker = {
  name = "snacks",
  commands = {
    files = "files",
    live_grep = "grep",
    oldfiles = "recent",
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return require("snacks.picker").pick(source, opts)
  end,
}

---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = function()
      local Snacks = require("snacks")

      -- snacks toggles
      Snacks.toggle.scroll():map("<leader>uS")
      Snacks.toggle.line_number():map("<leader>ull", { desc = "[l]ine numbers" })
      Snacks.toggle.dim():map("<leader>uD")
      Snacks.toggle.option("relativenumber"):map("<leader>ulr")
      Snacks.toggle.zoom():map("<leader>uz")
      Snacks.toggle.zen():map("<leader>uZ")
      Snacks.toggle.words():map("<leader>uw")
      Snacks.toggle.animate():map("<leader>ua")
      -- .zoom():map("<leader>uD")
      -- Snacks.toggle.profiler():map("<leader>upp")
      -- Snacks.toggle.profiler_highlights():map("<leader>uph")

      ---@type LazyKeysSpec[]
      return {
        --stylua: ignore start
        --- Buffers 
        { '<leader>bD', desc = '[D]elete' },
        { '<leader>bd', function() Snacks.bufdelete.delete() end, desc = '[d]elete' },
        { '<leader>bDc',function() Snacks.bufdelete.delete() end, desc = '[c]urrent' },
        { '<leader>bDo', function() Snacks.bufdelete.other() end, desc = '[o]ther than current' },
        { '<leader>bDa', function() Snacks.bufdelete.all() end, desc = '[a]ll' },
        --
        --- Git/Lazygit
        { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazy[g]it' },
        -- { "<leader>gl", "", desc = "+[l]og"},
        { '<leader>gl', function() Snacks.picker.git_log() end, desc = '[l]og' },
        -- { '<leader>gll', function() Snacks.picker.git_log() end, desc = 'git [l]og (root)' },
        { '<leader>gli', function() Snacks.picker.git_log_line() end, desc = 'git log l[i]ne' },
        { '<leader>glf', function() Snacks.picker.git_log_file() end, desc = 'git log [F]ile' },
        { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'git [d]iff' },
        { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'git [s]tatus' },
        { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'git [S]tash' },
        { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'git [b]ranches' },
        { '<leader>gB', function() Snacks.git.blame_line() end, desc = 'git [B]lame Line' },
        --
        --- Search
        { '<leader>sf', function() picker.open('files', { hidden = true }) end, desc = '[f]iles' }, -- Files
        { '<leader>sF', function() picker.open('files', { root = false }) end, desc = '[F]iles (cwd)' }, -- Files (cwd) TODO: this does not work correctly
        { '<leader>sr', function() picker.open('recent') end, desc = '[r]ecent' }, -- Recent
        { '<leader>sR', function() Snacks.picker.registers() end, desc = '[R]egisters' }, -- Registers
        { '<leader>sH', function() Snacks.picker.help() end, desc = '[H]elp' }, -- Help
        { '<leader>sh', function() Snacks.picker.cliphist() end, desc = 'clip[h]ist' }, -- Cliphist
        { '<leader>s:', function() Snacks.picker.command_history() end, desc = '[:]cmd history' }, -- Command History
        { '<leader>sl', function() Snacks.picker.lines() end, desc = 'buffer [l]ines' }, -- Lines
        { '<leader>sg', function() Snacks.picker.grep() end, desc = '[g]rep root dir' }, -- Grep
        { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "grep visual selection or [w]ord", mode = { "n", "x" } }, -- Grep Word
        { '<leader>sj', function() Snacks.picker.jumps() end, desc = '[j]umps' }, -- Jumps
        { '<leader>sb', function() Snacks.picker.buffers() end, desc = '[b]uffers' }, -- Buffers
        { '<leader>su', function() Snacks.picker.undo() end, desc = '[u]ndo tree' }, -- Undo actions
        { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[k]eymaps' }, -- Keymaps
        { '<leader>sM', function() Snacks.picker.man() end, desc = '[M]anpages' }, -- Help
        { '<leader>sm', function() Snacks.picker.marks() end, desc = '[m]arks' }, -- Marks
        { '<leader>r', function() Snacks.picker.resume() end, desc = '[r]esume picker' }, -- Resume / Reopen
        --
        --- Scratch
        { "<leader>.", function() Snacks.scratch() end, desc = "toggle scratch buffer" },
        { "<leader>.s", function() Snacks.scratch.select() end, desc = "search [s]cratch buffer" },
        --
        --- Toggles
        --
        --stylua: ignore end
      }
    end,
    ---@type snacks.Config
    opts = {
      ---@class snacks.bigfile.Config
      bigfile = {
        enabled = true,
        notify = true, -- show notification when big file detected
        size = 1.5 * 1024 * 1024, -- 1.5MB
        -- Enable or disable features when big file detected
        ---@param ctx {buf: number, ft:string}
        setup = function(ctx)
          if vim.fn.exists(":NoMatchParen") ~= 0 then
            vim.cmd([[NoMatchParen]])
          end
          Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
          vim.b.minianimate_disable = true
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ctx.buf) then
              vim.bo[ctx.buf].syntax = ctx.ft
            end
          end)
        end,
      },

      animate = { enabled = vim.g.enable_snacks_animate },

      toggle = { enabled = true },

      rename = { enabled = true },

      lazygit = {
        configure = true,
      },

      dashboard = {
        enabled = true,
        preset = {
          pick = function(cmd, opts)
            return Snacks.picker.pick(cmd, opts)()
          end,
          header = [[
                                                                   
      ████ ██████           █████      ██                    
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
        ]],
       -- stylua: ignore
       ---@type snacks.dashboard.Item[]
       keys = {
         { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.pick('files')" },
         { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
         { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
         { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
         { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })"},
         { icon = " ", key = "s", desc = "Restore Session", section = "session" },
         { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
         { icon = " ", key = "q", desc = "Quit", action = ":qa" },
       },
        },
      },

      ---@class snacks.indent.Config
      indent = {
        enabled = true,
        priority = 1,
        char = "│",
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --   'SnacksIndent1',
        --   'SnacksIndent2',
        --   -- "SnacksIndent3",
        --   -- "SnacksIndent4",
        --   -- "SnacksIndent5",
        --   -- "SnacksIndent6",
        --   -- "SnacksIndent7",
        --   -- "SnacksIndent8",
        -- },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "│",
          underline = false, -- underline the start of the scope
          only_scope = false, -- only show indent guides of the scope
          only_current = false, -- only show indent guides in the current window
          hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        },
        chunk = {
          -- when enabled, scopes will be rendered as chunks, except for the
          -- top-level scope which will be rendered as a scope.
          enabled = false,
          -- only show chunk scopes in the current window
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
          char = {
            corner_top = "┌",
            corner_bottom = "└",
            -- corner_top = "╭",
            -- corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
        -- filter for buffers to enable indent guides
        filter = function(buf)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },

      -- ---@class snacks.explorer.Config
      -- explorer = {
      --   replace_netrw = true,
      -- },

      git = { enabled = true },

      ---@class snacks.input.Config
      input = {
        enabled = true,
        icon = " ",
        icon_hl = "SnacksInputIcon",
        icon_pos = "left",
        prompt_pos = "left",
        expand = true,
        backdrop = true,
      },

      picker = {
        enabled = vim.g.enable_snacks_picker,
        layout = {
          preset = "ivy",
        },
        win = {
          input = {
            keys = {
              ["<C-w>h"] = { "layout_left", mode = { "i", "n" } },
              ["<C-w><c-h>"] = { "layout_left", mode = { "i", "n" } },
              ["<C-w>j"] = { "layout_bottom", mode = { "i", "n" } },
              ["<C-w><c-j>"] = { "layout_bottom", mode = { "i", "n" } },
              ["<C-w>k"] = { "layout_top", mode = { "i", "n" } },
              ["<C-w><c-k>"] = { "layout_top", mode = { "i", "n" } },
              ["<C-w>l"] = { "layout_right", mode = { "i", "n" } },
              ["<C-w><c-l>"] = { "layout_right", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<C-w>h"] = { "layout_left", mode = { "i", "n" } },
              ["<C-w><c-h>"] = { "layout_left", mode = { "i", "n" } },
              ["<C-w>j"] = { "layout_bottom", mode = { "i", "n" } },
              ["<C-w><c-j>"] = { "layout_bottom", mode = { "i", "n" } },
              ["<C-w>k"] = { "layout_top", mode = { "i", "n" } },
              ["<C-w><c-k>"] = { "layout_top", mode = { "i", "n" } },
              ["<C-w>l"] = { "layout_right", mode = { "i", "n" } },
              ["<C-w><c-l>"] = { "layout_right", mode = { "i", "n" } },
            },
          },
        },
      },

      notifier = {
        enabled = true,
        ---@type snacks.notifier.style
        style = "compact",
      },

      debug = { enabled = true },

      scratch = {
        enabled = true,
      },

      profiler = { enabled = true },

      quickfile = { enabled = false },

      scroll = { enabled = true },

      ---@class snacks.statuscolumn.Config
      statuscolumn = {
        enabled = true,
        left = { "mark", "sign" }, -- priority of signs on the left (high to low)
        right = { "fold", "git" }, -- priority of signs on the right (high to low)
        folds = {
          open = false, -- show open fold icons
          git_hl = false, -- use Git Signs hl for fold icons
        },
        git = {
          -- patterns to match Git signs
          patterns = { "GitSign", "MiniDiffSign" },
        },
        refresh = 50, -- refresh at most every 50ms
      },

      words = { enabled = true },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local Keys = require("custom.plugins.lsp.keymaps").get()
      vim.list_extend(Keys, {
        -- stylua: ignore start
        { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'goto [d]efinition', has = 'definition' },
        { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'goto [r]eferences' },
        { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'goto [I]mplementation' },
        { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'goto t[y]pe definition' },
        -- { '<leader>csd', function() Snacks.picker.lsp_symbols() end, desc = '[D]ocument Symbols' },
        { '<leader>scd', function() Snacks.picker.lsp_symbols({ filter = HellVim.config.kind_filter }) end, desc = '[d]ocument symbols',has = 'documentSymbol'  },
        { '<leader>scw', function() Snacks.picker.lsp_workspace_symbols({ filter = HellVim.config.kind_filter }) end, desc = '[w]orkspace symbols',has = 'workspace/symbols'  },
        -- stylua: ignore end
      })
    end,
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>sc", group = "[c]ode" },
        { "<leader>ul", group = "[l]ine numbers" },
        { "<leader>bD", desc = "[D]elete" },
      },
    },
  },
}
