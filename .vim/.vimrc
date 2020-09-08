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
set cmdheight=2
set cursorline
set ttyfast
set cot=menu
set updatetime=100
set showmatch
set wildmenu
set wildmode=list:longest,full
set showcmd
set wildignorecase
set lazyredraw
set redrawtime=10000
set encoding=utf-8
set breakindent
set nojoinspaces
set nrformats-=octal
"set autochdir --> set the working directory
"set noshowmode
"set clipboard^=unnamed
set ruler

" use fzf
set rtp+=/usr/local/opt/fzf

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
"if exists('$TMUX')
    "let &t_SI = "\ePtmux;\e\e[4 q\e\\"
    "let &t_SR = "\ePtmux;\e\e[3 q\e\\"
    "let &t_EI = "\ePtmux;\e\e[2 q\e\\"
"else
    "let &t_SI = "\e[4 q"
    "let &t_SR = "\e[3 q"
    "let &t_EI = "\e[2 q"
"endif

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

" set hidden buffer
set hidden

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
command!  Wd write|bdelete
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :Wd<CR>

" quick exit
nnoremap <leader>qq :bd<CR>
nnoremap <leader>QQ :q<CR>
nnoremap <leader>QA :qa!<CR>

" quick search
nnoremap <leader>ff :%s/
set gdefault

" quick norm
nnoremap <leader>no :%norm 

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


" quickrun config
nmap <leader>tt :QuickRun<CR>
let g:quickrun_config = {
    \'*': {
    \'hook/time/enable': 1,
    \'hook/time/format': '[Finished in %gs]',
    \},
\}
" extra mappings to open the output in a predetermined split and to put the cursor there
" 'outputter/buffer/split': ':8split',
" 'ouputter/buffer/into': 1,

" buffer navigation
nnoremap <leader>hh :bprevious<CR>
nnoremap <leader>ll :bnext<CR>

" remap backspace so that goes to last used buffer
nnoremap <BS> <C-^>

" vim-fugive
nnoremap <space>ga :Git add %:p<CR><CR>
nnoremap <space>gs :Gstatus<CR>
"nnoremap <space>gc :Gcommit -v -q<CR>
"nnoremap <space>gt :Gcommit -v -q %:p<CR>
nnoremap <space>gd :Gdiff<CR>
"nnoremap <space>ge :Gedit<CR>
"nnoremap <space>gr :Gread<CR>
"nnoremap <space>gw :Gwrite<CR><CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
"nnoremap <space>gp :Ggrep<Space>
nnoremap <space>gm :Gmove<Space>
nnoremap <space>gb :Git branch<Space>
nnoremap <space>go :Git checkout<Space>
"nnoremap <space>gps :Dispatch! git push<CR>
"nnoremap <space>gpl :Dispatch! git pull<CR>

" delimitMate settings
let g:delimitMate_nesting_quotes = ['"',"'"]
let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1

" emmet settings
let g:user_emmet_mode='nv'
let g:user_emmet_leader_key='<leader>'
let g:user_emmet_settings = {'html' : {'block_all_childless': 1,},}

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
let scratch_dir = $HOME
function! s:DScratch()
    let dir = g:scratch_dir
    let date = strftime('%Y-%m-%d')
    let file = printf('%s/%s.md', dir, date)

    if !filereadable(file)
        let lines = [printf('# Quicknotes - %s', date), repeat('-', 28), '']
        call writefile(lines, file)
    endif
    call s:ToggleWindow(file)
endfunction

function! s:ToggleWindow(file) abort
    let win_info = filter(getwininfo(), 'v:val.bufnr == bufnr(a:file)')
    if empty(win_info)
        execute 'split ' . a:file
    else
        let winnr = win_info[0].winnr
        execute winnr . 'wincmd w'
        silent write
        execute winnr . 'wincmd c'
    endif
endfunction

command! Scratch call s:DScratch()
nnoremap <leader>oo :Scratch<CR>

" filter g output in a new buffer
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a | exe ":normal ggdd"
nnoremap <leader>gg :Filter 

" find the root of a file
function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()
nnoremap <leader>pp :ProjectFiles<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pl :Rg<CR>
nnoremap <leader>gi :GFiles<CR>
nnoremap <leader>ss :GFiles?<CR>

" accomodate for wsl on work laptop
if !has('macunix')
    source ~/.dotfiles/.vim/.workvimrc
    source ~/.fzf/plugin/fzf.vim
endif
