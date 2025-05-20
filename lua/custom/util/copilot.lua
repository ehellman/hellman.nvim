---@class hellvim.util.copilot
local M = {}

---@return vim.lsp.Client|nil
function M.get_copilot_client()
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client.name == "copilot" then
      return client
    end
  end
  return nil
end

function M.request()
  local copilot_client = M.get_copilot_client()

  if copilot_client ~= nil then
    require("blink.cmp")["hide"]()
    print("Requesting nes")
    require("copilot-lsp.nes").request_nes(copilot_client)
  else
    print("Copilot LSP client not found.")
  end
end

return M
