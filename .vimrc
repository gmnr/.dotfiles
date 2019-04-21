" general settings
set nocompatible
filetype plugin indent on
syntax on
set t_Co=256
set showcmd
set cursorline
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set lazyredraw
set encoding=utf-8
set breakindent
set ignorecase
set smartcase
set nojoinspaces
set nrformats=
set autochdir
set noshowmode

" fix esc delay
set timeoutlen=1000 ttimeoutlen=0

" fix cursorline
hi CursorLine cterm=NONE ctermbg=darkgrey

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

" ctrl + directions to move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

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
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" use incremental search
set incsearch

set laststatus=2
set statusline=
set statusline+=%2*::
set statusline+=%{StatuslineGit()}\ 
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
