-- MAPPINGS
-- fix Y behaviour
vim.keymap.set("n", "Y", "y$")

-- saner line navigation
vim.keymap.set("n", "M", "^")
vim.keymap.set("n", "I", "$")

-- remap movement for colemak
vim.keymap.set({ "n", "v" }, "m", "h")
vim.keymap.set({ "n", "v" }, "n", "gj") -- with movement across visual line
vim.keymap.set({ "n", "v" }, "e", "gk") -- with movement across visual line
vim.keymap.set({ "n", "v" }, "i", "l")

-- remap old hjkl & capital
vim.keymap.set({ "n", "v" }, "h", "e")
vim.keymap.set({ "n", "v" }, "j", "m")
vim.keymap.set({ "n", "v" }, "k", "n")
vim.keymap.set({ "n", "v" }, "l", "i")
vim.keymap.set({ "n", "v" }, "H", "E")
vim.keymap.set({ "n", "v" }, "K", "N")
vim.keymap.set({ "n", "v" }, "L", "I")
vim.keymap.set({ "n", "v" }, "N", "J")

-- remap redo command
vim.keymap.set("n", "<C-p>", "<C-r>")

-- override scrolling
vim.keymap.set("n", "<C-f>", "<C-u>")
vim.keymap.set("n", "<C-s>", "<C-d>")

-- open and load .vimrc
vim.keymap.set(
	"n",
	"<leader>fc",
	':lua require("telescope.builtin").find_files({cwd="~/.dotfiles/nvim/lua/"})<CR>',
	{ silent = true }
)
vim.keymap.set(
	"n",
	"<leader>fn",
	':lua Annotate()<CR>:exe "e +$ ~/.notes/notepad/".strftime("%Y%m%d").".md"<CR>',
	{ silent = true }
)
vim.keymap.set("n", "<leader>fu", ":Lazy<CR>")

-- open notes
vim.keymap.set(
	"n",
	"<leader>pl",
	':lua require("telescope.builtin").find_files({cwd="~/.notes"})<CR>',
	{ silent = true }
)

-- quick save and exit
vim.keymap.set("n", "<leader>ww", ":w<CR>")
vim.keymap.set("n", "<leader>wq", ":Wd<CR>")
vim.keymap.set("n", "<leader>qq", ":bd!<CR>")
vim.keymap.set("n", "<leader>QQ", ":q!<CR>")
vim.keymap.set("n", "<leader>QA", ":qa!<CR>")

-- open and close quickfix and location list
vim.keymap.set("n", "<leader>qo", ":cope<CR>")
vim.keymap.set("n", "<leader>qc", ":ccl<CR>")
vim.keymap.set("n", "<leader>lo", ":lopen<CR>")
vim.keymap.set("n", "<leader>lc", ":lclose<CR>")

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/")

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", "<C-^>")

-- map vim-fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>")
vim.keymap.set("n", "<leader>gy", ":Git push<CR>")
vim.keymap.set("n", "<leader>gm", ":diffget //2<CR>")
vim.keymap.set("n", "<leader>gi", ":diffget //3<CR>")

-- telescope mappings
vim.keymap.set("n", "<leader><space>", ":lua Project_files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>;", ":Telescope commands<CR>", { silent = true })
vim.keymap.set("n", "<leader>,", ":Telescope buffers<CR>", { silent = true })

vim.keymap.set("n", "<leader>ys", ":Telescope git_status<CR>", { silent = true })
vim.keymap.set("n", "<leader>yc", ":Telescope git_branches<CR>", { silent = true })
vim.keymap.set("n", "<leader>ya", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>yh", ":Telescope help_tags<CR>", { silent = true })
vim.keymap.set("n", "<leader>yg", ":silent grep ")
vim.keymap.set("n", "<leader>yu", ":Telescope ")

-- change the current directory to edited file
vim.keymap.set("n", "<leader>cd", ":cd %:h<CR>")

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "1z=")

-- quickrun
vim.keymap.set("n", "<leader>pp", ":w<CR>:QuickRun<CR>")

-- toggle paste and manage copy
vim.keymap.set("n", "<leader>jj", ":set invpaste paste?<CR>")
vim.keymap.set("n", "<leader>cp", ":w !pbcopy<CR>")

-- change mappings for location list navigation
vim.keymap.set("n", "[w", ":lprevious<CR>")
vim.keymap.set("n", "]w", ":lnext<CR>")
vim.keymap.set("n", "[W", ":lfirst<CR>")
vim.keymap.set("n", "]W", ":llast<CR>")

-- change prefix for window navigation
vim.keymap.set("n", "<leader>aa", "<C-w>w")
vim.keymap.set("n", "<leader>ao", "<C-w>o")
vim.keymap.set("n", "<leader>ac", "<C-w>c")
vim.keymap.set("n", "<leader>a-", "<C-w>v")
vim.keymap.set("n", "<leader>a=", "<C-w>s")
vim.keymap.set("n", "<leader>am", "<C-w>h")
vim.keymap.set("n", "<leader>an", "<C-w>j")
vim.keymap.set("n", "<leader>ae", "<C-w>k")
vim.keymap.set("n", "<leader>ai", "<C-w>l")

-- swap fold command
vim.keymap.set("n", "za", "zo")
vim.keymap.set("n", "zo", "za")

-- hledger formatting
vim.keymap.set("n", "<leader>bb", ":lua BetterLedgerAlign()<CR>")
vim.keymap.set(
	"n",
	"<leader>ba",
	":!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal payees > /Users/guido/.finance/.src/completion-source/payees<CR>",
	{ silent = true }
)
vim.keymap.set(
	"n",
	"<leader>bq",
	":!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal accounts | /usr/bin/python3 /Users/guido/.finance/.src/scripts/filter-account.py > /Users/guido/.finance/.src/completion-source/accounts<CR>",
	{ silent = true }
)

-- gitsigns
vim.keymap.set("n", "<leader>hp", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>")
vim.keymap.set("n", "<leader>hB", ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<leader>hS", ":Gitsigns stage_buffer<CR>")
vim.keymap.set("n", "<leader>hR", ":Gitsigns reset_buffer<CR>")
vim.keymap.set("n", "<leader>hd", ":Gitsigns diffthis<CR>")
vim.keymap.set("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>")
vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { silent = true })
vim.keymap.set("n", "]c", '&diff ? "]c" : ":Gitsigns next_hunk<CR>"', { expr = true })
vim.keymap.set("n", "[c", '&diff ? "[c" : ":Gitsigns prev_hunk<CR>"', { expr = true })

--  silence grep when grepping
vim.cmd("cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'")
vim.cmd("cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'")
