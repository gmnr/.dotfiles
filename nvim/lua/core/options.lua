-- options
vim.opt.number        = true  -- enable numbering
vim.opt.termguicolors = true  -- enable termguicolors
vim.opt.shiftround    = true  -- round indent to multiples of shiftwidth
vim.opt.cursorline    = true  -- enable cursorline
vim.opt.ignorecase    = true  -- ignore 
vim.opt.smartcase     = true  -- override ignorecase if capital in search pattern
vim.opt.expandtab     = true  -- use spaces while tabbing
vim.opt.lazyredraw    = true  -- don't redraw screen while executing macros
vim.opt.gdefault      = true  -- when substituting the g flag is always enabled
vim.opt.smartindent   = true  -- smart autoindenting
vim.opt.hlsearch      = false -- disable highlight of search results
vim.opt.swapfile      = false -- disable swapfile
vim.opt.tabstop       = 2     -- number of spaces a tab counts for
vim.opt.shiftwidth    = 2     -- number of spaces of each indentation level
vim.opt.softtabstop   = 2     -- insert spaces when tabbing

-- spelling
vim.opt.spelllang     = 'en_us,it'  -- set language of spell

-- grep settings (use ripgrep)
vim.opt.grepprg       = 'rg --vimgrep --no-heading --smart-case'
vim.opt.grepformat    = '%f:%l:%c:%m,%f:%l:%m'

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

-- set cmdheight=2                                       " set command height
-- set nomodeline                                        " disable modeline
-- set scrolloff=999                                     " keep working line always at the middle of the screen
-- set breakindent                                       " wrapped lines will be visually indented
-- set nrformats-=octal                                  " remove the octal notation from the number formats
-- set signcolumn=yes                                    " always draw the signcolumn
-- set wildmode=longest:full,full                        " set wildmenu options
-- set wildignorecase                                    " ignore case when completing files and dirs
-- set shortmess=a                                       " enable count message while searching
-- set ttimeout                                          " set timing for key combinations
-- set formatoptions-=a                                  " don't format paragraphs automatically
-- set formatoptions+=t                                  " autowrap if textwidth is exceeded
-- set splitright                                        " when splitting put the new one right the current
-- set nobackup                                          " don't make a backup before overwriting a file
-- set nowritebackup                                     " don't make backups before overwriting a file
-- set completeopt=menu,menuone,noselect                 " add completion settings
-- set diffopt+=iwhite                                   " turn off whitespaces compare and folding
-- set diffopt+=vertical                                 " show diff in vertival splits
-- set diffopt+=filler                                   " show filler lines in vimdiff
