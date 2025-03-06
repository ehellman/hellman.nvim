---@type LazySpec
return {
  "echasnovski/mini.surround",
  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  -- event = { 'CursorHold', 'CursorHoldI' },
  -- event = 'VeryLazy',
  -- event = {
  --   'BufReadPost',
  --   'BufNewFile',
  --   'BufWritePre',
  -- },
  keys = function(_, keys)
    -- Populate the keys based on the user's options
    local opts = HellVim.opts("mini.surround")
    local mappings = {
      { opts.mappings.add, desc = "[a]dd surrounding", mode = { "n", "v" } },
      { opts.mappings.delete, desc = "[d]elete surrounding" },
      { opts.mappings.find, desc = "[f]ind (right) surrounding" },
      { opts.mappings.find_left, desc = "[F]ind (left) surrounding" },
      { opts.mappings.highlight, desc = "[h]ighlight surrounding" },
      { opts.mappings.replace, desc = "[r]eplace Surrounding" },
      { opts.mappings.update_n_lines, desc = "[u]pdate `MiniSurround.config.n_lines`" },
    }
    mappings = vim.tbl_filter(function(m)
      return m[1] and #m[1] > 0
    end, mappings)
    return vim.list_extend(mappings, keys)
  end,
  opts = {
    mappings = {
      add = "gza", -- Add surrounding in Normal and Visual modes
      delete = "gzd", -- Delete surrounding
      find = "gzf", -- Find surrounding (to the {}right)
      find_left = "gzF", -- Find surrounding (to the left)
      highlight = "gzh", -- Highlight surrounding
      replace = "gzr", -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`
    },
  },
  -- keys = {
  --   { 'gz', '', desc = '+surround' },
  -- },
}
