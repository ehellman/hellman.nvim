return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  -- init = function()
  --   vim.api.nvim_create_autocmd('BufEnter', {
  --     pattern = '*',
  --     callback = function()
  --       vim.notify(vim.opt.number, 'info')
  --       -- Ensure line numbers are enabled
  --       -- vim.wo.number = true
  --     end,
  --   })
  -- end,
  opts = {
    menu = {
      -- width = vim.api.nvim_win_get_width(0) - 4,
      width = 80,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  config = function(_, opts)
    local harpoon = require('harpoon')
    harpoon.setup(opts)
    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = '*',
      callback = function()
        local line_number_enabled = vim.wo.number -- Get the current line number setting
        vim.notify('Line numbers: ' .. tostring(line_number_enabled), vim.log.levels.INFO)
        -- Ensure line numbers are enabled
        -- vim.wo.number = true
      end,
    })
  end,
  keys = function()
    local harpoon = require('harpoon')

    local keys = {
      {
        '<leader>ha',
        function()
          vim.notify('Harpooned', 'info')
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
