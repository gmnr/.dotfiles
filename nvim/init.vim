"-------------------------------------------------
"    __   _(_)_ __ ___ _ __ ___
"   \ \ / / | '_ ` _ \| '__/ __|
"    \ V /| | | | | | | | | (__
"   (_)_/ |_|_| |_| |_|_|  \___|
"-------------------------------------------------
" @Author: gmnr

"  Basic Config{{{
"-------------------------------------------------
syntax on                                                             " enable syntax
filetype plugin indent on                                             " recognize filetype/load plugin/indent
set cmdheight=2                                                       " set command height to 2 lines
set cursorline                                                        " enable cursorline
set showmatch                                                         " show matching bracket when inserting one
set noshowmode                                                        " hide mode message in last line
set lazyredraw                                                        " do not redraw the screen while executing macros
set breakindent                                                       " wrapped lines will be visually indented
set nrformats-=octal                                                  " remove the octal notation from the number formats
set signcolumn=yes
set wildmode=longest:full,full                                        " set wildmenu options
set wildignorecase                                                    " ignore case while completing files and dirs
set noswapfile                                                        " disable swapfiles
set ignorecase                                                        " ignore case for search
set smartcase                                                         " override ignorecase if capital in search pattern
set shortmess=a                                                       " enable count message while searching
set ttimeout                                                          " set timing for key combinations
set number                                                            " set line numbers
set undolevels=1000                                                   " maximum number of changes that can be undone
set hidden                                                            " set hidden buffer
set wrap                                                              " lines longer than windows width continue on the next line
set linebreak                                                         " break lines not at character but at 'breakat'
set nolist                                                            " don't show character of list mode (i.e. $ at end of line)
set expandtab                                                         " in insert mode use the correct number of spaces for tab
set shiftround                                                        " round indent to multiples of shiftwidth
set ts=2                                                              " set tabstop equals to 2
set sts=2                                                             " set soft tab stops equals to 2
set sw=2                                                              " set shiftwidth equals to 2
set formatoptions-=a                                                  " don't format paragraphs automatically
set formatoptions+=t                                                  " autowrap if textwidth is exceeded
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
set spelllang=en_us,it                                                " set the language of spelling
set spf=~/.vim/spell/en_us.utf-8.add                                  " set the correct directory for english
set spf=~/.vim/spell/it.utf-8.add                                     " set the correct directory for italian
let mapleader=" "                                                     " set leader key
let maplocalleader=" "                                                " set local leader key
let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"    " set cursor for normal mode
let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"    " set cursor for insert mode
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"    " set cursor for replace mode

if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"}}}
"  Imports{{{
"-------------------------------------------------
runtime ./plug.vim
runtime ./maps.vim

"}}}
"  Colorscheme{{{
"-------------------------------------------------
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

colorscheme onedark

" add colors to types in autocompletion
highlight! CmpItemAbbrDeprecated guibg=NONE guifg=#808080	
highlight! CmpItemAbbrMatch      guibg=NONE guifg=#98C379
highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#98C379
highlight! CmpItemKindInterface  guibg=NONE guifg=#98C379
highlight! CmpItemKindUnit       guibg=NONE guifg=#98C379
highlight! CmpItemKindFunction   guibg=NONE guifg=#C678DD
highlight! CmpItemKindKeyword    guibg=NONE guifg=#C678DD
highlight! CmpItemKindMethod     guibg=NONE guifg=#E06C75
highlight! CmpItemKindProperty   guibg=NONE guifg=#E06C75
highlight! CmpItemKindVariable   guibg=NONE guifg=#61AFEF
highlight! CmpItemKindText       guibg=NONE guifg=#ABB2BF
highlight! CmpItemKindClass      guibg=NONE guifg=#E5C07B

" modify spell error highlighings
highlight! SpellBad   guibg=NONE guifg=#E5C07B
highlight! SpellCap   guibg=NONE guifg=#E5C07B
highlight! SpellLocal guibg=NONE guifg=#E5C07B
highlight! SpellRare  guibg=NONE guifg=#E5C07B

"}}}
"  Commands{{{
"-------------------------------------------------
" save and close buffer
command! Wd write|bdelete

" grep abbreviation
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'

"}}}
"  Plug-in Configuration{{{
"-------------------------------------------------
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

" taskwiki
let g:taskwiki_dont_fold = 'yes'

" indentline
let g:indentLine_char_list = ['▏']                                    " select chars to draw at indentation
let g:indentLine_bufTypeExclude = ['help', 'terminal']                " exlude certain buffer type from indentline
let g:indentLine_fileTypeExclude = ['txt', 'vimwiki', 'sh', 'markdown']           " don't use indentline on plain files

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 1
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

"}}}
"  Auto Commands{{{
"-------------------------------------------------
au FileType * set fo-=c fo-=r fo-=o                                   " disable autoformat comments in newline
au FileType vimwiki,markdown setlocal spell                           " set spelling while editing verbose files
au FileType vimwiki,markdown setlocal tw=80                           " set default textwidth
au FileType vimwiki,markdown setlocal cocu="c"                   " set conceal cursor for markdown and vimwiki files
au FileType vimwiki au BufWritePost <buffer> silent Vimwiki2HTML      " auto export to html when saving
au FileType vim setlocal foldmethod=marker                            " set manual folding for .vimrc
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

"}}}
"  Templates{{{
"-------------------------------------------------
au BufNewFile *.py 0r ~/.dotfiles/vim/templates/python.template      " use python templates for vim}}}
