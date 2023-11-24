-- MAPPINGS
local opts = { silent = true }

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- improve performance of leader key
vim.g.mapleader = " "

-- fix Y behaviour
vim.keymap.set("n", "Y", "y$")

-- clear search with esc
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")

-- remap redo command
vim.keymap.set("n", "<C-p>", "<C-r>")

-- override scrolling
vim.keymap.set("n", "<C-f>", "<C-u>")
vim.keymap.set("n", "<C-s>", "<C-d>")

-- open and load .vimrc
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope find_files cwd=~/.dotfiles/nvim<CR>", opts)
vim.keymap.set(
  "n",
  "<leader>fn",
  '<cmd>lua annotate()<CR><cmd>exe "e +$ ~/.notes/notepad/".strftime("%Y%m%d").".md"<CR>',
  opts
)
vim.keymap.set("n", "<leader>fu", "<cmd>Lazy<CR>", opts)

-- open notes
vim.keymap.set("n", "<leader>yn", "<cmd>Telescope find_files cwd=~/.notes<CR>", opts)

-- quick save and exit
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>wq", "<cmd>WRCL<CR>", opts)
vim.keymap.set("n", "<leader>qq", "<cmd>bd!<CR>", opts)
vim.keymap.set("n", "<leader>QQ", "<cmd>q!<CR>", opts)
vim.keymap.set("n", "<leader>WQ", "<cmd>wq!<CR>", opts)
vim.keymap.set("n", "<leader>QA", "<cmd>qa!<CR>", opts)

-- open and close quickfix and location list
vim.keymap.set("n", "<leader>qo", "<cmd>cope<CR>", opts)
vim.keymap.set("n", "<leader>qc", "<cmd>ccl<CR>", opts)
vim.keymap.set("n", "<leader>lo", "<cmd>lopen<CR>", opts)
vim.keymap.set("n", "<leader>lc", "<cmd>lclose<CR>", opts)

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/")

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", "<C-^>")

-- map vim-fugitive
vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>", opts)
vim.keymap.set("n", "<leader>gy", "<cmd>Git push<CR>", opts)
vim.keymap.set("n", "<leader>gf", "<cmd>diffget //2<CR>", opts)
vim.keymap.set("n", "<leader>gu", "<cmd>diffget //3<CR>", opts)

-- telescope mappings
vim.keymap.set("n", "<leader>yg", ":silent grep ")
vim.keymap.set("n", "<leader>yu", ":Telescope ")
vim.keymap.set("n", "<leader>yy", "<cmd>Telescope resume<CR>", opts)
vim.keymap.set("n", "<leader><space>", "<cmd>lua project_files()<CR>", opts)
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<leader>;", "<cmd>Telescope commands<CR>", opts)
vim.keymap.set("n", "<leader>,", "<cmd>Telescope buffers<CR>", opts)
vim.keymap.set("n", "<leader>ya", "<cmd>Telescope find_files<CR>", opts)
vim.keymap.set("n", "<leader>yd", "<cmd>Telescope diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>ys", "<cmd>Telescope git_status<CR>", opts)
vim.keymap.set("n", "<leader>yc", "<cmd>Telescope git_branches<CR>", opts)
vim.keymap.set("n", "<leader>yh", "<cmd>Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<leader>yf", "<cmd>Telescope file_browser<CR>", opts)

-- change the current directory to edited file
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "1z=")

-- quickrun
vim.keymap.set("n", "<leader>ff", "<cmd>w<CR><cmd>QuickRun<CR>", opts)

-- toggle paste and manage copy
vim.keymap.set("n", "<leader>jj", "<cmd>set invpaste paste?<CR>", opts)
vim.keymap.set("n", "<leader>cp", "<cmd>w !pbcopy<CR>", opts)

-- change mappings for location list navigation
vim.keymap.set("n", "[w", "<cmd>lprevious<CR>", opts)
vim.keymap.set("n", "]w", "<cmd>lnext<CR>", opts)
vim.keymap.set("n", "[W", "<cmd>lfirst<CR>", opts)
vim.keymap.set("n", "]W", "<cmd>llast<CR>", opts)

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

-- hledger plugs
vim.keymap.set("n", "<leader>ef", "<cmd>lua better_ledger_align()<CR>", opts)
vim.keymap.set("n", "<leader>ee", "<cmd>e +$ ~/.finance/periods/2023.journal<CR>", opts)
vim.keymap.set("n", "<leader>ea", "<cmd>lua hledger_update()<CR>", opts)

-- gitsigns
vim.keymap.set("n", "<leader>hh", "<cmd>Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<leader>hb", "<cmd>Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>hB", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
vim.keymap.set("n", "<leader>hQ", "<cmd>Gitsigns stage_buffer<CR>", opts)
vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", opts)
vim.keymap.set("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>", opts)
vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>hq", "<cmd>Gitsigns stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "]c", '&diff ? "]c" : ":Gitsigns next_hunk<CR>"', { expr = true, silent = true })
vim.keymap.set("n", "[c", '&diff ? "[c" : ":Gitsigns prev_hunk<CR>"', { expr = true, silent = true })

--  silence grep when grepping
vim.cmd("cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'")
vim.cmd("cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'")

-- lsp
vim.keymap.set("n", "E", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>lL", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
