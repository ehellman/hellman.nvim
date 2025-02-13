---@module 'snacks'

local picker = {
  name = 'snacks',
  commands = {
    files = 'files',
    live_grep = 'grep',
    oldfiles = 'recent',
  },

  ---@param source string
  ---@param opts? snacks.picker.Config
  open = function(source, opts)
    return Snacks.picker.pick(source, opts)
  end,
}

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    --stylua: ignore
    { '<leader>bd',function() Snacks.bufdelete.delete() end, desc = '[d]elete current buffer' },
    --stylua: ignore
    {'<leader>bD', function() Snacks.bufdelete.all() end, desc = '[D]elete all buffers' },
    --stylua: ignore
    { '<leader>bo', function() Snacks.bufdelete.other() end, desc = 'Delete [o]ther buffers' },
    -- Lazygit
    -- {"<leader>gg", function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end,  desc = "Lazygit (Root Dir)" },
    --stylua: ignore
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazy[g]it (Root Dir)' },
    --stylua: ignore
    { '<leader>gL', function() Snacks.picker.git_log_file() end, desc = 'Git [L]og Current File' },
    -- {"<leader>gl", function() Snacks.picker.git_log( LazyVim.root.git()  end, desc = "Git Log" }),
    --stylua: ignore
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git [l]og (root)' },
    --stylua: ignore
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git [d]iff' },
    --stylua: ignore
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git [s]tatus' },
    --stylua: ignore
    { '<leader>gS', function() Snacks.picker.git_stash() end, desc = 'Git [S]tash' },
    --stylua: ignore
    { '<leader>gb', function() Snacks.picker.git_branches() end, desc = 'Git [B]lame Line' },
    --stylua: ignore
    { '<leader>gB', function() Snacks.git.blame_line() end, desc = 'Git [B]lame Line' },
    unpack(vim.g.enable_snacks_picker and {
      --- Search // Files
      --stylua: ignore
      { '<leader>sf', function() picker.open('files') end, desc = 'Search [f]iles' },
      --- Search // Files
      --stylua: ignore
      { '<leader>sF', function() picker.open('files', { root = false }) end, desc = 'Search [F]iles (cwd)' },
      --- Search // Recent
      --stylua: ignore
      { '<leader>sr', function() picker.open('recent') end, desc = 'Search [r]ecent' },
      --- Search // Registers
      --stylua: ignore
      { '<leader>sR', function() Snacks.picker.registers() end, desc = 'Search [R]egisters' },
      -- Search // Grep
      --stylua: ignore
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[g]rep root dir' },
      -- Search // Jumps
      --stylua: ignore
      { '<leader>sj', function() Snacks.picker.jumps() end, desc = 'Search [j]umps' },
      --stylua: ignore
      { '<leader>sb', function() Snacks.picker.buffers() end, desc = 'Search [b]uffers' },
      -- Picker for undo actions
      --stylua: ignore
      { '<leader>su', function() Snacks.picker.undo() end, desc = '[U]ndo tree' },
    } or {}),
  },
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
        if vim.fn.exists(':NoMatchParen') ~= 0 then
          vim.cmd([[NoMatchParen]])
        end
        Snacks.util.wo(0, { foldmethod = 'manual', statuscolumn = '', conceallevel = 0 })
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
      char = '│',
      only_scope = false, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
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
        char = '│',
        underline = false, -- underline the start of the scope
        only_scope = false, -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = false,
        priority = 200,
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = '┌',
          corner_bottom = '└',
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = '─',
          vertical = '│',
          arrow = '>',
        },
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
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
      icon = ' ',
      icon_hl = 'SnacksInputIcon',
      icon_pos = 'left',
      prompt_pos = 'left',
      -- win does not work?
      -- win = { style = '', zindex  },
      expand = true,
    },

    picker = {
      enabled = vim.g.enable_snacks_picker,
      layout = {
        preset = 'ivy',
      },
      win = {
        -- input = {
        --   keys = {
        --     ['<a-z>h'] = { 'layout_left', mode = { 'i', 'n' } },
        --     ['<a-z><c-h>'] = { 'layout_left', mode = { 'i', 'n' } },
        --     ['<a-z>j'] = { 'layout_bottom', mode = { 'i', 'n' } },
        --     ['<a-z><c-j>'] = { 'layout_bottom', mode = { 'i', 'n' } },
        --     ['<a-z>k'] = { 'layout_top', mode = { 'i', 'n' } },
        --     ['<a-z><c-k>'] = { 'layout_top', mode = { 'i', 'n' } },
        --     ['<a-z>l'] = { 'layout_right', mode = { 'i', 'n' } },
        --     ['<a-z><c-l>'] = { 'layout_right', mode = { 'i', 'n' } },
        --   },
        -- },
        -- list = {
        --   keys = {
        --     ['<a-z>h'] = { 'layout_left', mode = { 'i', 'n' } },
        --     ['<a-z><c-h>'] = { 'layout_left', mode = { 'i', 'n' } },
        --     ['<a-z>j'] = { 'layout_bottom', mode = { 'i', 'n' } },
        --     ['<a-z><c-j>'] = { 'layout_bottom', mode = { 'i', 'n' } },
        --     ['<a-z>k'] = { 'layout_top', mode = { 'i', 'n' } },
        --     ['<a-z><c-k>'] = { 'layout_top', mode = { 'i', 'n' } },
        --     ['<a-z>l'] = { 'layout_right', mode = { 'i', 'n' } },
        --     ['<a-z><c-l>'] = { 'layout_right', mode = { 'i', 'n' } },
        --   },
        -- },
      },
    },

    notifier = { enabled = true },

    quickfile = { enabled = false },

    scroll = { enabled = true },

    ---@class snacks.statuscolumn.Config
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms
    },

    words = { enabled = true },
  },
}
