" Pathogen settings
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

" general settings
set nocompatible
syntax on
filetype plugin indent on
set showcmd
set cursorline
set cmdheight=2
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set lazyredraw
set encoding=utf-8
set breakindent
set ignorecase
set infercase
set smartcase
set nojoinspaces
set nrformats=
set autochdir

" theme settings
colorscheme one
let g:airline_theme='one'
set t_Co=256

" cursorline
hi CursorLine cterm=NONE ctermbg=darkgrey

" fix esc delay
set timeoutlen=1000 ttimeoutlen=0

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

" backspace behaviour
set backspace=indent,eol,start
imap <C-BS> <C-W>

" buffer navigation
set hidden
nnoremap <C-l>l :bnext<CR>
nnoremap <C-l>h :bprevious<CR>

" Enter and <S-Enter> to insert empty lines
nmap <S-CR> O<Esc>
nmap <CR> o<Esc>

" ctrl + directions to move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Window Size
if has("gui_running")
    set lines=40 columns=87
    set tw=79
endif
set background=dark

" Line Wrapping
:set wrap
:set linebreak
:set nolist

" Tab Settings
set tabstop=4
set softtabstop=4
set expandtab
set shiftround
set shiftwidth=4
set autoindent
set smartindent

" delimitMate Settings
let delimitMate_expand_cr = 1
au FileType python let b:delimitMate_nesting_quotes = ['"']

" GUI hide all settings options
set guioptions-=m
set guioptions-=T
set guioptions-=R
set guioptions-=r
set guioptions-=l
set guioptions-=L
set belloff=all

" airline settings
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type= 2
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2
set noshowmode

" leader setting
let mapleader=" "
let maplocalleader=" "

" clear the buffer F3
nnoremap <F3> :%d<CR>


" Quick Search
nnoremap <leader>ff :%s/
set gdefault

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.mkv,*.mp4,*.wmv,*.jpg,*.mp3,*.cbr,*.png,*.pdf,*.mov,*.mobi,*.docx,*.ini,*.mbp,*.flv,*.PNG,*.JPEG,*.xlsx,*.xls,*.gif,*.pptx,*.mid,*.avi,*.JPG,*.MOV,*.epub,*.mpg,*.gp5,*.gp4,*.gp3,*.nfo,*.gpx,*.cbz,*.m4v,*.ts
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" more natural split openings
set splitbelow
set splitright

" Enforcing purity
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>

" incsearch smart mappings
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" syntax highlighting for python
let g:python_highlight_all = 1

" Supertab options
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 0

" Backups
set nobackup
set noswapfile
set nowritebackup

" disable cursor blinking
set guicursor+=a:blinkon0

" quickrun settings
"nnoremap <F4> :QuickRun<CR>
nmap <F4> :QuickRun<CR>
"nnoremap <leader>rr :QuickRun<CR>
let g:quickrun_config = {
      \'*': {
      \'outputter/buffer/split': ':8split', 'outputter/buffer/close_on_empty': 1, 'hook/time/enable': 1, 'hook/time/format': '[Finished in: %gs]'},}

"let g:quickrun_config.python = {'command' : 'python3'}

" tagbar toggle
nmap <F8> :TagbarToggle<CR>


" ALE settings
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1


" autocomplete settings
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" make split horizontal
nnoremap <leader>hh <C-w>t<C-w>H
