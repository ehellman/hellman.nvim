local all = { brackets = { "%b()", "%b{}", "%b[]" } }
local paren = { brackets = { "%b()" } }
local curly = { brackets = { "%b{}" } }
local square = { brackets = { "%b[]" } }

---@module 'lazy'
---@type LazySpec
return {
  {
    ---@module 'mini.splitjoin'
    "echasnovski/mini.splitjoin",
    version = false,
    -- dependencies = {},
    -- opts = function()
    --   local _opts = {
    --     mappings = {
    --       toggle = "gS",
    --     },
    --   }
    --   return _opts
    -- end,
    config = function(_, opts)
      opts = opts or {}
      local splitjoin = require("mini.splitjoin")
      local h = {
        add_commas = splitjoin.gen_hook.add_trailing_separator(all),
        add_comma_paren = splitjoin.gen_hook.add_trailing_separator(paren),
        add_comma_curly = splitjoin.gen_hook.add_trailing_separator(curly),
        add_comma_square = splitjoin.gen_hook.add_trailing_separator(square),
        del_commas = splitjoin.gen_hook.del_trailing_separator(all),
        del_comma_paren = splitjoin.gen_hook.del_trailing_separator(paren),
        del_comma_curly = splitjoin.gen_hook.del_trailing_separator(curly),
        del_comma_square = splitjoin.gen_hook.del_trailing_separator(square),
        pad_paren = splitjoin.gen_hook.pad_brackets(paren),
        pad_curly = splitjoin.gen_hook.pad_brackets(curly),
        pad_square = splitjoin.gen_hook.pad_brackets(square),
      }

      opts.split = {
        hooks_post = { h.add_commas },
      }
      opts.join = {
        hooks_post = { h.del_commas, h.pad_curly },
      }

      require("mini.splitjoin").setup(opts)
    end,
    ---@type PluginKeySpec
    keys = {
      -- stylua: ignore start
      { "gS", function() require('mini.splitjoin').toggle() end, desc = "[S]plit/join toggle" },
      -- stylua: ignore end
    },
  },
}
