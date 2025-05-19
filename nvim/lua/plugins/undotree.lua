return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>", { silent = true, noremap = true })

    -- focus on the undo tree window when it is opened WARN: does this even work?
    -- NOTE: find a way to get this functionality
    vim.cmd [[ autocmd FileType undotree setlocal cursorline ]]
  end,
}
