return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      local null_ls = require "null-ls"
      return {
        sources = {
          null_ls.builtins.formatting.goimports,
        },
      }
    end,
  },
}
