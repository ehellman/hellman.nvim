---@module 'lazy'
---@type LazySpec
return {
  {
    ---@module 'todo-comments'
    "folke/todo-comments.nvim",
    event = "LazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@type TodoOptions
    opts = { signs = false },
    ---@type LazyKeysSpec[]
    keys = {
      -- stylua: ignore start
      ---@diagnostic disable: undefined-field
      { "<leader>sCt", function() Snacks.picker.todo_comments() end, desc = "[t]odo comments" },
      { "<leader>sCT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "all [T]odo type comments" },
      { "<leader>sCn", function () Snacks.picker.todo_comments({ keywords = { "NOTE" } }) end, desc = "[n]ote comments" },
      ---@diagnostic enable: undefined-field
      { "]t", function() require("todo-comments").jump_next() end, desc = "next todo comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "prev todo comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
      -- stylua: ignore end
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>sC", group = "[C]omments" },
      },
    },
  },
}
