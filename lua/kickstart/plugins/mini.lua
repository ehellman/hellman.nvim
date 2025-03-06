-- register all text objects with which-key
---@param opts table
local function ai_whichkey(opts)
  local objects = {
    { " ", desc = "whitespace (m.ai)" },
    { '"', desc = '" string (m.ai)' },
    { "'", desc = "' string (m.ai)" },
    { "(", desc = "() block (m.ai)" },
    { ")", desc = "() block with ws (m.ai)" },
    { "<", desc = "<> block (m.ai)" },
    { ">", desc = "<> block with ws (m.ai)" },
    { "?", desc = "user prompt (m.ai)" },
    { "U", desc = "use/call without dot (m.ai)" },
    { "[", desc = "[] block (m.ai)" },
    { "]", desc = "[] block with ws (m.ai)" },
    { "_", desc = "underscore (m.ai)" },
    { "`", desc = "` string (m.ai)" },
    { "a", desc = "argument (m.ai)" },
    { "b", desc = " (m.ai)]} block" },
    { "c", desc = "class (m.ai)" },
    { "d", desc = "digit(s) (m.ai)" },
    { "e", desc = "CamelCase / snake_case (m.ai)" },
    { "f", desc = "function (m.ai)" },
    { "g", desc = "entire file (m.ai)" },
    { "i", desc = "indent (m.ai)" },
    { "o", desc = "block, conditional, loop (m.ai)" },
    { "q", desc = "quote `\"' (m.ai)" },
    { "t", desc = "tag (m.ai)" },
    { "u", desc = "use/call (m.ai)" },
    { "{", desc = "{} block (m.ai)" },
    { "}", desc = "{} with ws (m.ai)" },
  }

  ---@type wk.Spec[]
  local ret = { mode = { "o", "x" } }
  ---@type table<string, string>
  local mappings = vim.tbl_extend("force", {}, {
    around = "a",
    inside = "i",
    around_next = "an",
    inside_next = "in",
    around_last = "al",
    inside_last = "il",
  }, opts.mappings or {})
  mappings.goto_left = nil
  mappings.goto_right = nil

  for name, prefix in pairs(mappings) do
    name = name:gsub("^around_", ""):gsub("^inside_", "")
    ret[#ret + 1] = { prefix, group = name }
    for _, obj in ipairs(objects) do
      local desc = obj.desc
      if prefix:sub(1, 1) == "i" then
        desc = desc:gsub(" with ws", "")
      end
      ret[#ret + 1] = { prefix .. obj[1], desc = obj.desc }
    end
  end
  require("which-key").add(ret, { notify = false })
end

-- taken from MiniExtra.gen_ai_spec.buffer
local function ai_buffer(ai_type)
  local start_line, end_line = 1, vim.fn.line("$")
  if ai_type == "i" then
    -- Skip first and last blank lines for `i` textobject
    local first_nonblank, last_nonblank = vim.fn.nextnonblank(start_line), vim.fn.prevnonblank(end_line)
    -- Do nothing for buffer with all blanks
    if first_nonblank == 0 or last_nonblank == 0 then
      return { from = { line = start_line, col = 1 } }
    end
    start_line, end_line = first_nonblank, last_nonblank
  end

  local to_col = math.max(vim.fn.getline(end_line):len(), 1)
  return { from = { line = start_line, col = 1 }, to = { line = end_line, col = to_col } }
end

---@module 'lazy'
return {
  { -- Collection of various small independent plugins/modules
    "echasnovski/mini.ai",
    event = {
      "BufReadPost",
      "BufNewFile",
      "BufWritePre",
    },
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ -- code block
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
          d = { "%f[%d]%d+" }, -- digits
          e = { -- Word with case
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          g = ai_buffer, -- buffer
          u = ai.gen_spec.function_call(), -- u for "Usage"
          U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
        },
      }
    end,
    config = function(_, opts)
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require("mini.ai").setup(opts)
      ai_whichkey(opts)

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require('mini.statusline')
      -- set use_icons to true if you have a Nerd Font
      -- statusline.setup({ use_icons = vim.g.have_nerd_font })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      -- return '%2l:%-2v'
      -- end

      -- Animated indentation indicator for scopes
      --
      -- require('mini.indentscope').setup({
      --   symbol = '│',
      --   options = {
      --     try_as_border = true,
      --   },
      -- })

      -- Disable mini.indentscope in specific contexts
      -- vim.api.nvim_create_autocmd('FileType', {
      --   pattern = { 'help', 'alpha', 'dashboard', 'NvimTree', 'Trouble', 'lazy', 'mason' },
      --   callback = function()
      --     vim.b.miniindentscope_disable = true
      --   end,
      -- })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
