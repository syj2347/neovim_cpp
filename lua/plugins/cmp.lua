---@type LazySpec
return {
  { import = "nvchad.blink.lazyspec" },

  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          border = "rounded",
        },
        documentation = {
          auto_show = false,
          window = { border = "rounded", scrollbar = true },
        },
      },
      signature = { enabled = false },
    },
  },
}
