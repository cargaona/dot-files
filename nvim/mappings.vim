imap <S-Right> <Esc>V<Right>
imap <S-Left> <Esc>V<Left>
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
nnoremap <Leader>tr :NvimTreeToggle<CR>

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

" Move lines with Ctrl+arrow
" inoremap <C-Down> <Esc>:m+<CR>
" noremap <C-Up> <Esc>:m-2<CR>
" nnoremap <C-Down> :m+<CR>
" nnoremap <C-Up> :m-2<CR>

" Scroll Alt + Shift + Arrows
map <A-k> <C-E><C-E>
map <A-i> <C-Y><C-Y>

" Move through words wit Crtl
nnoremap <C-Right> e <Right>
nnoremap <C-Left> b

"NerdCommenter (scrooloose/nerdcommenter)
"-------------------------------------
""nmap <C-]> <Plug>NERDCommenterToggle <Down>
""vmap <C-]> <Plug>NERDCommenterToggle<CR>gv

"Schleep indention
"-------------------------------------
vmap <C-Down> <Plug>SchleppIndentDown
vmap <C-Up> <Plug>SchleppIndentUp
vmap <C-d> <Plug>SchleppDup

" NvimTree (kyazdani42/nvim-tree.lua)
"-------------------------------------
""nnoremap <leader>f :NvimTreeToggle<Enter>

" Telescope (nvim-telescope/telescope.nvim)
nnoremap <silent> <leader>f <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr>
nnoremap <leader>b <cmd>Telescope buffers<cr>
nnoremap <leader>h <cmd>Telescope help_tags<cr>
nnoremap <silent> <leader>g :Telescope live_grep<CR>

" Delete the word in front of the cursor
imap <C-D> X<Esc>lbce

" Undo with Crtl+z / Redo with Crtl+Shif+z
map <C-r> :redo<CR>
map <C-z> u

nnoremap <C-n> :bnext<CR>
nnoremap <C-'> :bp<CR> 

nnoremap <silent> <leader><space> :noh<cr>

"Switch buffers with Crtl+Atl+arrows
nnoremap <A-Tab> :bn
nnoremap <A-S-Tab> :bp

"" Close buffer
noremap <C-q> :bw<CR>

"" Split
"" noremap <Leader>h :<C-u>split<CR>
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

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

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

