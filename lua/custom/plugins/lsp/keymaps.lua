local M = {}

---@type LazyKeysLspSpec[]|nil
M._keys = nil

---@alias LazyKeysLspSpec LazyKeysSpec|{has?:string|string[], cond?:fun():boolean}
---@alias LazyKeysLsp LazyKeys|{has?:string|string[], cond?:fun():boolean}

---@return LazyKeysLspSpec[]
function M.get()
  if M._keys then
    return M._keys
  end
  M._keys = {
    -- stylua: ignore start
    { "<leader>cli", function() Snacks.picker.lsp_config() end, desc = "[i]nfo" },
    { "<leader>clr", HellVim.lsp.restart_all, desc = "[r]estart" },
    { "<leader>clt", HellVim.lsp.stop_all, desc = "s[t]op" },
    { "<leader>cls", HellVim.lsp.start_all, desc = "[s]tart" },
    { "<leader>cll", function() vim.cmd("LspLog") end, desc = "[l]og" },
    { "gd", vim.lsp.buf.definition, desc = "goto [D]efinition", has = "definition" },
    { "gr", vim.lsp.buf.references, desc = "goto [R]eferences", nowait = true },
    { "gI", vim.lsp.buf.implementation, desc = "goto [I]mplementation" },
    { "gy", vim.lsp.buf.type_definition, desc = "t[y]pe Definition" },
    { "gD", vim.lsp.buf.declaration, desc = "goto [D]eclaration" },
    { "K", HellVim.lsp.hover, desc = "Hover" },
    -- { "K", vim.lsp.buf.hover, desc = "Hover" },
    { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
    { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
    { "<leader>ca", vim.lsp.buf.code_action, desc = "Code [a]ction", mode = { "n", "v" }, has = "codeAction" },
    { "<leader>cc", vim.lsp.codelens.run, desc = "run [c]odelens", mode = { "n", "v" }, has = "codeLens" },
    { "<leader>cC", vim.lsp.codelens.refresh, desc = "refresh & display [C]odelens", mode = { "n" }, has = "codeLens" },
    { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "[R]ename file", mode ={"n"}, has = { "workspace/didRenameFiles", "workspace/willRenameFiles" } },
    { "<leader>cr", vim.lsp.buf.rename, desc = "[r]ename", has = "rename" },
    { "<leader>cA", HellVim.lsp.action.source, desc = "source [A]ction", has = "codeAction" },
    { "]]", function() Snacks.words.jump(vim.v.count1) end, has = "documentHighlight",
    desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, has = "documentHighlight",
    desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
    { "<a-n>", function() Snacks.words.jump(vim.v.count1, true) end, has = "documentHighlight",
    desc = "Next Reference", cond = function() return Snacks.words.is_enabled() end },
    { "<a-p>", function() Snacks.words.jump(-vim.v.count1, true) end, has = "documentHighlight",
    desc = "Prev Reference", cond = function() return Snacks.words.is_enabled() end },
    -- stylua: ignore end
  }

  if vim.lsp.inlay_hint then
    -- toggle inlay hints
    Snacks.toggle.inlay_hints():map("<leader>uh")
  end

  return M._keys
end

---@param method string|string[]
function M.has(buffer, method)
  if type(method) == "table" then
    for _, m in ipairs(method) do
      if M.has(buffer, m) then
        return true
      end
    end
    return false
  end
  method = method:find("/") and method or "textDocument/" .. method
  local clients = HellVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    if client.supports_method(method) then
      return true
    end
  end
  return false
end

---@return LazyKeysLsp[]
function M.resolve(buffer)
  local Keys = require("lazy.core.handler.keys")
  if not Keys.resolve then
    return {}
  end
  local spec = vim.tbl_extend("force", {}, M.get())
  local opts = HellVim.opts("nvim-lspconfig")
  local clients = HellVim.lsp.get_clients({ bufnr = buffer })
  for _, client in ipairs(clients) do
    local maps = opts.servers[client.name] and opts.servers[client.name].keys or {}
    vim.list_extend(spec, maps)
  end
  return Keys.resolve(spec)
end

function M.on_attach(_, buffer)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = M.resolve(buffer)

  for _, keys in pairs(keymaps) do
    local has = not keys.has or M.has(buffer, keys.has)
    local cond = not (keys.cond == false or ((type(keys.cond) == "function") and not keys.cond()))

    if has and cond then
      local opts = Keys.opts(keys)
      opts.cond = nil
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(keys.mode or "n", keys.lhs, keys.rhs, opts)
    end
  end
end

return M
