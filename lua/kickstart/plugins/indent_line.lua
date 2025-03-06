return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    enabled = false,
    main = 'ibl',
    opts = {
      enabled = false,
      indent = {
        char = '┊',
        -- highlight = {
        --   'RainbowRed',
        --   'RainbowYellow',
        --   'RainbowBlue',
        --   'RainbowOrange',
        --   'RainbowGreen',
        --   'RainbowViolet',
        --   'RainbowCyan',
        -- },
      },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end,
  },
}
