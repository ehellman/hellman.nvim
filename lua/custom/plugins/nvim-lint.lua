---@type LazyPluginSpec
return {
  ---@module 'lint'
  "mfussenegger/nvim-lint",
  event = "LazyFile", --TODO: not needed?
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  -- opts_extend = { 'linters_by_ft', 'linters' },
  ---@class PluginLintOpts
  opts = {
    -- Event to trigger linters
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
      -- ["*"] = { "typos" },
    },
    -- override linter options or add custom linters.
    ---@type table<string, table>
    linters = {
      -- Example of using selene only when a selene.toml file is present
      -- selene = {
      --   -- `condition` is another HellVim extension that allows you to
      --   -- dynamically enable/disable linters based on the context.
      --   condition = function(ctx)
      --     return vim.fs.find({ 'selene.toml' }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  ---@param opts PluginLintOpts
  config = function(_, opts)
    local M = {}

    local lint = require("lint")

    for name, linter in pairs(opts.linters) do
      if type(linter) == "table" and type(lint.linters[name]) == "table" then
        lint.linters[name] = vim.tbl_deep_extend("force", lint.linters[name], linter)
        if type(linter.prepend_args) == "table" then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end

    -- TODO: why?
    lint.linters_by_ft = opts.linters_by_ft

    function M.debounce(ms, fn)
      local timer = vim.uv.new_timer()
      return function(...)
        local argv = { ... }
        timer:start(ms, 0, function()
          timer:stop()
          vim.schedule_wrap(fn)(unpack(argv))
        end)
      end
    end

    function M.lint()
      -- Use nvim-lint's logic first:
      -- * checks if linters exist for the full filetype first
      -- * otherwise will split filetype by "." and add all those linters
      -- * this differs from conform.nvim which only uses the first filetype that has a formatter
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)

      -- print('linting', vim.bo.filetype, vim.inspect(names))
      -- Create a copy of the names table to avoid modifying the original.
      names = vim.list_extend({}, names)

      -- Add fallback linters.
      if #names == 0 then
        vim.list_extend(names, lint.linters_by_ft["_"] or {})
      end

      -- Add global linters.
      vim.list_extend(names, lint.linters_by_ft["*"] or {})

      -- Filter out linters that don't exist or don't match the condition.
      local ctx = { filename = vim.api.nvim_buf_get_name(0) }
      ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")
      names = vim.tbl_filter(function(name)
        local linter = lint.linters[name]
        if not linter then
          HellVim.warn("Linter not found: " .. name, { title = "nvim-lint" })
        end
        return linter and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
      end, names)

      -- Run linters.
      if #names > 0 then
        -- vim.notify('Linting with ' .. table.concat(names, ', '), vim.log.levels.INFO, { title = 'nvim-lint' })
        lint.try_lint(names)
      else
        -- vim.notify('No linters found', vim.log.levels.INFO, { title = 'nvim-lint' })
      end
    end

    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = M.debounce(100, M.lint),
    })

    local Info = {}

    function Info.info()
      local linters = require("lint").linters
      -- Use the custom Utils.notify API
      HellVim.info("Available linters:", { title = "Linter Information" })

      if vim.tbl_isempty(linters) then
        HellVim.info("No linters found", { title = "Linter Information" })
        return
      end

      for name, linter in pairs(linters) do
        -- Utils.notify.info(string.format("Linter: %s", name), { title = "Linter Details" })

        HellVim.info(string.format("Linter: %s", name), { title = "Linter Details" })
        HellVim.info(vim.inspect(linter), { title = string.format("%s Configuration", name) })
      end
    end

    vim.api.nvim_create_user_command("LinterInfo", Info.info, {})
  end,
}
