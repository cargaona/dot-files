return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      local null_ls = require "null-ls"
      return {
        sources = {
          null_ls.builtins.formatting.black.with({
            extra_args = { "--line-length=120" }
          }),
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.goimports,
        },
      }
    end,
  },
}
