---@alias PluginKeySpec string|string[]|LazyKeysSpec[]|fun(self:LazyPlugin, keys:string[]):((string|LazyKeys)[])

---@module 'lazy'
---@type LazySpec
return {
  {
    ---@module 'todo-comments'
    "package/name",
    dependencies = {},
    opts = { signs = false },
    ---@type PluginKeySpec
    keys = {
      -- stylua: ignore start
      { "<leader>keybinding", function() vim.notify("test", vim.log.levels.INFO, { title = "Test title" }) end, desc = "keybinding description" },
      -- stylua: ignore end
    },
  },
}
