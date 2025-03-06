---@type LazySpec
return {
  "esmuellert/nvim-eslint",
  enabled = true,
  ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  config = function()
    require("nvim-eslint").setup({
      settings = {
        experimental = { useFlatConfig = true },
      },
    })
  end,
}
