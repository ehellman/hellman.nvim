return {
  {
    'nvimtools/none-ls.nvim',
    enabled = false,
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          -- JavaScript, TypeScript
          null_ls.builtins.diagnostics.eslint_d, -- Linting
          null_ls.builtins.code_actions.eslint,  -- Auto-fixes
          null_ls.builtins.formatting.prettierd.with {
            filetypes = { 'css', 'yml', 'yaml', 'toml' },
            -- args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
          },
          -- Python
          null_ls.builtins.diagnostics.flake8, -- Linting
          null_ls.builtins.formatting.black,   -- Formatting (PEP 8)
          null_ls.builtins.formatting.isort,   -- Sort imports

          -- Rust
          null_ls.builtins.formatting.rustfmt, -- Formatting

          -- Go
          null_ls.builtins.formatting.gofmt,     -- Formatting
          null_ls.builtins.formatting.goimports, -- Auto-imports

          -- C#
          null_ls.builtins.formatting.csharpier, -- Formatting

          -- CSS, SCSS
          null_ls.builtins.diagnostics.stylelint, -- Linting

          -- Lua
          null_ls.builtins.formatting.stylua,    -- Formatting for Lua
          null_ls.builtins.diagnostics.luacheck, -- Linting for Lua (requires luarocks)

          -- Shell scripting (Bash, Zsh, Sh)
          --  Linting for shell scripts
          null_ls.builtins.diagnostics.shellcheck,
          --  Formatting for Bash/Zsh
          null_ls.builtins.formatting.shfmt,

          -- General
          null_ls.builtins.formatting.trim_whitespace, -- Remove trailing whitespace
          null_ls.builtins.formatting.trim_newlines,   -- Remove extra newlines
        },
      }

      -- Autoformat on save
      local format_augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = format_augroup,
        callback = function()
          vim.lsp.buf.format { async = false }
        end,
      })
    end,
  },
}
