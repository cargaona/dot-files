local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Resize buffer properly when terminal size changes
autocmd("VimEnter", {
  pattern = "*",
  command = "silent exec \"!kill -s SIGWINCH $PPID\"",
})

-- Rust inlay hints
autocmd({ "BufEnter", "BufWinEnter", "TabEnter", "BufWritePost" }, {
  pattern = "*.rs",
  callback = function()
    require('lsp_extensions').inlay_hints {
      prefix = ' » ',
      highlight = "NonText",
      enabled = { "TypeHint", "ChainingHint", "ParameterHint" }
    }
  end,
})

-- Go settings
autocmd("BufWritePost", {
  pattern = "*.go",
  callback = function()
    vim.lsp.buf.format()
  end,
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.go",
  command = "setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4",
})

-- V language
augroup("vlang", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.v",
  command = "set filetype=vlang",
  group = "vlang",
})

-- JavaScript settings
augroup("javascript", { clear = true })
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.js",
  command = "set filetype=javascript",
  group = "javascript",
})
autocmd("BufWritePre", {
  pattern = "*.js",
  callback = function()
    vim.lsp.buf.format()
  end,
  group = "javascript",
})

-- Markdown settings
autocmd("FileType", {
  pattern = "markdown",
  command = "setlocal spell complete+=kspell textwidth=80 colorcolumn=-2",
})

-- YAML settings
autocmd("FileType", {
  pattern = "yaml",
  command = "setlocal expandtab tabstop=2 shiftwidth=2",
})

-- Git commit settings
autocmd("FileType", {
  pattern = "gitcommit",
  command = "setlocal spell complete+=kspell",
})

-- Dockerfile settings
augroup("docker_ft_detection", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "Dockerfile*",
  command = "set filetype=dockerfile",
  group = "docker_ft_detection",
})

