"  ------------ Lsp
command! -nargs=0 Def silent! lua vim.lsp.buf.definition()
command! -nargs=0 Fmt lua vim.lsp.buf.format()
command! -nargs=0 Imp lua vim.lsp.buf.implementation()
command! -nargs=0 Ref lua vim.lsp.buf.references()
command! -nargs=0 Info lua vim.lsp.buf.hover()
command! -nargs=0 Diagnose lua vim.diagnostic.open_float()
command! -nargs=0 CodeAction lua vim.lsp.buf.code_action()
command! -nargs=0 Rename lua vim.lsp.buf.rename()
command! -nargs=0 Err lua vim.diagnostic.setqflist()
command! -nargs=0 LspLog lua vim.cmd('sp'..vim.lsp.get_log_path())
command! -nargs=0 ReloadNvim so $CODE_PATH/dot-files/nvim/init.lua 

nmap ren :Rename<CR>
nmap ca :Ref<CR> 
nmap imp :Imp<CR>
nmap gi :Info<CR>
nmap gd :Def<CR>
nmap fmt :Fmt<CR>
nmap co :CodeAction<CR>
nnoremap <silent> <leader>er :Err<cr> 
nnoremap <silent> <leader>r :ReloadNvim<cr> 

"  ------------ Language specific
"
" Golang
augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nnoremap bb :GoDebugBreakpoint<CR>
  au FileType go nnoremap <leader>stop :GoDebugStop<CR>
  au FileType go nnoremap <leader>deb :GoDebugStart<CR>
  au FileType go nmap cov :GoCoverageToggle<CR>
  au FileType go nmap tt :GoTestFunc<CR>
  au FileType go nmap df :GoDebugTestFunc<CR>
  au FileType go nmap gt :GoDefType<CR>
  au FileType go nmap ff :GoFillStruct<CR>
  au FileType go nmap err :GoIfErr<CR>
  "au FileType go nmap ca :GoCallers<CR>
  "au FileType go nmap gi :GoInfo<CR>
  "au FileType go nmap ren :GoRename<CR>
  "au FileType go nmap fmt :GoFmt<CR>
  au FileType go nmap imp :GoImplements<CR>
augroup END

"" Order lines by lenght
command! -range SortLen <line1>,<line2> !awk '{ print length(), $0 | "sort -n | cut -d\\  -f2-" }'

"" Transparent
command! -nargs=0 Trans call LetMeSee()
function LetMeSee()
    highlight NonText guibg=NONE
    highlight Normal guibg=NONE
endfunction
