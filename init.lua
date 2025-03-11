-- unstable?
if vim.loader then
  vim.loader.enable()
end

-- Ensure Neovim version is atleast 0.10
if vim.fn.has("nvim-0.10") == 0 then
  vim.api.nvim_echo({
    { "Configuration requires Neovim >= 0.10.0\n", "ErrorMsg" },
    { "Press any key to exit", "MoreMsg" },
  }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

vim.uv = vim.uv or vim.loop

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- require('options')

-- [[ Basic Keymaps ]]
-- require('keymaps')

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

require("config").init() -- loads HellVim global

HellVim.plugin.register_lazy_file_event()

-- require('config.autocmds')

-- [[ Configure and install plugins ]]
require("lazy-plugins").load({
  profiling = {
    loader = true,
    require = true,
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
