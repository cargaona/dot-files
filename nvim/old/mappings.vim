imap <S-Right> <Esc>V<Right> imap <S-Left> <Esc>V<Left>
imap <S-Down> <Esc>V<Down>
nmap <S-Right> v<Right>
vmap <S-Right> <Right>
nmap <S-Down> V<Down>
nmap <S-Left> v<Left>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
nmap <S-Up> V<Up>
vmap <S-Up> <Up>
nnoremap <C-S-Right> <Esc>v
nnoremap <C-S-Left> <Esc>v
nnoremap <C-t> :NvimTreeToggle<CR>
nnoremap <silent> <leader>ee :e $CODE_PATH/dot-files/nvim/<cr> 
nnoremap <silent> <leader>wd vim.lsp.diagnostic.show_line_diagnostics()<cr> 

nmap ren :Rename<CR>
nmap ca :Ref<CR> 
nmap imp :Imp<CR>
nmap gi :Info<CR>
nmap gd :Def<CR>
nmap fmt :Fmt<CR>
nmap co :CodeAction<CR>
nnoremap <silent> <leader>er :Err<cr> 
nnoremap <silent> <leader>r :ReloadNvim<cr> 

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Move through words wit Crtl
nnoremap <C-Right> e <Right>
nnoremap <C-Left> b

"NerdCommenter (scrooloose/nerdcommenter)
nmap <C-]> <Plug>NERDCommenterToggle <Down>
vmap <C-]> <Plug>NERDCommenterToggle<CR>gv

"" Move line(s) with C-up/down or duplicate them with C-d
vmap <C-d> <Plug>SchleppDup
vmap <C-Up> <Plug>SchleppIndentUp
vmap <C-Down> <Plug>SchleppIndentDown

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gbl :Git blame<CR>
noremap <Leader>gca :Git commit --amend<CR>
noremap <Leader>gcm :Git commit<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gf :Git fetch<CR>
noremap <Leader>gl :Git pull<CR>
noremap <Leader>gp :Git push<CR>
noremap <Leader>gr :Gremove<CR>
noremap <Leader>gs :Git<CR>
noremap <Leader>log :Git log<CR>
" C-a creates a new branch 
nnoremap <silent> <leader>co <cmd>Telescope git_branches<cr> 
nnoremap <silent> <leader>sh <cmd>Telescope git_commits<cr> 

" Telescope (nvim-telescope/telescope.nvim)
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>t <cmd>Telescope<cr>
nnoremap <silent> <leader>h <cmd>Telescope help_tags<cr>
nnoremap <silent> <leader>gg <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>f <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>

" Delete the word in front of the cursor imap <C-D> X<Esc>lbce
" Undo with Crtl+z / Redo with Crtl+Shif+z
map <C-r> :redo<CR>
map <C-z> u

nnoremap <silent> <leader><space> :noh<cr>

nnoremap <A-Tab> :bn <CR>
"" nnoremap <C-n> :bnext<CR>
"" TODO: make :bp mapping work
nnoremap <A-S-Tab> :bprevious <CR>

"" Close buffer
noremap <C-q> :bw<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Navigate 
""nnoremap <silent> <C-Right> <C-w>l
""nnoremap <silent> <C-Left> <C-w>h 
""nnoremap <silent> <C-Down> <C-w>j
""nnoremap <silent> <C-Up> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
nnoremap <silent> <C-j> <C-w>j

" Lets you move to the end of the line (virtualedit=onemore needed)
nnoremap <End> <End><Right>
noremap $ $<Right>

"" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
nmap <leader>em <Plug>(easymotion-overwin-f2)

inoremap jk <ESC>
nnoremap jq :q!<CR>
nnoremap jwq :wq!<CR>
nnoremap jw :w!<CR>
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
