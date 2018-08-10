" Pathogen settings
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

" general settings
set nocompatible
syntax on
filetype plugin indent on
colorscheme one
set showcmd
set cursorline
set cmdheight=2
set cot=menu
set showmatch
set wildmenu
set lazyredraw
set encoding=utf-8
set breakindent
set ignorecase
set smartcase
set nojoinspaces
set nrformats=

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

" buffer navigation
set hidden
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <leader>ww :bd!<CR>

" Window Size
set lines=45 columns=94

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
let g:airline_theme='one'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2
set noshowmode

" backspace behaviour
set backspace=indent,eol,start
imap <C-BS> <C-W>

" Enter and <S-Enter> to insert empty lines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" emmet settings
let g:user_emmet_leader_key='<C-S>'

" leader setting
let mapleader=" "
let maplocalleader=" "

" append / insert custom mappings
" text object
nnoremap <leader>at vit<Esc>a
nnoremap <leader>it vito<Esc>i

" parenthesis
nnoremap <leader>ab vib<Esc>a
nnoremap <leader>ib vibo<Esc>i

" double quotes
nnoremap <leader>a" vi"<Esc>a
nnoremap <leader>i" vi"o<Esc>i

" single quotes
nnoremap <leader>a' vi'<Esc>a
nnoremap <leader>i' vi'o<Esc>i

" braces
nnoremap <leader>aB viB<Esc>a
nnoremap <leader>iB viBo<Esc>i

" brackets
nnoremap <leader>a] vi]<Esc>a
nnoremap <leader>i] vi]o<Esc>i

" clear the buffer F5
nnoremap <F3> :%d<CR>

" NERD shortcuts
nmap <F7> :NERDTreeToggle<CR>

" Zen Mode
nmap <F12> :Goyo<CR>

" Quick Search
nnoremap <leader>ff :%s/
set gdefault

" Open old files
nnoremap <leader>oo :browse oldfiles<CR>

" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.mkv,*.mp4,*.wmv,*.jpg,*.mp3,*.cbr,*.png,*.pdf,*.mov,*.mobi,*.docx,*.ini,*.mbp,*.flv,*.PNG,*.JPEG,*.xlsx,*.xls,*.gif,*.pptx,*.mid,*.avi,*.JPG,*.MOV,*.epub,*.mpg,*.gp5,*.gp4,*.gp3,*.nfo,*.gpx,*.cbz,*.m4v,*.ts
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" more natural navigation in split
nnoremap <leader>jj <C-W><C-J>
nnoremap <leader>kk <C-W><C-K>
nnoremap <leader>ll <C-W><C-L>
nnoremap <leader>hh <C-W><C-H>

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

" python mode syntax
"let g:pymode_python = 'python3'
"let g:pymode_syntax = 1
"let g:pymode_lint_signs = 1
"let g:pymode_lint_cwindow = 0
"let g:pymode_lint_message = 1

" custom lint errors
"let g:pymode_lint_todo_symbol = '•'
"let g:pymode_lint_comment_symbol = 'CC'
"let g:pymode_lint_visual_symbol = 'RR'
"let g:pymode_lint_error_symbol = '>>'
"let g:pymode_lint_info_symbol = 'II'
"let g:pymode_lint_pyflakes_symbol = 'FF'

"disable ROPE for pymode
"let g:pymode_rope = 0
"let g:pymode_rope_lookup_project = 0
"let g:pymode_rope_complete_on_dot = 0
"let g:pymode_rope_autoimport = 0
"let g:pymode_syntax_space_errors = 1

" Supertab options
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabLongestHighlight = 1
let g:SuperTabCrMapping = 0

" jedi vim mappings
autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#goto_command = "<leader>dd"
let g:jedi#goto_assignments_command = "<leader>gg"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>mm"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>rp"
let g:jedi#show_call_signatures = "2"
let g:jedi#use_tabs_not_buffers= 1
let g:jedi#popup_select_first = 0
let g:jedi#popup_on_dot = 0

" Backups
set nobackup
set noswapfile
set nowritebackup

" disable cursor blinking
set guicursor+=a:blinkon0

" set background based on time of day
set background=dark

" gundo settings
nnoremap <leader>uu :GundoToggle<CR>
let g:gundo_prefer_python3 = 1
let g:gundo_close_on_revert = 1

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

" alt + directions to move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" org-mode settings
let g:org_aggressive_conceal = 1

" autocomplete settings
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
