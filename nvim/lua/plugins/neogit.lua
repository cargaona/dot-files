return {
  "NeogitOrg/neogit",
  lazy = true,
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",  -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = function()
    -- Neogit
    require('neogit').setup()
    vim.keymap.set("n", "<leader>ggn", "<cmd> Neogit <CR>", { desc = "Neogit" })
    vim.keymap.set("n", "<leader>gga", "<cmd> Neogit add <CR>", { desc = "Neogit add" })
    vim.keymap.set("n", "<leader>ggp", "<cmd> Neogit pull <CR>", { desc = "Neogit pull" })
    -- vim.keymap.set("n", "<leader>ggP", "<cmd> Neogit push <CR>", { desc = "Neogit push" })
    vim.keymap.set("n", "<leader>gcm", "<cmd> Neogit commit <CR>", { desc = "Neogit commit" })
  end,
}
