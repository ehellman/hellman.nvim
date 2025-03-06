---@type LazySpec
return {
  {
    --TODO: testing testing
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    -- event = 'VeryLazy',
    event = "LazyFile",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
    keys = {
      -- stylua: ignore start
      { "<leader>sct", function() Snacks.picker.todo_comments() end, desc = "[t]odo comments" },
      { "<leader>scT", function () Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "[T]odo/fix/fixme comments" },
      -- stylua: ignore end
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>sc", group = "[c]omments" },
      },
    },
  },
}
