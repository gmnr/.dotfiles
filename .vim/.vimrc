" initialize pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" general settings
set nocompatible
filetype plugin indent on
syntax on
set t_Co=256
set showcmd
set cursorline
set ttyfast
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set lazyredraw
set encoding=utf-8
set breakindent
set nojoinspaces
set nrformats=
set autochdir
set noshowmode

" disable swapfiles
set noswapfile

" disable autoformat comments in newline
au FileType * set fo-=c fo-=r fo-=o

" search settings
set hlsearch
set ignorecase
set smartcase
nnoremap <leader>c :silent! nohls<cr>

" Enter and <S-Enter> to insert empty lines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" fix esc delay
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000

" override color format for cursor and numbers
hi MatchParen ctermbg=231
hi CursorLine cterm=NONE ctermbg=234
hi LineNr cterm=NONE ctermfg=214
hi CursorLineNr cterm=NONE ctermfg=214
hi QuickFixLine term=reverse cterm=reverse
hi Search term=reverse cterm=reverse
hi Visual cterm=NONE ctermbg=232

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

" smart suggestion
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" ctrl + n / p to move lines
nnoremap <C-n> :m .+1<CR>==
inoremap <C-n> <Esc>:m .+1<CR>==gi
vnoremap <C-n> :m '>+1<CR>gv=gv
nnoremap <C-p> :m .-2<CR>==
inoremap <C-p> <Esc>:m .-2<CR>==gi
vnoremap <C-p> :m '<-2<CR>gv=gv

" line wrapping
:set wrap
:set linebreak
:set nolist

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

" quick save
nnoremap <leader>ev :sp $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qq :q<CR>
nnoremap <leader>Q :q!<CR>

" quick search
nnoremap <leader>ff :%s/
set gdefault

" more natural split openings
set splitbelow
set splitright

" enforcing purity
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>

" statusline settings
" function! GitBranch()
"   return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
" endfunction
" 
" function! StatuslineGit()
"   let l:branchname = GitBranch()
"   return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
" endfunction

" use incremental search
set incsearch

set laststatus=2
set statusline=
set statusline+=%2*::
" set statusline+=%{StatuslineGit()}\ 
set statusline+=%1*\ %F
set statusline+=\ %m
set statusline+=%=
set statusline+=\%y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \[%{&fileformat}\]
set statusline+=\ %3l
set statusline+=/
set statusline+=%3L\ 
set statusline+=%2*\ %3p%%\ 
set statusline+=\ ::

" statusline colors
hi User1 cterm=bold ctermbg=white ctermfg=black
hi User2 cterm=bold ctermbg=black ctermfg=white
