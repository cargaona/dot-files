return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "plugins.configs.null-ls"
    end,
  },
}
