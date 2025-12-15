---@class hellvim.util.lsp
local M = {}

function M.hover()
  local max_width = math.floor(vim.o.columns * 0.5)
  local max_height = math.floor(vim.o.lines * 0.3)

  local params = vim.lsp.util.make_position_params()

  vim.lsp.buf_request(0, vim.lsp.protocol.Methods.textDocument_hover, params, function(_, result, ctx, config)
    if result and result.contents then
      -- Customize floating window options
      local opts = {
        border = "rounded",
        max_width = max_width,
        max_height = max_height,
      }

      vim.lsp.handlers.hover(_, result, ctx, opts)
    end
  end)
end

---@param opts? HellFormatter| {filter?: (string|vim.lsp.get_clients.Filter)}
function M.formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == "string" and { name = filter } or filter
  ---@cast filter vim.lsp.get_clients.Filter
  ---@type HellFormatter
  local ret = {
    name = "LSP",
    primary = true,
    priority = 1,
    format = function(buf)
      M.format(HellVim.merge({}, filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = vim.lsp.get_clients(HellVim.merge({}, filter, { bufnr = buf }))
      ---@param client vim.lsp.Client
      local ret = vim.tbl_filter(function(client)
        return client:supports_method("textDocument/formatting")
          or client:supports_method("textDocument/rangeFormatting")
      end, clients)
      ---@param client vim.lsp.Client
      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return HellVim.merge(ret, opts) --[[@as HellFormatter]]
end

---@return _.lspconfig.options
function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

---@return {default_config:lspconfig.Config}
function M.get_raw_config(server)
  local ok, ret = pcall(require, "lspconfig.configs." .. server)
  if ok then
    return ret
  end
  return require("lspconfig.server_configurations." .. server)
end

function M.is_enabled(server)
  local c = M.get_config(server)
  return c and c.enabled ~= false
end

---@alias lsp.Client.format {timeout_ms?: number, format_options?: table} | vim.lsp.get_clients.Filter

---@param opts? lsp.Client.format
function M.format(opts)
  opts = vim.tbl_deep_extend(
    "force",
    {},
    opts or {},
    HellVim.opts("nvim-lspconfig").format or {},
    HellVim.opts("conform.nvim").format or {}
  )
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

---@param server string
---@param cond fun(root_dir, config): boolean
function M.disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.get_config(server)
  ---@diagnostic disable-next-line: undefined-field
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

M.action = setmetatable({}, {
  __index = function(_, action)
    return function()
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end
  end,
})

---@class LspCommand: lsp.ExecuteCommandParams
---@field open? boolean
---@field handler? lsp.Handler

---@param opts LspCommand
function M.execute(opts)
  local params = {
    command = opts.command,
    arguments = opts.arguments,
  }
  if opts.open then
    require("trouble").open({
      mode = "lsp_command",
      params = params,
    })
  else
    return vim.lsp.buf_request(0, "workspace/executeCommand", params, opts.handler)
  end
end

function M.restart_all()
  HellVim.info("Restarting all LSP servers", { title = "hellvim.lsp" })
  vim.cmd("LspRestart")
end

function M.stop_all()
  HellVim.info("Stopping all LSP servers", { title = "hellvim.lsp" })
  vim.cmd("LspStop")
end

function M.start_all()
  HellVim.info("Starting LSP servers", { title = "hellvim.lsp" })
  vim.cmd("LspStart")
end

return M
