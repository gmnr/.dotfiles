" initialize pathogen
set nocp
if exists('$DOTFILES')
    source $DOTFILES/.vim/autoload/pathogen.vim
endif
execute pathogen#infect('bundle/{}', '~/.dotfiles/.vim/bundle/{}')
execute pathogen#helptags()

" must have .vimrc
syntax on
filetype plugin indent on
set t_Co=256
set showcmd
set cmdheight=2
set cursorline
set ttyfast
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set wildignorecase
set lazyredraw
set encoding=utf-8
set breakindent
set nojoinspaces
set nrformats-=octal
"set autochdir --> set the working directory
set noshowmode
set clipboard^=unnamed

" disable swapfiles
set noswapfile

" disable autoformat comments in newline
au FileType * set fo-=c fo-=r fo-=o

" search settings
set hlsearch
set ignorecase
set smartcase
set incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)k
set shortmess-=S

" fix esc delay
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

"colorscheme settings 
let g:onedark_termcolors=16
colorscheme onedark

" cursor in terminal vim
if exists('$TMUX')
    let &t_SI = "\ePtmux;\e\e[4 q\e\\"
    let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
    let &t_SI = "\e[4 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[2 q"
endif

" relative numbering with autocmd
set number
set relativenumber
au InsertEnter * set norelativenumber
au InsertLeave * set relativenumber

" always show at least one line after cursor
if !&scrolloff
    set scrolloff=1
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline

" history / undo settings
set history=1000
set undolevels=1000

" move across visual line
nnoremap j gj
nnoremap k gk

" buffer navigation
set hidden
nnoremap <C-l>l :bnext<CR>
nnoremap <C-l>h :bprevious<CR>

" disable Q for ex-mode
nnoremap Q <nop>

" ctrl + n / p to move lines
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
nnoremap <C-k> :m .-2<CR>==
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-k> :m '<-2<CR>gv=gv

" line wrapping
:set wrap
:set linebreak
:set nolist

" define templates
au BufNewFile *.py 0r ~/.dotfiles/.vim/templates/python.template

" tab settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set shiftwidth=4
set autoindent
set smartindent

" leader setting
let mapleader=" "
let maplocalleader=" "

"python syntax
let g:python_highlight_all = 1

" open and load .vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" quick save
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :x<CR>

" quick exit
nnoremap <leader>qq :q<CR>
nnoremap <leader>QQ :q!<CR>
nnoremap <leader>QA :qa!<CR>

" quick search
nnoremap <leader>ff :%s/
set gdefault

" quick norm
nnoremap <leader>nn :%norm 

" more natural split openings
set splitbelow
set splitright

" enforcing purity --> maybe remapping to something useful?
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Right> <Nop>
noremap <Left>  <Nop>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" statusline settings
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" 
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" no backups
set nobackup
set noswapfile
set nowritebackup
set viminfo="NONE"

set laststatus=2

" comment out old statusline settings overwritten by Airline
"set statusline=
"set statusline+=%2*::
"" set statusline+=%{StatuslineGit()}\ 
"set statusline+=%1*\ %F
"set statusline+=\ %m
"set statusline+=%=
"set statusline+=\%y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\ \[%{&fileformat}\]
"set statusline+=\ %3l
"set statusline+=/
"set statusline+=%3L\ 
"set statusline+=%2*\ %3p%%\ 
"set statusline+=\ ::

"" statusline colors
"hi User1 cterm=bold ctermbg=white ctermfg=black
"hi User2 cterm=bold ctermbg=black ctermfg=white


" append.vim
nnoremap <silent> <Leader>a :set opfunc=Append<CR>g@
nnoremap <silent> <Leader>i :set opfunc=Insert<CR>g@
function! Append(type, ...)
    normal! `]
    if a:type == 'char'
        call feedkeys("a", 'n')
    else
        call feedkeys("o", 'n')
    endif
endfunction
function! Insert(type, ...)
    normal! `[
    if a:type == 'char'
        call feedkeys("i", 'n')
    else
        call feedkeys("O", 'n')
    endif
endfunction

" keep the old config
"nmap <leader>tt :QuickRun<CR>
"let g:quickrun_config = {
    "\'*': {
    "\'outputter/buffer/split': ':8split',
    "\'ouputter/buffer/into': 1,
    "\'hook/time/enable': 1,
    "\'hook/time/format': '[Finished in %gs]',
    "\},
"\}

" quickrun config
nmap <leader>tt :QuickRun<CR>
let g:quickrun_config = {
    \'*': {
    \'hook/time/enable': 1,
    \'hook/time/format': '[Finished in %gs]',
    \},
\}

" buffer navigation
nnoremap <leader>hh :bprevious<CR>
nnoremap <leader>ll :bnext<CR>
nnoremap <leader>oo :confirm bd<CR>

" remap backspace so that goes to last used buffer
nnoremap <BS> <C-^>

" delimitMate settings
let g:delimitMate_nesting_quotes = ['"',"'"]
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

" emmet settings
let g:user_emmet_mode='nv'
let g:user_emmet_leader_key='<leader>'

" in visual mode use '*' and '#' to search for highlighted word
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" netrw settings
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=20

" remove trailing whitespaces
autocmd FileType css,py,c,html,xml,js autocmd BufWritePre <buffer> :%s/\s\+$//e

" add function to create scratch buffer
function! s:DScratch()
    let scratch_dir  = '~'
    let scratch_date = strftime('%Y-%m-%d')
    let scratch_file = 'notes-'. scratch_date . '.md'
    let scratch_buf  = bufnr(scratch_file)
    let bufinfo = getbufinfo(scratch_buf)
    if scratch_buf == -1
        " if buffer don't exist create it
        exe 'split ' . scratch_dir . '/' . scratch_file
        if empty(glob(scratch_dir . '/' . scratch_file))
            exe ':normal i# Quick Notes - ' . scratch_date
            exe ':normal o'
            exe ':normal 28a-'
            exe ':normal o'
            exe ':w'
            exe ':startinsert'
        endif
    elseif empty(bufinfo[0].windows)
        " if buffer exist open it
        exe 'split +buffer' . scratch_buf
    else
        " if buffer exists but its open, close it
        let scratch_win = filter(getwininfo(), 'v:val.bufnr == scratch_buf')[0].winnr
        exe ':w'
        exe scratch_win . 'wincmd c'
    endif
endfunction

command! Scratch call s:DScratch()
nnoremap <leader>nn :Scratch<CR>
