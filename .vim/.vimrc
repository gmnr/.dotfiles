""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"    __   _(_)_ __ ___  _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"   (_)_/ |_|_| |_| |_|_|  \___|
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" @gmnr
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
set nocompatible                                                      " set no compatible
syntax on                                                             " enable syntax
filetype plugin indent on                                             " recognize filetype/load plugin/indent
set t_Co=256                                                          " set teminal colors
set cmdheight=2                                                       " set command height to 2 lines
set cursorline                                                        " enable cursorline
set ttyfast                                                           " improve smoothness of redrawing
set completeopt=menu                                                  " set insert mode completion mode
set showmatch                                                         " show matching bracket when inserting one
set showcmd                                                           " show commands in the last line
set lazyredraw                                                        " do not redraw the screen while executing macros
set redrawtime=10000                                                  " time in milliseconds to redraw the screen
set encoding=utf-8                                                    " set encoding utf-8
set breakindent                                                       " wrapped lines will be visually indented
set nrformats-=octal                                                  " remove the octal notation from the number formats
set wildmenu                                                          " enable wildmenu
set wildmode=list:longest,full                                        " set wildmenu options
set wildignorecase                                                    " ignore case while completing files and dirs
set rtp+=/usr/local/opt/fzf                                           " add fzf to runtimepath
set noswapfile                                                        " disable swapfiles
set hlsearch                                                          " enable search highlihgt
set ignorecase                                                        " ignore case for search
set smartcase                                                         " override ignorecase if capital in search pattern
set incsearch                                                         " while typing a search show where the pattern matches
set shortmess=a                                                       " enable count message while searching
set ttimeout                                                          " set timing for key combinations
set timeoutlen=3000                                                   " time in milliseconds waited for a key sequence to complete
set ttimeoutlen=100                                                   " time in milliseconds waited for a key sequence to complete
set number                                                            " set line numbers
set history=1000                                                      " set the size of the history table
set undolevels=1000                                                   " maximum number of changes that can be undone
set hidden                                                            " set hidden buffer
set wrap                                                              " lines longer than windows width continue on the next line
set linebreak                                                         " break lines not at character but at 'breakat'
set nolist                                                            " don't show character of list mode (i.e. $ at end of line)
set expandtab                                                         " in insert mode use the correct number of spaces for tab
set shiftround                                                        " round indent to multiples of shiftwidth
set autoindent                                                        " copy indent from the current line when starting a new line
set smartindent                                                       " smart autoindenting
set splitright                                                        " when splitting put the new one right the current
set gdefault                                                          " when substitutine the g flag is on by default
set nobackup                                                          " don't make a backup before overwriting a file
set noswapfile                                                        " don't create swapfiles
set nowritebackup                                                     " don't make backups before overwriting a file
set diffopt+=iwhite                                                   " turn off whitespaces compare and folding
set diffopt+=vertical
set diffopt+=filler                                                   " show filler lines in vimdiff
set diffopt+=internal
set diffopt+=indent-heuristic
set diffopt+=algorithm:patience
set viminfo="NONE"                                                    " don't show info after re-entering in the buffer
set laststatus=2                                                      " enable enough space in statusline
set updatetime=100                                                    " set the update time of git-gutter
set spelllang=en_us,it                                                " set the language of spelling
set spf=~/.vim/spell/en_us.utf-8.add                                  " set the correct directory for english
set spf=~/.vim/spell/it.utf-8.add                                     " set the correct directory for italian
let mapleader=" "                                                     " set leader key
let maplocalleader=" "                                                " set local leader key

if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif


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

" fix Y behaviour
nmap Y y$

" move across visual lines
nnoremap j gj
nnoremap k gk

" disable Q for ex-mode
nnoremap Q <nop>

" open and load .vimrc
nnoremap <leader>ev :e ~/.dotfiles/.vim/.vimrc<CR>
nnoremap <leader>sv :so $MYVIMRC<CR>

" quick save and exit
nnoremap <leader>ww :w<CR>
nnoremap <leader>qq :bd!<CR>
nnoremap <leader>wq :Wd<CR>
nnoremap <leader>QQ :q!<CR>

" quick search
nnoremap <leader>ff :%s/

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" map custom function VSetSearch
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" remap backspace to lats used buffer
nnoremap <BS> <C-^>

" map vim-fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>
nnoremap <leader>gc :GBranches<CR>

" map fzf
nnoremap <leader>pp :ProjectFiles<CR>
nnoremap <leader>pt :Tags<CR>
nnoremap <leader>po :Buffers<CR>
nnoremap <leader>pl :Rg<CR>
nnoremap <leader>ps :GFiles?<CR>
nnoremap <leader>pg :GFiles<CR>

" vimviki
nmap <leader>wm <Plug>VimwikiIndex
nmap <Leader>wo <Plug>Vimwiki2HTMLBrowse
nnoremap <leader>wf :VWS /

" change the current directory to edited file
nmap <leader>cd :cd %:h<CR>

" add autocorrect
nmap <leader><Tab> 1z=

" quickrun
nnoremap <leader>r :QuickRun<CR>

" toggle paste
nnoremap <leader>yy :set invpaste paste?<CR>

" change mappings for location list navigation
nnoremap [w :lprevious<CR>
nnoremap ]w :lnext<CR>
nnoremap [W :lfirst<CR>
nnoremap ]W :llast<CR>

" change prefix for window navigation
nnoremap <leader>a <C-w>


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Commands
""""""""""""""""""""""""""""""""""""""""""""""""""
" overwrite fzf Files to serach in project dir
command! ProjectFiles execute 'Files' s:FindGitRoot()

" save and close buffer
command! Wd write|bdelete

" grep abbreviation
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Functions
""""""""""""""""""""""""""""""""""""""""""""""""""
" VSetSearch -> in visual mode use '*' and '#' to search for highlighted word
function! s:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
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
let g:incsearch#auto_nohlsearch = 1                                   " disable higlight when searching is done

" Quickrun
let g:quickrun_config = {
    \'*': {
    \'hook/time/enable': 1,
    \'hook/time/format': '[Finished in %gs]',
    \'outputter/buffer/opener': '%{"bel 12new"}'}}                    " set options for quickrun

" DelimitMate
let g:delimitMate_expand_cr = 2                                       " turns on <CR> expansion
let g:delimitMate_expand_space = 1                                    " turns on <Space> expansion

" Emmet
let g:user_emmet_mode='nv'                                            " enable emmet only in normal and visual mode
let g:user_emmet_leader_key='<leader>'                                " changes emmet leader key

" Gutentags
let g:gutentags_add_ctrlp_root_markers=0                              " disable automatic markers for ctrlp
let g:gutentags_generate_on_empty_buffer=1                            " generate tags when opening vim

" Vimwiki
let g:vimwiki_global_ext = 0                                          " vimwiki only overrides .wiki files
let g:vimwiki_list = [{
    \ 'path': '~/Documents/VimWiki/gmnr',
    \ 'ext': '.wiki',
    \ 'template_path': '~/Documents/VimWiki/templates',
    \ 'template_default': 'default',
    \ 'template_ext': '.html'}]

" git gutter
let g:gitgutter_sign_added = '█|'
let g:gitgutter_sign_modified = '█⫶'
let g:gitgutter_sign_removed = '█▁'
let g:gitgutter_sign_removed_first_line = '█▔'
let g:gitgutter_sign_modified_removed = "█▟"

" hardtime (only temporary)
let g:hardtime_default_on = 1                                         " enable to master the 'true' way
let g:hardtime_maxcount = 10

" indentline
let g:indentLine_char_list = ['▏']                               " select chars to draw at indentation
let g:indentLine_bufTypeExclude = ['help', 'terminal']                " exlude certain buffer type from indentline
let g:indentLine_fileTypeExclude = ['txt', 'vimwiki', 'sh']           " don't use indentline on plain files


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Colorscheme
""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme
let g:onedark_termcolors=16                                           " use terminal colors for colorscheme (put before colorscheme)
colorscheme onedark                                                   " enable onedark colorscheme

highlight Comment cterm=italic gui=italic


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Auto Commands
""""""""""""""""""""""""""""""""""""""""""""""""""
au InsertEnter * set norelativenumber                                 " when in insert mode absolute numbering
au InsertLeave * set relativenumber                                   " when in normal mode relative numbering
au CursorMoved * call SearchantStop()                                 " stop custom highlight on matched pattern
au FileType * set fo-=c fo-=r fo-=o                                   " disable autoformat comments in newline
au FileType * setlocal signcolumn=yes                                 " always show the space for git gutter
au FileType vimwiki,markdown setlocal spell                           " set spelling while editing verbose files
au FileType vimwiki au BufWritePost <buffer> silent Vimwiki2HTML      " auto export to html when saving
au FileType javascript,html,css,json setlocal ts=2 sw=2 sts=2         " 2 space indent for web dev
au FileType python setlocal ts=4 sw=4 sts=4                           " 4 space indent for python

augroup init_quickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
augroup END

augroup statusline
    autocmd!
    autocmd WinEnter,BufEnter * setlocal cul
    autocmd WinLeave,BufLeave * setlocal nocul
augroup END


""""""""""""""""""""""""""""""""""""""""""""""""""
"  =>  Templates
""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile *.py 0r ~/.dotfiles/.vim/templates/python.template      " use python templates for vim
