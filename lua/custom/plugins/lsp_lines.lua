---@type LazySpec
return {
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'LspAttach',
  enabled = false,
  -- event = { "BufReadPre", "BufNewFile" },
  -- event = "BufReadPost",
  config = function()
    require('lsp_lines').setup()
  end,
}
