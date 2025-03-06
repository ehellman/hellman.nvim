-- local Plugin = require('lazy.core.plugin')

---@class hellvim.util.plugin
local M = {}

M.lazy_file_events = { 'BufReadPost', 'BufNewFile', 'BufWritePre' }

M.setup = function()
  M.register_lazy_file_event()
end

function M.register_lazy_file_event()
  -- Add support for the LazyFile event
  local Event = require('lazy.core.handler.event')

  Event.mappings.LazyFile = { id = 'LazyFile', event = M.lazy_file_events }
  Event.mappings['User LazyFile'] = Event.mappings.LazyFile
end

return M
