---@type LazySpec
return {
  "windwp/nvim-ts-autotag",
  -- event = "InsertEnter",
  ---@param opts nvim-ts-autotag.Opts
  config = function(_, opts)
    opts = HellVim.dedup(opts)
    require("nvim-ts-autotag").setup(opts)
  end,
}
