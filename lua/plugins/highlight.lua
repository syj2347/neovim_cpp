---@type LazySpec
return {
  { -- Rainbow pair colorization
    "hiphish/rainbow-delimiters.nvim",
    lazy = false,
    config = function()
      require "configs.highlight"
    end,
  },
}
