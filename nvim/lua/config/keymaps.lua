-- MAPPINGS
local opts = { silent = true }
-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- improve performance of leader key
vim.g.mapleader = " "

-- fix Y behaviour
vim.keymap.set("n", "Y", "y$")

-- saner line navigation
vim.keymap.set("n", "M", "^")
vim.keymap.set("n", "I", "$")

-- remap movement for colemak
vim.keymap.set({ "n", "v" }, "m", "h")
vim.keymap.set({ "n", "v" }, "i", "l")
vim.keymap.set({ "n", "x" }, "n", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "e", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "v" }, "h", "e")
vim.keymap.set({ "n", "v" }, "j", "m")
vim.keymap.set({ "n", "v" }, "k", "n")
vim.keymap.set({ "n", "v" }, "l", "i")
vim.keymap.set({ "n", "v" }, "H", "E")
vim.keymap.set({ "n", "v" }, "K", "N")
vim.keymap.set({ "n", "v" }, "L", "I")
vim.keymap.set({ "n", "v" }, "N", "J")

-- clear search with esc
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- remap redo command
vim.keymap.set("n", "<C-p>", "<C-r>")

-- override scrolling
vim.keymap.set("n", "<C-f>", "<C-u>")
vim.keymap.set("n", "<C-s>", "<C-d>")

-- open and load .vimrc
vim.keymap.set(
  "n",
  "<leader>fd",
  ':lua require("telescope.builtin").find_files({cwd="~/.dotfiles/nvim/lua/"})<CR>',
  opts
)
vim.keymap.set("n", "<leader>fn", ':lua Annotate()<CR>:exe "e +$ ~/.notes/notepad/".strftime("%Y%m%d").".md"<CR>', opts)
vim.keymap.set("n", "<leader>fu", ":Lazy<CR>", opts)

-- open notes
vim.keymap.set("n", "<leader>pl", ':lua require("telescope.builtin").find_files({cwd="~/.notes"})<CR>', opts)

-- quick save and exit
vim.keymap.set("n", "<leader>ww", ":w<CR>", opts)
vim.keymap.set("n", "<leader>wq", ":Wd<CR>", opts)
vim.keymap.set("n", "<leader>qq", ":bd!<CR>", opts)
vim.keymap.set("n", "<leader>QQ", ":q!<CR>", opts)
vim.keymap.set("n", "<leader>QA", ":qa!<CR>", opts)

-- open and close quickfix and location list
vim.keymap.set("n", "<leader>qo", ":cope<CR>", opts)
vim.keymap.set("n", "<leader>qc", ":ccl<CR>", opts)
vim.keymap.set("n", "<leader>lo", ":lopen<CR>", opts)
vim.keymap.set("n", "<leader>lc", ":lclose<CR>", opts)

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/")

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", "<C-^>")

-- map vim-fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>", opts)
vim.keymap.set("n", "<leader>gy", ":Git push<CR>", opts)
vim.keymap.set("n", "<leader>gm", ":diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gi", ":diffget //3<CR>", opts)

-- telescope mappings
vim.keymap.set("n", "<leader><space>", ":lua Project_files()<CR>", opts)
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>;", ":Telescope commands<CR>", opts)
vim.keymap.set("n", "<leader>,", ":Telescope buffers<CR>", opts)

vim.keymap.set("n", "<leader>ys", ":Telescope git_status<CR>", opts)
vim.keymap.set("n", "<leader>yc", ":Telescope git_branches<CR>", opts)
vim.keymap.set("n", "<leader>ya", ":Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>yh", ":Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>yg", ":silent grep ")
vim.keymap.set("n", "<leader>yu", ":Telescope ")

-- change the current directory to edited file
vim.keymap.set("n", "<leader>cd", ":cd %:h<CR>", opts)

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "1z=")

-- quickrun
vim.keymap.set("n", "<leader>pp", ":w<CR>:QuickRun<CR>", opts)

-- toggle paste and manage copy
vim.keymap.set("n", "<leader>jj", ":set invpaste paste?<CR>", opts)
vim.keymap.set("n", "<leader>cp", ":w !pbcopy<CR>", opts)

-- change mappings for location list navigation
vim.keymap.set("n", "[w", ":lprevious<CR>", opts)
vim.keymap.set("n", "]w", ":lnext<CR>", opts)
vim.keymap.set("n", "[W", ":lfirst<CR>", opts)
vim.keymap.set("n", "]W", ":llast<CR>", opts)

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
vim.keymap.set("n", "<leader>ep", ":lua BetterLedgerAlign()<CR>", opts)
vim.keymap.set("n", "<leader>ee", ":e +$ ~/.finance/periods/2023.journal<CR>", opts)
vim.keymap.set(
  "n",
  "<leader>ea",
  ":!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal payees > /Users/guido/.finance/.src/completion-source/payees<CR>",
  opts
)
vim.keymap.set(
  "n",
  "<leader>eq",
  ":!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal accounts | /usr/bin/python3 /Users/guido/.finance/.src/scripts/filter-account.py > /Users/guido/.finance/.src/completion-source/accounts<CR>",
  opts
)

-- gitsigns
vim.keymap.set("n", "<leader>hh", ":Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<leader>hb", ":Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>hB", ":Gitsigns toggle_current_line_blame<CR>", opts)
vim.keymap.set("n", "<leader>hS", ":Gitsigns stage_buffer<CR>", opts)
vim.keymap.set("n", "<leader>hR", ":Gitsigns reset_buffer<CR>", opts)
vim.keymap.set("n", "<leader>hd", ":Gitsigns diffthis<CR>", opts)
vim.keymap.set("n", "<leader>hu", ":Gitsigns undo_stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "]c", '&diff ? "]c" : ":Gitsigns next_hunk<CR>"', { expr = true, silent = true })
vim.keymap.set("n", "[c", '&diff ? "[c" : ":Gitsigns prev_hunk<CR>"', { expr = true, silent = true })

--  silence grep when grepping
vim.cmd("cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'")
vim.cmd("cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'")

-- lsp
vim.keymap.set("n", "E", ":Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)
vim.keymap.set("n", "<leader>ll", ":Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>lL", ":Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>la", ":Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>lf", ":Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", opts)
