return {
  {
    'numToStr/Comment.nvim',
    keys = {
      { "<C-]>", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",                   mode = "n", desc = "Toggle comment (linewise)" },
      { "<C-]>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>gv", mode = "v", desc = "Toggle comment (linewise visual)" },
    },
    config = function(_, opts)
      require("Comment").setup(opts)
    end,
  },
}
