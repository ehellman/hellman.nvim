---@type LazySpec
return {
  "esmuellert/nvim-eslint",
  enabled = true,
  version = false,
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("nvim-eslint").setup({
      settings = {
        experimental = { useFlatConfig = true },

        workingDirectory = { mode = "auto" },
        -- root_dir = function(buf)
        --   -- return vim.fs.root(buf, { 'package.json' })
        --
        --   vim.fs.root(buf, function(name, path)
        --     return name:match("package.json$") ~= nil
        --   end)
        -- end,
      },
    })
  end,
}
