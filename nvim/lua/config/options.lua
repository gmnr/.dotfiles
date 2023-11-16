-- OPTIONS
-- basic options
vim.opt.number = true -- enable numbering
vim.opt.termguicolors = true -- enable termguicolors
vim.opt.shiftround = true -- round indent to multiples of shiftwidth
vim.opt.cursorline = true -- enable cursorline
vim.opt.ignorecase = true -- ignore case
vim.opt.smartcase = true -- override ignorecase if capital in search pattern
vim.opt.expandtab = true -- use spaces while tabbing
vim.opt.lazyredraw = true -- don't redraw screen while executing macros
vim.opt.gdefault = true -- when substituting the g flag is always enabled
vim.opt.smartindent = true -- smart autoindenting
vim.opt.splitright = true -- open next window to the right of current one
vim.opt.showmode = false -- hide mode on last row
vim.opt.swapfile = false -- disable swapfile
vim.opt.signcolumn = "yes" -- always enable signcolumn
vim.opt.tabstop = 2 -- number of spaces a tab counts for
vim.opt.shiftwidth = 2 -- number of spaces of each indentation level
vim.opt.softtabstop = 2 -- insert spaces when tabbing
vim.opt.scrolloff = 999 -- keep cursor in the middle of the line
vim.opt.wildignorecase = true -- ignore case when writing commands
vim.opt.complete = "" -- disable ordinary autocompletion
vim.opt.conceallevel = 2 -- enable concealing

-- diff options
vim.opt.diffopt = "filler,iwhite,internal,algorithm:patience"

-- spelling
vim.opt.spelllang = "en_us,it" -- set language of spell
vim.opt.spellcapcheck = "" -- don't check cap error at beginning of line

-- grep settings (use ripgrep)
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"

