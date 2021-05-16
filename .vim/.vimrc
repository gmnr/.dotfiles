"
"    __   _(_)_ __ ___  _ __ ___ 
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__ 
"   (_)_/ |_|_| |_| |_|_|  \___|
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @gmnr
" Personal configuration for vim (the greatest editor there is)

""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Source Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('$DOTFILES')
    source $DOTFILES/.vim/autoload/pathogen.vim
endif
execute pathogen#infect('bundle/{}', '~/.dotfiles/.vim/bundle/{}')
execute pathogen#helptags()


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  VIM options
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible                      " set no compatible
syntax on                             " enable syntax
filetype plugin indent on             " recognize filetype/load plugin/indent
set t_Co=256                          " set teminal colors
set cmdheight=2                       " set command height to 2 lines
set cursorline                        " enable cursorline
set ttyfast                           " improve smoothness of redrawing
set completeopt=menu                  " set insert mode completion mode
set showmatch                         " show matching bracket when inserting one
set showcmd                           " show commands in the last line
set wildignorecase                    " ignore case while completing files and dirs
set lazyredraw                        " do not redraw the screen while executing macros
set redrawtime=10000                  " time in milliseconds to redraw the screen
set encoding=utf-8                    " set encoding utf-8
set breakindent                       " wrapped lines will be visually indented
set nrformats-=octal                  " remove the octal notation from the number formats
set wildmenu                          " enable wildmenu
set wildmode=list:longest,full        " set wildmenu options
set rtp+=/usr/local/opt/fzf           " add fzf to runtimepath
set noswapfile                        " disable swapfiles
set hlsearch                          " enable search highlihgt
set ignorecase                        " ignore case for search
set smartcase                         " override ignorecase if capital in search pattern 
set incsearch                         " while typing a search show where the pattern matches
set shortmess=a                      " enable count message while searching
set ttimeout                          " set timing for key combinations
set timeoutlen=3000                   " time in milliseconds waited for a key sequence to complete
set ttimeoutlen=100                   " time in milliseconds waited for a key sequence to complete
set number                            " set line numbers
set history=1000                      " set the size of the history table
set undolevels=1000                   " maximum number of changes that can be undone
set hidden                            " set hidden buffer
set wrap                              " lines longer than windows width continue on the next line
set linebreak                         " break lines not at character but at 'breakat'
set nolist                            " dont' show character of list mode (i.e. $ at end of line)
set expandtab                         " in insert mode use the correct number of spaces for tab
set shiftround                        " round indent to multiples of shiftwidth
set autoindent                        " copy indent from the current line when starting a new line
set smartindent                       " smart autoindenting
set splitright                        " when splitting put the new one right the current
set gdefault                          " when substitutine the g flag is on by default
set nobackup                          " don't make a backup before overwriting a file
set noswapfile                        " don't create swapfiles
set nowritebackup                     " dont' make backups before overwriting a file
set viminfo="NONE"                    " don't show info after re-entering in the buffer
set laststatus=2                      " enable statusline
set updatetime=100                    " set the update time of git-gutter
set spelllang=en_us,it                " set the language of spelling
let mapleader=" "                     " set leader key
let maplocalleader=" "                " set local leader key

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Statusline
""""""""""""""""""""""""""""""""""""""""""""""""""
" same as ruler (but with FugitiveStatus)
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""
" search operators for incsearch plugin
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" move across visual line
nnoremap j gj
nnoremap k gk

" disable Q for ex-mode
nnoremap Q <nop>

" move lines in all modes
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
nnoremap <C-k> :m .-2<CR>==
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-k> :m '<-2<CR>gv=gv

" open and load .vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" quick save
nnoremap <leader>ww :w<CR>
nnoremap <leader>wq :Wd<CR>

" quick exit
nnoremap <leader>qq :bd!<CR>
nnoremap <leader>QQ :q!<CR>
nnoremap <leader>QA :qa!<CR>

" quick search
nnoremap <leader>ff :%s/

" enforcing purity (!!)
noremap <Up>    <nop>
noremap <Down>  <nop>
noremap <Right> <nop>
noremap <Left>  <nop>

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" map custom function Append and Insert
nnoremap <silent> <leader>a :set opfunc=Append<CR>g@
nnoremap <silent> <leader>i :set opfunc=Insert<CR>g@

" map custom function VSetSearch
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" map Quickrun execution
nmap <leader>ee :QuickRun<CR>

" remap backspace to lats used buffer
nnoremap <BS> <C-^>

" map vim-fugive
nnoremap <space>gs :G <CR>

" open scratch
nnoremap <leader>oo :Scratch<CR>

" filter g output in a new buffer
nnoremap <leader>fg :Filter 

" map fzf
nnoremap <leader>pp :ProjectFiles<CR>
nnoremap <leader>po :Tags<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pl :Rg<CR>
nnoremap <leader>pf :Rg<C-R><C-W><CR>
nnoremap <leader>gi :GFiles<CR>
nnoremap <leader>ss :GFiles?<CR>

" vimviki
nmap <leader>wm <Plug>VimwikiIndex
nnoremap <leader>wf :VWS /


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Commands 
""""""""""""""""""""""""""""""""""""""""""""""""""
" filter in a new buffer results
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a | execute ":normal ggdd"

" overwrite fzf Files to serach in project dir
command! ProjectFiles execute 'Files' s:FindGitRoot()

" open custom Scratch
command! Scratch call s:DScratch()

" define close behaviour for buffers
command!  Wd write|bdelete


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Functions 
""""""""""""""""""""""""""""""""""""""""""""""""""
" Append -> append at the end of object (es. bracket)
function! Append(type, ...)
    normal! `]
    if a:type == 'char'
        call feedkeys("a", 'n')
    else
        call feedkeys("o", 'n')
    endif
endfunction

" Insert -> insert at the beginning of object (es. bracket)
function! Insert(type, ...)
    normal! `[
    if a:type == 'char'
        call feedkeys("i", 'n')
    else
        call feedkeys("O", 'n')
    endif
endfunction

" VSetSearch -> in visual mode use '*' and '#' to search for highlighted word
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
endfunction

" DScratch -> create a scratch buffer
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

" ToggleWindow -> open buffer in another window
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

" FindGitRoot -> find the root of a project
function! s:FindGitRoot()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

" SearchantStp -> play nicely with incsearch
function SearchantStop()
  :execute "normal \<Plug>SearchantStop"
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Plug-in Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""
" InSearch
let g:incsearch#auto_nohlsearch = 1                          " disable higlight when searching is done

" Quickrun
let g:quickrun_config = {
    \'*': {
    \'hook/time/enable': 1,
    \'hook/time/format': '[Finished in %gs]',
    \'outputter/buffer/split': ':below 9split',
    \'ouputter/buffer/into': 1,
    \}}                                                      " set options for quickrun

" DelimitMate
let g:delimitMate_expand_cr = 2                              " turns on <CR> expansion
let g:delimitMate_expand_space = 1                           " turns on <Space> expansion

" Emmet
let g:user_emmet_mode='nv'                                   " enable emmet only in normal and visual mode
let g:user_emmet_leader_key='<leader>'                       " changes emmet leader key

" Netrw
let g:netrw_banner=0                                         " suppress the banner
let g:netrw_liststyle=3                                      " tree style listing
let g:netrw_browse_split=4                                   " the split is always vertical
let g:netrw_winsize=20                                       " new win size is at 20%

" Gutentags
let g:gutentags_add_ctrlp_root_markers=0                     " disable automatic markers for ctrlp
let g:gutentags_generate_on_empty_buffer=1                   " generate tags when opening vim

" vimwiki
let g:vimwiki_list = [{'path': '~/Documents/VimWiki/terme.wiki'}]


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme
let g:onedark_termcolors=16           " use terminal colors for colorscheme (put before colorscheme)
colorscheme onedark                   " enable onedark colorscheme


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Auto Commands
""""""""""""""""""""""""""""""""""""""""""""""""""
au InsertEnter * set norelativenumber                                 " when in insert mode absolute numbering
au InsertLeave * set relativenumber                                   " when in normal mode relative numbering
au CursorMoved * call SearchantStop()                                 " stop custom highlight on matched pattern
au FileType * set fo-=c fo-=r fo-=o                                   " disable autoformat comments in newline
au FileType *.py let b:delimitMate_nesting_quotes = ['"',"'"]         " triplicate quotes for python
au FileType *.wiki, *.md setlocal spell                               " set spelling while editing verbose files
au BufRead,BufNewFile * setlocal signcolumn=yes                       " always show the space for git gutter
au BufRead,BufNewFile *.js, *.html, *.css, *.json set ts=2 sw=2 sts=2 " 2 space indent for web dev
au BufRead,BufNewFile *.py set ts=4 sw=4 sts=4                        " 4 space indent for python


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Templates
""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile *.py 0r ~/.dotfiles/.vim/templates/python.template      " use python templates for vim
