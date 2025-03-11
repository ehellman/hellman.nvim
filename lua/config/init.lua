_G.HellVim = require("custom.util")

---@class HellVimConfig
local M = {}

HellVim.config = M

M.icons = {
  misc = {
    dots = "󰇘",
  },
  ft = {
    octo = "",
  },
  dap = {
    Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
    Breakpoint = " ",
    BreakpointCondition = " ",
    BreakpointRejected = { " ", "DiagnosticError" },
    LogPoint = ".>",
  },
  diagnostics = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
  },
  git = {
    added = " ",
    modified = " ",
    removed = " ",
  },
  kinds = {
    Array = " ",
    Boolean = "󰨙 ",
    Class = " ",
    Codeium = "󰘦 ",
    Color = " ",
    Control = " ",
    Collapsed = " ",
    Constant = "󰏿 ",
    Constructor = " ",
    Copilot = " ",
    Enum = " ",
    EnumMember = " ",
    Event = " ",
    Field = " ",
    File = " ",
    Folder = " ",
    Function = "󰊕 ",
    Interface = " ",
    Key = " ",
    Keyword = " ",
    Method = "󰊕 ",
    Module = " ",
    Namespace = "󰦮 ",
    Null = " ",
    Number = "󰎠 ",
    Object = " ",
    Operator = " ",
    Package = " ",
    Property = " ",
    Reference = " ",
    Snippet = "󱄽 ",
    String = " ",
    Struct = "󰆼 ",
    Supermaven = " ",
    TabNine = "󰏚 ",
    Text = " ",
    TypeParameter = " ",
    Unit = " ",
    Value = " ",
    Variable = "󰀫 ",
  },
}

---@type table<string, string[]|boolean>?
M.kind_filter = {
  default = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    "Package",
    "Property",
    "Struct",
    "Trait",
  },
  markdown = false,
  help = false,
  -- you can specify a different filter for each filetype
  lua = {
    "Class",
    "Constructor",
    "Enum",
    "Field",
    "Function",
    "Interface",
    "Method",
    "Module",
    "Namespace",
    -- "Package", -- remove package since luals uses it for control flow structures
    "Property",
    "Struct",
    "Trait",
  },
}

M.init = function()
  -- autocmds can be loaded lazily when not opening a file
  -- local lazy_autocmds = vim.fn.argc(-1) == 0
  -- if not lazy_autocmds then
  --   M.load('autocmds')
  -- end
  -- local group = vim.api.nvim_create_augroup('HellVim', { clear = true })
  -- if lazy_autocmds then
  --   M.load('autocmds')
  -- end
  -- M.load('keymaps')

  require("config.options")
  require("config.keymaps")
  require("config.autocmds")

  HellVim.format.setup()
  HellVim.root.setup()

  vim.api.nvim_create_user_command("LazyHealth", function()
    vim.cmd([[Lazy! load all]])
    vim.cmd([[checkhealth]])
  end, { desc = "Load all plugins and run :checkhealth" })
  -- vim.api.nvim_create_autocmd('User', {
  --   group = group,
  --   pattern = 'VeryLazy',
  --   callback = function()
  --     -- if lazy_clipboard ~= nil then
  --     --   vim.opt.clipboard = lazy_clipboard
  --     -- end
  --
  --
  --
  --     -- local health = require('lazy.health')
  --     -- vim.list_extend(health.valid, {
  --     --   'recommended',
  --     --   'desc',
  --     --   'vscode',
  --     -- })
  --
  --     -- if vim.g.lazyvim_check_order == false then
  --     --   return
  --     -- end
  --
  --     -- Check lazy.nvim import order
  --     -- local imports = require('lazy.core.config').spec.modules
  --     -- local function find(pat, last)
  --     --   for i = last and #imports or 1, last and 1 or #imports, last and -1 or 1 do
  --     --     if imports[i]:find(pat) then
  --     --       return i
  --     --     end
  --     --   end
  --     -- end
  --     -- local lazyvim_plugins = find('^custom%.plugins$')
  --     -- local lang = find('^custom%.plugins%.lang%.', true) or lazyvim_plugins
  --     -- local plugins = find('^plugins$') or math.huge
  --     -- if lazyvim_plugins ~= 1 or lang > plugins then
  --     --   local msg = {
  --     --     'The order of your `lazy.nvim` imports is incorrect:',
  --     --     '- `lazyvim.plugins` should be first',
  --     --     '- followed by any `lazyvim.plugins.extras`',
  --     --     '- and finally your own `plugins`',
  --     --     '',
  --     --     "If you think you know what you're doing, you can disable this check with:",
  --     --     '```lua',
  --     --     'vim.g.lazyvim_check_order = false',
  --     --     '```',
  --     --   }
  --     --   vim.notify(table.concat(msg, '\n'), 'warn', { title = 'LazyVim' })
  --     -- end
  --   end,
  -- })
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  local function _load(mod)
    if require("lazy.core.cache").find(mod)[1] then
      HellVim.try(function()
        require(mod)
      end, { msg = "Failed loading " .. mod })
    end
  end
  local pattern = "HellVim" .. name:sub(1, 1):upper() .. name:sub(2)
  -- always load lazyvim, then user file
  -- if M.defaults[name] or name == 'options' then
  --   _load('custom.config.' .. name)
  --   vim.api.nvim_exec_autocmds('User', { pattern = pattern .. 'Defaults', modeline = false })
  -- end
  _load("config." .. name)
  if vim.bo.filetype == "lazy" then
    -- HACK: LazyVim may have overwritten options of the Lazy ui, so reset this here
    vim.cmd([[do VimResized]])
  end
  vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

return M
