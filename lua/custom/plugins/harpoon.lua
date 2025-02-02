return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('harpoon'):setup()
  end,
  keys = function()
    local harpoon = require 'harpoon'

    local keys = {
      {
        '<leader>ha',
        function()
          harpoon:list():add()
        end,
        desc = 'Add file to [H]arpoon',
      },
      {
        '<leader>hh',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Show [H]arpoon list',
      },
      {
        '<leader>hj',
        function()
          harpoon:list():next()
        end,
        desc = 'Jump to [n]ext file',
      },
      {
        '<leader>hk',
        function()
          harpoon:list():prev()
        end,
        desc = 'Jump to [p]revious file',
      },
    }
    for i = 1, 5 do
      table.insert(keys, {
        string.format('<leader>%d', i),
        function()
          harpoon:list():select(i)
        end,
        desc = string.format('Jump to Harpooned file [%d]', i),
      })
    end
    return keys
  end,
}
