---@class hellvim.util.format
---@overload fun(opts?: {force?:boolean})
local M = setmetatable({}, {
  __call = function(m, ...)
    return m.format(...)
  end,
})

---@class HellFormatter
---@field name string
---@field primary? boolean
---@field format fun(bufnr:number)
---@field sources fun(bufnr:number):string[]
---@field priority number

M.formatters = {} ---@type HellFormatter[]

---@param formatter HellFormatter
function M.register(formatter)
  M.formatters[#M.formatters + 1] = formatter
  table.sort(M.formatters, function(a, b)
    return a.priority > b.priority
  end)
end

---@param buf? number
---@return (HellFormatter|{active:boolean,resolved:string[]})[]
function M.resolve(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local have_primary = false
  ---@param formatter HellFormatter
  return vim.tbl_map(function(formatter)
    local sources = formatter.sources(buf)
    local active = #sources > 0 and (not formatter.primary or not have_primary)
    have_primary = have_primary or (active and formatter.primary) or false
    return setmetatable({
      active = active,
      resolved = sources,
    }, { __index = formatter })
  end, M.formatters)
end

---@param opts? {force?:boolean, buf?:number}
M.should_format_based_on_toggle = function(opts)
  opts = opts or {}
  local buf = opts.buf or vim.api.nvim_get_current_buf()
  if not ((opts and opts.force) or M.enabled(buf)) then
    return false
  end

  if not opts.force then
    if vim.b.autoformat or vim.b[buf].autoformat then
      -- buffer formatting enabled, no need to check global
      return true
    elseif not vim.g.autoformat then
      -- global autoformat is disabled
      return false
    end
  end
  return true
end

---@param opts? {force?:boolean, buf?:number}
function M.format(opts)
  opts = opts or {}

  local buf = opts.buf or vim.api.nvim_get_current_buf()

  if not ((opts and opts.force) or M.enabled(buf) or M.should_format_based_on_toggle(opts)) then
    return
  end

  local done = false
  local buf_formatters = M.resolve(buf)
  for idx, formatter in ipairs(buf_formatters) do
    if formatter.active then
      done = true
      require("fidget").notify(
        " " .. formatter.name .. (#buf_formatters > 1 and string.format(" [%d]", idx) or ""),
        vim.log.levels.INFO,
        { annote = "hellvim:formatter" }
      )

      HellVim.try(function()
        return formatter.format(buf)
      end, { msg = "formatter `" .. formatter.name .. "` failed" })
    end
  end

  if not done and opts and opts.force then
    HellVim.warn("no formatter available", { title = "hellvim:formatter" })
  end
end

function M.formatexpr()
  if HellVim.has("conform.nvim") then
    return require("conform").formatexpr()
  end
  return vim.lsp.formatexpr({ timeout_ms = 3000 })
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

---@param buf? boolean
function M.toggle(buf)
  M.enable(not M.enabled(), buf)
end

---@param enable? boolean
---@param buf? boolean
function M.enable(enable, buf)
  if enable == nil then
    enable = true
  end
  if buf then
    vim.b.autoformat = enable
  else
    vim.g.autoformat = enable
    -- should enable/disable buffer autoformat together with global
    if vim.g.autoformat_reset_buf_with_global then
      for _, bufno in ipairs(vim.api.nvim_list_bufs()) do
        -- nuke all specific buffer settings
        vim.b[bufno].autoformat = nil
      end
      vim.b.autoformat = enable
    else -- should NOT enable/disable buffer autoformat together with global (if manually set)
      vim.b.autoformat = nil
    end
  end
  M.info()
end

---@param buf? number
function M.info(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local gaf = vim.g.autoformat == nil or vim.g.autoformat
  local baf = vim.b[buf].autoformat
  local enabled = M.enabled(buf)
  local lines = {
    "# Status",
    ("- [%s] global **%s**"):format(gaf and "x" or " ", gaf and "enabled" or "disabled"),
    ("- [%s] buffer **%s**"):format(
      enabled and "x" or " ",
      baf == nil and "inherit" or baf and "enabled" or "disabled"
    ),
  }
  local have = false
  for _, formatter in ipairs(M.resolve(buf)) do
    if #formatter.resolved > 0 then
      have = true
      lines[#lines + 1] = "\n# " .. formatter.name .. (formatter.active and " ***(active)***" or "")
      for _, line in ipairs(formatter.resolved) do
        lines[#lines + 1] = ("- [%s] **%s**"):format(formatter.active and "x" or " ", line)
      end
    end
  end
  if not have then
    lines[#lines + 1] = "\n***No formatters available for this buffer.***"
  end
  HellVim[enabled and "info" or "warn"](
    table.concat(lines, "\n"),
    { title = "HellFormat (" .. (enabled and "enabled" or "disabled") .. ")" }
  )
end

function M.setup()
  -- Autoformat autocmd
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("HellFormat", {}),
    callback = function(event)
      M.format({ buf = event.buf })
    end,
  })

  -- Manual format
  vim.api.nvim_create_user_command("HellFormat", function()
    M.format({ force = true })
  end, { desc = "Format selection or buffer" })

  -- Format info
  vim.api.nvim_create_user_command("HellFormatInfo", function()
    M.info()
  end, { desc = "Show info about the formatters for the current buffer" })

  -- keymaps
  HellVim.on_load("snacks.nvim", function()
    M.snacks_toggle():map("<leader>uf")
    M.snacks_toggle():map("<leader>ufg")
    M.snacks_toggle(true):map("<leader>ufb")
  end)
end

---@param buf? boolean
function M.snacks_toggle(buf)
  return Snacks.toggle({
    name = "Auto Format (" .. (buf and "Buffer" or "Global") .. ")",
    get = function()
      if not buf then
        return vim.g.autoformat == nil or vim.g.autoformat
      end
      return HellVim.format.enabled()
    end,
    set = function(state)
      HellVim.format.enable(state, buf)
    end,
  })
end

return M
