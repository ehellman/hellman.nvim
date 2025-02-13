return {
  {
    'alker0/chezmoi.vim',
    lazy = false,
    event = { 'BufReadPre', 'BufNewFile', 'BufWritePre' },
    init = function()
      vim.g['chezmoi#use_tmp_buffer'] = 1
      vim.g['chezmoi#source_dir_path'] = os.getenv('CHEZMOI_SOURCE_DIR')
      -- vim.g['chezmoi#source_dir_path'] = os.getenv('HOME') .. '/.local/share/chezmoi'
    end,
  },
  -- {
  --   'xvzc/chezmoi.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   config = function()
  --     require('chezmoi').setup({
  --       edit = {
  --         watch = true,
  --         force = false,
  --       },
  --       notification = {
  --         on_open = true,
  --         on_apply = true,
  --         on_watch = true,
  --       },
  --       telescope = {
  --         select = { '<CR>' },
  --       },
  --     })
  --   end,
  -- },
}
