local LazyUtil = require("lazy.core.util")

---@class hellvim.util: LazyUtilCore
---@field config HellVimConfig
---@field lsp hellvim.util.lsp
---@field cmp hellvim.util.cmp
---@field plugin hellvim.util.plugin
---@field format hellvim.util.format
---@field root hellvim.util.root
local M = {}

setmetatable(M, {
  __index = function(t, k)
    if LazyUtil[k] then
      return LazyUtil[k]
    end
    -- if k == 'lazygit' or k == 'toggle' then -- HACK: special case for lazygit
    --   return M.deprecated[k]()
    -- end
    ---@diagnostic disable-next-line: no-unknown
    t[k] = require("custom.util." .. k)
    -- M.deprecated.decorate(k, t[k])
    return t[k]
  end,
})

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

---@description Check if a plugin is loaded
---@param name string
function M.is_loaded(name)
  local Config = require("lazy.core.config")
  return Config.plugins[name] and Config.plugins[name]._.loaded
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

return M
