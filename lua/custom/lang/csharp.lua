local function get_dotnet_path()
  -- local dotnet_path = vim.fn.system(HellVim.is_windows() and "where" or "which" .. " " .. "dotnet")
  --
  -- print("error", vim.inspect(vim.v.shell_error))
  -- -- Check if the command was successful
  -- if vim.v.shell_error ~= 0 then
  --   -- If "which dotnet" failed, dotnet is not installed or not in PATH
  --   print("dotnet command not found. Please install dotnet.")
  --   -- return nil
  -- else
  --   dotnet_path = dotnet_path:gsub("%s+$", "")
  -- end

  if vim.env.PATH:find("dotnet") == nil then
    vim.env.PATH = vim.env.PATH .. ":" .. "/usr/bin/dotnet"
  end
  -- Trim any trailing newline characters from the path

  -- return dotnet_path
end

---@type LazySpec
return {
  {
    "seblyng/roslyn.nvim",
    ft = { "cs" },
    dependencies = {
      {
        -- "WhoIsSethDaniel/mason-tool-installer.nvim",
        -- has to be installed using mason.nvim because roslyn is not in the mason registry yet, but uses a custom registry
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "roslyn",
            -- "rzls", -- razor
          },

          registries = {
            "github:Crashdummyy/mason-registry",
          },
        },
      },
    },
    ---@type RoslynNvimConfig
    opts = {
      --- disable missing-fields to mask "cmd" missing
      ---@diagnostic disable-next-line: missing-fields
      config = {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|symbol_search"] = {
            dotnet_search_reference_assemblies = true,
          },
          ["csharp|formatting"] = {
            dotnet_organize_imports_on_format = true,
          },
          ["csharp|completions"] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_show_name_completion_suggestions = true,
          },
        },
      },
    },
    config = function(_, opts)
      local roslyn = require("roslyn")
      roslyn.setup(opts)
    end,
  },
}
