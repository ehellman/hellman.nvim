-- :help lua-guide-autocommands

local function augroup(name)
  return vim.api.nvim_create_augroup("hellvim_" .. name, { clear = true })
end

-- disable kitty spacing
if HellVim.is_kitty_terminal() then
  -- vim.notify("inside kitty term, trimming padding", vim.log.levels.DEBUG, { title = "autocmds:kitty" })
  vim.cmd("silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0")
  vim.opt.termguicolors = true
  vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
    pattern = { "*" },
    command = "silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=default",
  })
end

if HellVim.is_kitty_terminal() then
  vim.api.nvim_create_user_command("KittyPaddingOff", function()
    vim.cmd("silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=0")
    vim.notify("Kitty padding disabled", vim.log.levels.INFO, { title = "Kitty" })
  end, { desc = "Disable Kitty terminal padding" })

  vim.api.nvim_create_user_command("KittyPaddingOn", function()
    vim.cmd("silent !kitty @ --to=$KITTY_LISTEN_ON set-spacing padding=default")
    vim.notify("Kitty padding enabled", vim.log.levels.INFO, { title = "Kitty" })
  end, { desc = "Enable Kitty terminal padding" })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- vim.api.nvim_create_autocmd({ "VimResized" }, {
--   group = augroup("resize_lsp_hover"),
--   callback = function()
--     if HellVim.is_loaded("noice.nvim") then
--       require("noice").setup(vim.tbl_extend("force", {
--
--         lsp = {
--           hover = {
--             ---@type NoiceViewOptions
--             opts = {
--               size = {
--                 width = math.floor(vim.o.columns * 0.5),
--                 height = math.floor(vim.o.lines * 0.5),
--               },
--             },
--           },
--         },
--       }, HellVim.opts("noice.nvim")))
--     end
--   end,
-- })

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("man_unlisted", { clear = true }),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("wrap_spell", { clear = true }),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("json_conceal", { clear = true }),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("last_loc", { clear = true }),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].hellvim_last_loc then
      return
    end
    vim.b[buf].hellvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- increase timeoutlen when recording macros
-- TODO: this needs testing
vim.api.nvim_create_autocmd("RecordingEnter", {
  group = augroup("increase_macro_timeout"),
  callback = function()
    vim.notify("Recording macro!!")
    vim.g.original_timeoutlen = vim.opt.timeoutlen
    vim.opt.timeoutlen = 3000
    print("Recording macro, timeoutlen set to " .. vim.inspect(vim.opt.timeoutlen))
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  group = augroup("increase_macro_timeout"),
  callback = function()
    vim.notify("Finished recording macro!!")
    if vim.g.original_timeoutlen then
      vim.opt.timeoutlen = vim.g.original_timeoutlen
    end
  end,
})
