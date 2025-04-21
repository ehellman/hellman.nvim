local LazyUtil = require("lazy.core.util")

---@class hellvim.util: LazyUtilCore
---@field config HellVimConfig
---@field lsp hellvim.util.lsp
---@field cmp hellvim.util.cmp
---@field plugin hellvim.util.plugin
---@field format hellvim.util.format
---@field lualine hellvim.util.lualine
---@field mini hellvim.util.mini
---@field root hellvim.util.root
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("custom.util." .. k)
    return t[k]
  end,
})

---Checks if the current OS is Linux
function M.is_windows()
  return vim.uv.os_uname().sysname:find("Windows") ~= nil
end

---Checks if the current OS is Linux
function M.is_linux()
  return vim.uv.os_uname().sysname:find("Linux") ~= nil
end

---Checks if the current OS is macOS
function M.is_mac()
  return vim.uv.os_uname().sysname:find("Darwin") ~= nil
end

---Checks if the current OS is WSL (Windows Subsystem for Linux)
function M.is_wsl()
  return os.getenv("WSL_DISTRO_NAME") ~= nil
end

---@description Get the opts for a plugin
---@param name string
function M.opts(name)
  local plugin = M.get_plugin(name)
  if not plugin then
    return {}
  end
  local Plugin = require("lazy.core.plugin")
  return Plugin.values(plugin, "opts", false)
end

---@description Get the lazy spec for a plugin
---@param name string
function M.get_plugin(name)
  return require("lazy.core.config").spec.plugins[name]
end

---@param plugin string
function M.has(plugin)
  return M.get_plugin(plugin) ~= nil
end

---@description Check if a plugin is loaded
---@param name string
function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
end

---@param name string
---@param fn fun(name:string)
function M.on_load(name, fn)
  if M.is_loaded(name) then
    fn(name)
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyLoad",
      callback = function(event)
        if event.data == name then
          fn(name)
          return true
        end
      end,
    })
  end
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      fn()
    end,
  })
end

---@generic T
---@param list T[]
---@return T[]
function M.dedup(list)
  local ret = {}
  local seen = {}
  for _, v in ipairs(list) do
    if not seen[v] then
      table.insert(ret, v)
      seen[v] = true
    end
  end
  return ret
end

---Convert a string or table to a table
---@param str_or_tbl string|string[]
---@return string[]
function M.str_to_tbl(str_or_tbl)
  if type(str_or_tbl) == "string" then
    return { str_or_tbl }
  end
  return str_or_tbl
end

M.CREATE_UNDO = vim.api.nvim_replace_termcodes("<c-G>u", true, true, true)
function M.create_undo()
  if vim.api.nvim_get_mode().mode == "i" then
    vim.api.nvim_feedkeys(M.CREATE_UNDO, "n", false)
  end
end

---@param buf? number
function M.enabled(buf)
  buf = (buf == nil or buf == 0) and vim.api.nvim_get_current_buf() or buf
  local gaf = vim.g.autoformat
  local baf = vim.b[buf].autoformat

  -- If the buffer has a local value, use that
  if baf ~= nil then
    return baf
  end

  -- Otherwise use the global value if set, or true by default
  return gaf == nil or gaf
end

function M.is_tmux_term()
  local term_program = os.getenv("TERM_PROGRAM")
  if term_program ~= "tmux" then
    return false, nil
  end

  local result = vim.system({ "tmux", "display-message", "-p", "#{session_id}" }):wait()

  if result.code ~= 0 then
    return false, nil
  end

  if result.stdout == "" then
    return false, nil
  end

  -- result.stdout will be something like "$2\n"
  -- gsub removes \n
  local session_id = result.stdout:gsub("\n", "")

  print(vim.inspect(session_id))

  return true, session_id
end

function M.is_kitty_terminal()
  local term = os.getenv("TERM")
  local kitty_pid = os.getenv("KITTY_PID")

  local is_kitty = term == "xterm-kitty"
  local is_tmux, tmux_session_id = M.is_tmux_term()
  local is_tmux_inside_kitty = is_tmux and kitty_pid ~= nil
  return term == is_kitty or is_tmux_inside_kitty
end

return M
