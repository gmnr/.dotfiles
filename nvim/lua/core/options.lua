-- load vim.opt into variable
local opt = vim.opt

-- basic options
opt.number                     = true  -- enable numbering
opt.termguicolors              = true  -- enable termguicolors
opt.shiftround                 = true  -- round indent to multiples of shiftwidth
opt.cursorline                 = true  -- enable cursorline
opt.ignorecase                 = true  -- ignore 
opt.smartcase                  = true  -- override ignorecase if capital in search pattern
opt.expandtab                  = true  -- use spaces while tabbing
opt.lazyredraw                 = true  -- don't redraw screen while executing macros
opt.gdefault                   = true  -- when substituting the g flag is always enabled
opt.smartindent                = true  -- smart autoindenting
opt.splitright                 = true  -- open next window to the right of current one
opt.showmode                   = false -- hide mode on last row
opt.swapfile                   = false -- disable swapfile
opt.signcolumn                 = 'yes' -- always enable signcolumn
opt.tabstop                    = 2     -- number of spaces a tab counts for
opt.shiftwidth                 = 2     -- number of spaces of each indentation level
opt.softtabstop                = 2     -- insert spaces when tabbing
opt.scrolloff                  = 999   -- keep cursor in the middle of the line
opt.wildignorecase             = true  -- ignore case when writing commands
opt.complete                   = ''    -- disable ordinary autocompletion
opt.conceallevel               = 2     -- enable concealing

-- diff options
opt.diffopt                    = 'filler,iwhite,internal,algorithm:patience'

-- preview opt
opt.completeopt                = 'menu,menuone,noselect'

-- spelling
opt.spelllang                  = 'en_us,it'  -- set language of spell

-- grep settings (use ripgrep)
opt.grepprg                    = 'rg --vimgrep --no-heading --smart-case'
opt.grepformat                 = '%f:%l:%c:%m,%f:%l:%m'

-- disable some useless standard plugins to save startup time these features are better covered by plugins
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
