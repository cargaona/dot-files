--vim.cmd "set termguicolors"
vim.g.lightline = {
  colorscheme = 'one',
  -- https://github.com/itchyny/lightline.vim/issues/292#issuecomment-367649293
  enable = {
    tabline = 0
  },
  active = {
    left = { { 'mode', 'paste' },
      { 'gitbranch', 'readonly', 'filename', 'modified' } }
  },
  component_function = {
    gitbranch = 'FugitiveHead'
  }
}
