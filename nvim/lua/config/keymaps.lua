-- MAPPINGS
local opts = { silent = true }

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false }) -- improve performance of leader key
vim.g.mapleader = " "

-- duplicate line and comment
vim.keymap.set("n", "ycc", "yygccp", { remap = true })

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z:delmarks z<cr>")

-- remap redo command
vim.keymap.set("n", "<C-p>", "<C-r>")

-- override scrolling
vim.keymap.set("n", "<C-f>", "<C-u>")

-- open and load .vimrc
vim.keymap.set("n", "<leader>fu", "<cmd>Lazy<CR>", opts)

-- quick save and exit
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>wq", "<cmd>wq!<CR>", opts)
vim.keymap.set("n", "<leader>qq", "<cmd>bd!<CR>", opts)
vim.keymap.set("n", "<leader>QQ", "<cmd>q!<CR>", opts)
vim.keymap.set("n", "<leader>QA", "<cmd>qa!<CR>", opts)

-- disable keys navigaton keys
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", opts)
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", opts)
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", opts)
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", opts)

-- navigate virtually wrapped lines
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/")

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", "<C-^>")

-- map vim-fugitive
vim.keymap.set("n", "<leader>gg", "<cmd>vertical Git<CR>", opts)
vim.keymap.set("n", "<leader>gy", "<cmd>Git push<CR>", opts)

-- change the current directory to edited file
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "[s1z=")

-- quickrun
vim.keymap.set("n", "<leader>ff", "<cmd>w<CR><cmd>QuickRun<CR>", opts)

-- toggle paste and manage copy
vim.keymap.set("n", "<leader>jj", "<cmd>set invpaste paste?<CR>", opts)
vim.keymap.set("n", "<leader>cp", "<cmd>w !pbcopy<CR>", opts)

-- swap fold command
vim.keymap.set("n", "za", "zo")
vim.keymap.set("n", "zo", "za")

-- hledger plugs
vim.keymap.set("n", "<leader>ea", "<cmd>lua Hledger_CR()<CR>", opts)
vim.keymap.set("n", "<leader>ee", "<cmd>e +$ ~/.finance/periods/2025.journal<CR>", opts)
vim.keymap.set("n", "<leader>eu", "<cmd>lua hledger_update()<CR>", opts)

-- use mason
vim.keymap.set("n", "<leader>fy", "<cmd>Mason<CR>")

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
vim.keymap.set("n", "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<CR>", opts)
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", opts)
