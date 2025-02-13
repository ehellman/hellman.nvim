return {

  {
    'vuki656/package-info.nvim',
    event = 'BufReadPost package.json',
    config = function()
      require('package-info').setup()

      local c = require('package-info/utils/constants')
      vim.api.nvim_create_autocmd('User', {
        group = c.AUTOGROUP,
        pattern = c.LOAD_EVENT,
        callback = function()
          -- execute a groupless autocmd so heirline can update
          vim.cmd.doautocmd('User', 'DkoPackageInfoStatusUpdate')
        end,
      })
    end,
  },
}
