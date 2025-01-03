-- MAPPINGS
local opts = { silent = true }

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- improve performance of leader key
vim.g.mapleader = " "

-- fix Y behaviour
vim.keymap.set("n", "Y", "y$")

-- remap redo command
vim.keymap.set("n", "<C-p>", "<C-r>")

-- override scrolling
vim.keymap.set("n", "<C-f>", "<C-u>")

-- open and load .vimrc
vim.keymap.set("n", "<leader>fd", "<cmd>Telescope find_files cwd=~/.dotfiles<CR>", opts)
vim.keymap.set("n", "<leader>fu", "<cmd>Lazy<CR>", opts)

-- quick save and exit
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>wq", "<cmd>WRCL<CR>", opts)
vim.keymap.set("n", "<leader>qq", "<cmd>bd!<CR>", opts)
vim.keymap.set("n", "<leader>QQ", "<cmd>q!<CR>", opts)
vim.keymap.set("n", "<leader>WQ", "<cmd>wq!<CR>", opts)
vim.keymap.set("n", "<leader>QA", "<cmd>qa!<CR>", opts)

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/", { desc = "Search in buffer" })

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", "<C-^>")

-- map vim-fugitive
vim.keymap.set("n", "<leader>gg", "<cmd>vertical Git<CR>", opts)
vim.keymap.set("n", "<leader>gy", "<cmd>Git push<CR>", opts)

-- telescope mappings
vim.keymap.set("n", "<leader>yg", ":silent grep ", { desc = "Grep" })
vim.keymap.set("n", "<leader>yu", ":Telescope ", { desc = "Precompile Telescope" })
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
vim.keymap.set("n", "<leader>yx", "<cmd>Telescope ultisnips<CR>", opts)

-- change the current directory to edited file
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "[s1z=", { desc = "Quick spell" })

-- quickrun
vim.keymap.set("n", "<leader>ff", "<cmd>w<CR><cmd>QuickRun<CR>", opts)

-- toggle paste and manage copy
vim.keymap.set("n", "<leader>jj", "<cmd>set invpaste paste?<CR>", opts)
vim.keymap.set("n", "<leader>cp", "<cmd>w !pbcopy<CR>", opts)

-- change prefix for window navigation
vim.keymap.set("n", "<C-w>-", "<C-w>v")
vim.keymap.set("n", "<C-w>=", "<C-w>s")
vim.keymap.set("n", "<C-w>m", "<C-w>h")
vim.keymap.set("n", "<C-w>n", "<C-w>j")
vim.keymap.set("n", "<C-w>e", "<C-w>k")
vim.keymap.set("n", "<C-w>i", "<C-w>l")
vim.keymap.set("n", "<C-w>M", "<C-w>H")
vim.keymap.set("n", "<C-w>N", "<C-w>J")
vim.keymap.set("n", "<C-w>E", "<C-w>K")
vim.keymap.set("n", "<C-w>I", "<C-w>L")

-- swap fold command
vim.keymap.set("n", "za", "zo")
vim.keymap.set("n", "zo", "za")

-- hledger plugs
vim.keymap.set("n", "<leader>eu", "<cmd>lua Hledger_CR()<CR>", opts)
vim.keymap.set(
  "n",
  "<leader>ee",
  "<cmd>e +$ ~/.finance/periods/2024.journal<CR>",
  { desc = "Open current journal" },
  opts
)
vim.keymap.set("n", "<leader>ea", "<cmd>lua hledger_update()<CR>", opts)

-- gitsigns
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>gB", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
vim.keymap.set("n", "<leader>gQ", "<cmd>Gitsigns stage_buffer<CR>", opts)
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", opts)
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns undo_stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>gq", "<cmd>Gitsigns stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "]c", '&diff ? "]c" : ":Gitsigns next_hunk<CR>"', { expr = true, silent = true })
vim.keymap.set("n", "[c", '&diff ? "[c" : ":Gitsigns prev_hunk<CR>"', { expr = true, silent = true })

--  silence grep when grepping
vim.cmd("cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep'  : 'grep'")
vim.cmd("cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep' : 'lgrep'")

-- lsp
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<leader>ll", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>lL", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga outline<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
