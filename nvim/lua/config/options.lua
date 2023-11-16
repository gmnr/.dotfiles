-- OPTIONS
-- enable numbering
vim.opt.number = true

-- enable termguicolors
vim.opt.termguicolors = true

-- round indent to multiples of shiftwidth
vim.opt.shiftround = true

-- enable cursorline
vim.opt.cursorline = true

-- ignore case
vim.opt.ignorecase = true

-- override ignorecase if capital in search pattern
vim.opt.smartcase = true

-- use spaces while tabbing
vim.opt.expandtab = true

-- don't redraw screen while executing macros
vim.opt.lazyredraw = true

-- when substituting the g flag is always enabled
vim.opt.gdefault = true

-- smart autoindenting
vim.opt.smartindent = true

-- open next window to the right of current one
vim.opt.splitright = true

-- hide mode on last row
vim.opt.showmode = false

-- disable swapfile
vim.opt.swapfile = false

-- always enable signcolumn
vim.opt.signcolumn = "yes"

-- number of spaces a tab counts for
vim.opt.tabstop = 2

-- number of spaces of each indentation level
vim.opt.shiftwidth = 2

-- insert spaces when tabbing
vim.opt.softtabstop = 2

-- keep cursor in the middle of the line
vim.opt.scrolloff = 999

-- ignore case when writing commands
vim.opt.wildignorecase = true

-- disable ordinary autocompletion
vim.opt.complete = ""

-- enable concealing
vim.opt.conceallevel = 2

-- diff options
vim.opt.diffopt = "filler,iwhite,internal,algorithm:patience"

-- set language of spell
vim.opt.spelllang = { "en_us", "it" }

-- don't check cap error at beginning of line
vim.opt.spellcapcheck = ""

-- grep settings (use ripgrep)
vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
vim.opt.grepformat = "%f:%l:%c:%m"
