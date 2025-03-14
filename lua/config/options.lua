-- See `:help vim.opt`
-- For more options, you can see `:help option-list`

-- [[ Global Variables ]]
---@type {
---  enable_statusline: boolean,
---  enable_snacks_picker: boolean,
---  enable_snacks_animate: boolean,
---  cmp_variant: "blink" | "cmp",
---  other_setting: string,
---}
vim.g = vim.g or {}
vim.g.enable_statusline = true
vim.g.enable_snacks_picker = true
vim.g.enable_snacks_animate = true

vim.g.cmp_variant = "cmp"
-- vim.g.deprecation_warnings = true

-- copilot suggestions in cmp
vim.g.ai_cmp = true

--- autoformat
-- reset specific buffer format toggles together with global toggle
vim.g.autoformat_reset_buf_with_global = false
vim.g.autoformat = true
vim.b.autoformat = true
vim.g.eslint_autoformat = true
-- vim.g.eslint_autofix = true
vim.g.eslint_priority = true -- run eslint formatter before other formatters

-- [[ OS Specific ]]
vim.g.path_separator = HellVim.is_windows() and "\\" or "/"
vim.g.delimiter = HellVim.is_windows() and ";" or ":"

-- [[ Chezmoi ]]
vim.g["chezmoi#use_tmp_buffer"] = 1
-- vim.g["chezmoi#source_dir_path"] = os.getenv("HOME") .. "/.local/share/chezmoi"

local opt = vim.opt

-- [[ Editor Visual Options ]]
-- Basic editor visual configurations for a clean, informative interface
opt.number = true -- Show line numbers
opt.relativenumber = true -- Show relative line numbers for easy jumping
opt.signcolumn = "yes" -- Always show the signcolumn
opt.cursorline = true -- Highlight current line
opt.cursorlineopt = "number"
opt.showmode = false
opt.termguicolors = true -- Enable true color support
opt.wrap = false -- Disable line wrapping

-- Configure whitespace visualization
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- [[ Scrolling and View Options ]]
opt.scrolloff = 20 -- Keep 10 lines visible above/below cursor
opt.sidescrolloff = 8 -- Keep 8 columns visible left/right of cursor
opt.splitright = true -- Open vertical splits to the right
opt.splitbelow = true -- Open horizontal splits below
opt.virtualedit = "block" -- Allow cursor movement in block selection where there's no text

-- [[ Indentation and Formatting ]]
-- Configure tabs, spaces, and auto-indentation behavior
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.shiftwidth = 2 -- Size of indent
vim.o.smartindent = true -- Smart autoindenting
vim.o.tabstop = 2 -- Number of spaces tabs count for
vim.o.softtabstop = 2 -- Number of spaces for soft tabs
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
-- opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.formatoptions = "jcroqlnt" -- Format options (see :help fo-table)
opt.breakindent = true -- Wrapped lines preserve indentation

-- [[ Search and Replace ]]
-- Settings for search behavior and text replacement
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Override ignorecase if search contains capitals
opt.inccommand = "split" -- Live preview of substitutions
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- [[ Completion and Command Line ]]
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.completeopt = "menu,menuone,noselect"
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- [[ Performance and Timing ]]
opt.updatetime = 250 -- Decrease update time
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Key sequence wait time

-- [[ File and Buffer Management ]]
opt.undofile = true -- Save undo history
opt.jumpoptions = "view"

-- [[ Mouse and Clipboard ]]
opt.mouse = "a" -- Enable mouse mode

-- Handle clipboard integration with special consideration for SSH
vim.schedule(function()
  opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)

-- [[ Folding Configuration ]]
-- Comprehensive folding setup using treesitter
vim.opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.foldcolumn = "1"
opt.foldlevel = 99
opt.foldtext = ""
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- [[ Path and Environment Setup ]]
-- Configure path for mason.nvim binaries
vim.env.PATH = table.concat({ vim.fn.stdpath("data"), "mason", "bin" }, vim.g.path_separator)
  .. vim.g.delimiter
  .. vim.env.PATH

-- vim: ts=2 sts=2 sw=2 et
