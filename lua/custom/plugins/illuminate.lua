---@type LazySpec
return {
  'RRethy/vim-illuminate',
  enabled = false,
  event = {
    'BufReadPost',
    'BufNewFile',
    'BufWritePre',
  },
  -- event = 'VeryLazy',
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
        'regex',
      },
      delay = 120,
      filetypes_denylist = {
        'markdown',
        'gitcommit',
        'dirvish',
        'fugitive',
        'alpha',
        'NvimTree',
        'packer',
        'manson',
        'neogitstatus',
        'Trouble',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'DressingSelect',
        'TelescopePrompt',
        'sagacodeaction',
        'dapui_console',
        'dapui_watches',
        'dapui_stacks',
        'dapui_breakpoints',
        'dapui_scopes',
        'lspsagafinder',
        'JABSwindow',
        'lspsagaoutline',
        'lazy',
        'help',
        'DressingInput',
        '',
      },
      filetypes_allowlist = {},
      modes_denylist = { 'v', 'i' },
      modes_allowlist = {},
      providers_regex_syntax_denylist = {},
      providers_regex_syntax_allowlist = {},
      under_cursor = true,
    })
  end,
}
