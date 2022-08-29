"  ------------ Lsp
command! -nargs=0 Def lua vim.lsp.buf.definition()
command! -nargs=0 Fmt lua vim.lsp.buf.formatting()
command! -nargs=0 Imp lua vim.lsp.buf.implementation()
command! -nargs=0 Ref lua vim.lsp.buf.references()
command! -nargs=0 Info lua vim.lsp.buf.hover()
command! -nargs=0 Diagnose lua vim.diagnostic.open_float()
command! -nargs=0 CodeAction lua vim.lsp.buf.code_action()
command! -nargs=0 Rename lua vim.lsp.buf.rename()
command! -nargs=0 SignatureHelp lua vim.lsp.buf.signature_help()
command! -nargs=0 LspLog lua vim.cmd('sp'..vim.lsp.get_log_path())

nmap ren :Rename<CR>
nmap ca :Ref<CR> 
nmap imp :Imp<CR>
nmap gi :Info<CR>
nmap gd :Def<CR>
nmap fmt :Fmt<CR>

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
set grepprg=rg\ --vimgrep
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"  ------------ Language specific

" Tfsc check
command! -nargs=0 Tfsec vsplit term:// tfsec %:p:h

" Rust comments hints
"autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs lua require'lsp_extensions'.inlay_hints{ prefix = '>', highlight = "Comment", enabled = {"TypeHint", "ChainingHint", "ParameterHint"} }

"  ------------ Misc

"" Order lines by lenght
command! -range SortLen <line1>,<line2> !awk '{ print length(), $0 | "sort -n | cut -d\\  -f2-" }'

"" Transparent
command! -nargs=0 Trans call LetMeSee()
function LetMeSee()
    highlight NonText guibg=NONE
    highlight Normal guibg=NONE
endfunction

" Share codae
" Only Linux. For Mac, see: https://gist.github.com/shmup/db671132f0f9882187b28a677fa8df72 
command! -range=% SP <line1>,<line2>w !curl -F 'sprunge=<-' http://sprunge.us | tr -d '\n' | xclip -i -selection clipboard
command! -range=% CL <line1>,<line2>w !curl -F 'clbin=<-' https://clbin.com | tr -d '\n' | xclip -i -selection clipboard
command! -range=% VP <line1>,<line2>w !curl -F 'text=<-' http://vpaste.net | tr -d '\n' | xclip -i -selection clipboard
"command! -range=% PB <line1>,<line2>w !curl -F 'c=@-' https://ptpb.pw/?u=1 | tr -d '\n' | xclip -i -selection clipboard
command! -range=% IX <line1>,<line2>w !curl -F 'f:1=<-' http://ix.io | tr -d '\n' | xclip -i -selection clipboard
command! -range=% EN <line1>,<line2>w !curl -F 'file=@-;' https://envs.sh | tr -d '\n' | xclip -i -selection clipboard
command! -range=% TB <line1>,<line2>w !nc termbin.com 9999 | tr -d '\n' | xclip -i -selection clipboard
