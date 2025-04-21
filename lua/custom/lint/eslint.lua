local auto_format = vim.g.eslint_autoformat == nil or vim.g.eslint_autoformat
-- local auto_fix = vim.g.eslint_autofix == nil or vim.g.eslint_autofix
local priority = vim.g.eslint_priority == nil or vim.g.eslint_priority

---@type LazySpec
return {
  {
    "esmuellert/nvim-eslint",
    enabled = false,
    version = false,
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    config = function()
      local formatter = HellVim.lsp.formatter({
        -- name = auto_fix and "eslint: EslintFixAll" or "eslint: lsp",
        name = "eslint:lsp",
        primary = false,
        priority = priority and 50 or 200,
        filter = "eslint",
      })

      -- local function get_client(buf)
      --   return HellVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
      -- end
      -- Use EslintFixAll on Neovim < 0.10.0
      -- if not pcall(require, "vim.lsp._dynamic") then
      --   formatter.name = "eslint: EslintFixAll"
      --   formatter.sources = function(buf)
      --     local client = get_client(buf)
      --     return client and { "eslint" } or {}
      --   end
      --   formatter.format = function(buf)
      --     local client = get_client(buf)
      --     if client then
      --       local diag = vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
      --       if #diag > 0 then
      --         vim.cmd("EslintFixAll")
      --       end
      --     end
      --   end
      -- end

      HellVim.format.register(formatter)

      -- for debugging
      -- HellVim.root.packageManager()

      require("nvim-eslint").setup({
        settings = {
          useFlatConfig = true,
          workingDirectory = { mode = "auto" },
          codeActionOnSave = { mode = "all" },
          format = auto_format,
          packageManager = "pnpm",
        },
      })
    end,
  },
  {
    ---@module 'lspconfig'
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.options
      servers = {
        eslint = {
          settings = {
            useFlatConfig = true,
            workingDirectories = { mode = "auto" },
            -- workingDirectories = { mode = "location" },
            format = auto_format,
          },
        },
      },
      setup = {
        eslint = function()
          if not auto_format then
            return
          end

          local function get_client(buf)
            return HellVim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]
          end

          local formatter = HellVim.lsp.formatter({
            -- name = auto_fix and "eslint: EslintFixAll" or "eslint: lsp",
            name = "eslint:lsp",
            primary = false,
            priority = priority and 50 or 200,
            filter = "eslint",
          })

          HellVim.format.register(formatter)
        end,
      },
    },
  },
}
