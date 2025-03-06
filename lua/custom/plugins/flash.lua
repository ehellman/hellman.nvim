-- match = "FlashMatch",
-- current = "FlashCurrent",
-- backdrop = "FlashBackdrop",
-- label = "FlashLabel",
---@module 'lazy'
---@type LazyPluginSpec
return {
  "folke/flash.nvim",
  -- specs = {
  --   {
  --     'folke/snacks.nvim',
  --     picker = {
  --       win = {
  --         input = {
  --           keys = {
  --             ['<a-s>'] = { 'flash', mode = { 'n', 'i' } },
  --             ['s'] = { 'flash' },
  --           },
  --         },
  --       },
  --       actions = {
  --         flash = function(picker)
  --           require('flash').jump({
  --             pattern = '^',
  --             label = { after = { 0, 0 } },
  --             search = {
  --               mode = 'search',
  --               exclude = {
  --                 function(win)
  --                   return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'snacks_picker_list'
  --                 end,
  --               },
  --             },
  --             action = function(match)
  --               local idx = picker.list:row2idx(match.pos[1])
  --               picker.list:_move(idx, true, true)
  --             end,
  --           })
  --         end,
  --       },
  --     },
  --   },
  -- },
  ---@type Flash.Config
  opts = {
    highlight = {
      -- Change the label highlight group to your desired color
      -- groups = {
      --   label = 'FlashTreesitterSelection',
      -- },
    },
    label = {
      -- allow uppercase labels
      -- uppercase = false,
      uppercase = true,
    },

    modes = {
      -- options used when flash is activated through
      -- `f`, `F`, `t`, `T`, `;` and `,` motions
      char = {
        -- -- hide after jump when not using jump labels
        -- autohide = false,
        -- jump_labels = true,
      },
    },

    labels = "asdfghjklqwertyuiopzxcvbnm",
    ---@type Flash.Pattern.Mode
    -- Each mode will take ignorecase and smartcase into account.
    -- * exact: exact match
    -- * search: regular search
    -- * fuzzy: fuzzy search
    -- * fun(str): custom function that returns a pattern
    --   For example, to only match at the beginning of a word:
    --   mode = function(str)
    --     return "\\<" .. str
    --   end,
    mode = "exact",
    -- behave like `incsearch`
    incremental = false,
  },
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Fla[s]h" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "[r]emote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    -- Searching loads flash lazily
    "/",
    "?",
  },
}
