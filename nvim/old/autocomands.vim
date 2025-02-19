" This is for vim buffer to not ocupy the total amount of the window
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
" Set Rust 
"-------------------------------------
autocmd BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "NonText", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

"Set Go
autocmd BufWritePost *.go lua vim.lsp.buf.format()
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

" v 
aug vlang
  au BufNewFile,BufRead *.v set filetype=vlang
aug end 

"js
aug javascript
    au!
    au BufNewFile,BufRead *.js set filetype=javascript
    au BufWritePre *.js lua vim.lsp.buf.format()
aug end

"Set Markdown
"-------------------------------------
autocmd FileType markdown setlocal spell
autocmd FileType markdown setlocal complete+=kspell
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal colorcolumn=-2 

"Set Yaml
"-------------------------------------
autocmd FileType yaml setlocal expandtab tabstop=2 shiftwidth=2 

"Set GitCommits
"-------------------------------------
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit setlocal complete+=kspell

"Set Dockerfile filetype
"-------------------------------------
aug docker_ft_detection
  au!
  au BufRead,BufNewFile Dockerfile* :set filetype=dockerfile
aug end

"Set Terraform nfiletype 
"-------------------------------------
"aug terraform_ft_detection
    "au!
    "au BufNewFile,BufRead *.tf set filetype=terraform
    "au BufWritePre *.tf lua vim.lsp.buf.format()
"aug end
