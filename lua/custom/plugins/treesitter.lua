---@module 'lazy'
---@type LazySpec
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<BS>", desc = "Decrement Selection", mode = "x" },
        { "<c-space>", desc = "Increment Selection", mode = { "x", "n" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = function()
      local TS = require("nvim-treesitter")
      if not TS.get_installed then
        HellVim.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
        return
      end
      TS.update(nil, { summary = true })
    end,
    event = { "LazyFile", "VeryLazy" },
    lazy = vim.fn.argc(-1) == 0,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    keys = {
      { "<c-space>", desc = "Increment Selection" },
      { "<bs>", desc = "Decrement Selection", mode = "x" },
    },
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "asm",
        "c",
        "diff",
        "regex",
        "query",

        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",

        "ssh_config",
        "ini",
        "tmux",
        "xml",

        "html",
        "hyprlang",
        "vim",
        "vimdoc",
      },
      ---@type lazyvim.TSFeat
      highlight = {
        enable = true,
        disable = { "chezmoitmpl" },
      },
      ---@type lazyvim.TSFeat
      indent = {
        enable = true,
        disable = { "ruby" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter")
      if not TS.get_installed then
        return HellVim.error("Please use `:Lazy` and update `nvim-treesitter`")
      end

      if type(opts.ensure_installed) == "table" then
        opts.ensure_installed = HellVim.dedup(opts.ensure_installed)
      end

      TS.setup(opts)

      -- install missing parsers
      local installed = {} ---@type table<string, boolean>
      for _, lang in ipairs(TS.get_installed("parsers")) do
        installed[lang] = true
      end
      local to_install = vim.tbl_filter(function(lang)
        return not installed[lang]
      end, opts.ensure_installed or {})
      if #to_install > 0 then
        TS.install(to_install, { summary = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("hellvim_treesitter", { clear = true }),
        callback = function(ev)
          local ft = ev.match
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang or not installed[lang] then
            return
          end

          -- highlighting
          local hl = opts.highlight or {}
          if hl.enable ~= false and not (type(hl.disable) == "table" and vim.tbl_contains(hl.disable, lang)) then
            pcall(vim.treesitter.start, ev.buf)
          end

          -- indents
          local ind = opts.indent or {}
          if ind.enable ~= false and not (type(ind.disable) == "table" and vim.tbl_contains(ind.disable, lang)) then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    },
    config = function(_, opts)
      local TS = require("nvim-treesitter-textobjects")
      if not TS.setup then
        HellVim.error("Please use `:Lazy` and update `nvim-treesitter-textobjects`")
        return
      end
      TS.setup(opts)

      local function attach(buf)
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or not vim.tbl_get(opts, "move", "enable") then
          return
        end
        -- check if textobjects query exists for this language
        if not vim.treesitter.query.get(lang, "textobjects") then
          return
        end

        ---@type table<string, table<string, string>>
        local moves = vim.tbl_get(opts, "move", "keys") or {}
        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local desc = query:gsub("@", ""):gsub("%..*", "")
            desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
            vim.keymap.set({ "n", "x", "o" }, key, function()
              if vim.wo.diff and key:find("[cC]") then
                return vim.cmd("normal! " .. key)
              end
              require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
            end, {
              buffer = buf,
              desc = desc,
              silent = true,
            })
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("hellvim_treesitter_textobjects", { clear = true }),
        callback = function(ev)
          attach(ev.buf)
        end,
      })
      -- attach to already-loaded buffers
      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = function()
      local tsc = require("treesitter-context")
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3 }
    end,
  },
}
