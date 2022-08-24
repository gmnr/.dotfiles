-- basic options
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
vim.opt.splitright    = true  -- open next window to the right of current one
vim.opt.splitbelow    = true  -- open next window below the current one
vim.opt.showmode      = false -- hide mode on last row
vim.opt.hlsearch      = false -- disable highlight of search results
vim.opt.swapfile      = false -- disable swapfile
vim.opt.signcolumn    = 'yes' -- always enable signcolumn
vim.opt.tabstop       = 2     -- number of spaces a tab counts for
vim.opt.shiftwidth    = 2     -- number of spaces of each indentation level
vim.opt.softtabstop   = 2     -- insert spaces when tabbing
vim.opt.scrolloff     = 999   -- keep cursor in the middle of the line

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
