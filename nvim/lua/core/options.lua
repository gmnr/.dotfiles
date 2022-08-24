-- basics
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
vim.opt.number        = true -- enable numbering
vim.opt.termguicolors = true -- enable termguicolors
vim.opt.shiftround    = true -- 
vim.opt.updatetime    = 100  -- 
vim.opt.cursorline    = true -- enable cursorline
vim.opt.ignorecase    = true -- ignore 
vim.opt.smartcase     = true
vim.opt.expandtab     = true
vim.opt.hlsearch      = false
-- vim.opt.autowrite       = true

-- tabs
vim.opt.autoindent      = true
vim.opt.tabstop         = 2
vim.opt.shiftwidth      = 2
vim.opt.softtabstop     = 2

-- disable some useless standard plugins to save startup time these features are better covered by plugins
vim.g.loaded_matchparen        = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_gzip              = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_shada_plugin      = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_remote_plugins    = 1

-- old config
-- set cmdheight=2                                       " set command height
-- set showmatch                                         " show matching bracket when inserting one
-- set noshowmode                                        " hide mode message in last line
-- set nomodeline                                        " disable modeline
-- set lazyredraw                                        " do not redraw the screen when executing macros
-- set scrolloff=999                                     " keep working line always at the middle of the screen
-- set breakindent                                       " wrapped lines will be visually indented
-- set nrformats-=octal                                  " remove the octal notation from the number formats
-- set signcolumn=yes                                    " always draw the signcolumn
-- set wildmode=longest:full,full                        " set wildmenu options
-- set wildignorecase                                    " ignore case when completing files and dirs
-- set noswapfile                                        " disable swapfiles
-- set shortmess=a                                       " enable count message while searching
-- set ttimeout                                          " set timing for key combinations
-- set undolevels=1000                                   " maximum number of changes that can be undone
-- set wrap                                              " lines longer than win width continue on the next line
-- set linebreak                                         " break lines not at character but at 'breakat'
-- set expandtab                                         " in insert mode use the correct number of spaces for tab
-- set formatoptions-=a                                  " don't format paragraphs automatically
-- set formatoptions+=t                                  " autowrap if textwidth is exceeded
-- set smartindent                                       " smart autoindenting
-- set splitright                                        " when splitting put the new one right the current
-- set gdefault                                          " when substitutine the g flag is on by default
-- set nobackup                                          " don't make a backup before overwriting a file
-- set noswapfile                                        " don't create swapfiles
-- set nowritebackup                                     " don't make backups before overwriting a file
-- set completeopt=menu,menuone,noselect                 " add completion settings
-- set diffopt+=iwhite                                   " turn off whitespaces compare and folding
-- set diffopt+=vertical                                 " show diff in vertival splits
-- set diffopt+=filler                                   " show filler lines in vimdiff
-- set spelllang=en_us,it                                " set the language of spelling
-- set spf=~/.vim/spell/en_us.utf-8.add                  " set the correct directory for english
-- set spf=~/.vim/spell/it.utf-8.add                     " set the correct directory for italian
-- set viminfo="NONE"                                    " don't show info after re-entering in the buffer

-- if executable("rg")
--   set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
--   set grepformat=%f:%l:%c:%m,%f:%l:%m
-- endif
