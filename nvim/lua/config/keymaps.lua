-- MAPPINGS
local opts = { silent = true }

-- set leader
vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

-- keep cursor in place when joining lines
vim.keymap.set("n", "J", "mzJ`z:delmarks z<cr>")

-- enable scrolling with one hand
vim.keymap.set("n", "<C-f>", "<C-u>")

-- open and load Lazy
vim.keymap.set("n", "<leader>fu", "<cmd>Lazy<CR>", opts)

-- open Mason
vim.keymap.set("n", "<leader>fy", "<cmd>Mason<CR>")

-- quick save and exit
vim.keymap.set("n", "<leader>ww", "<cmd>w<CR>", opts)
vim.keymap.set("n", "<leader>wq", "<cmd>wq!<CR>", opts)
vim.keymap.set("n", "<leader>qq", "<cmd>bd!<CR>", opts)
vim.keymap.set("n", "<leader>QQ", "<cmd>q!<CR>", opts)
vim.keymap.set("n", "<leader>QA", "<cmd>qa!<CR>", opts)

-- quicker mappings
vim.keymap.set("n", "<leader>qk", function()
  require("quicker").toggle({ focus = true })
end, {})
vim.keymap.set("n", "<leader>ql", function()
  require("quicker").toggle({ loclist = true, focus = true })
end, {})

-- navigate virtually wrapped lines
vim.keymap.set("n", "j", "gj", opts)
vim.keymap.set("n", "k", "gk", opts)

--  quick search
vim.keymap.set("n", "<leader>tt", ":%s/")

-- disable highlight
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>noh<CR><esc>", opts)

-- remap backspace to lats used buffer
vim.keymap.set("n", "<BS>", function()
  require("modules.mru_buffers").goto_last()
end, opts)

-- add autocorrect
vim.keymap.set("n", "<leader><Tab>", "[s1z=")

-- quickrun
vim.keymap.set("n", "<leader>ff", "<cmd>w<CR><cmd>QuickRun<CR>", opts)

-- clipboard management
vim.keymap.set({ "n", "v", "x" }, "<leader>aa", function()
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" or mode == "\22" then
    vim.cmd('silent noau normal! "+y')
    print("Selection copied!")
  else
    vim.cmd('silent noau normal! gg"+yG')
    print("Buffer copied!")
  end
end)

-- hledger plugs
vim.keymap.set("n", "<leader>ea", "<cmd>e +$ ~/.finance/periods/2026.journal<CR>", opts)

-- gitsigns mappings
vim.keymap.set("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", opts)
vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)
vim.keymap.set("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<CR>", opts)
vim.keymap.set("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", opts)
vim.keymap.set("n", "<leader>gu", "<cmd>Gitsigns stage_hunk<CR>", opts)
vim.keymap.set({ "n", "v" }, "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
vim.keymap.set("n", "]c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "]c", bang = true })
  else
    require("gitsigns").nav_hunk("next")
  end
end, { silent = true, desc = "Next hunk" })
vim.keymap.set("n", "[c", function()
  if vim.wo.diff then
    vim.cmd.normal({ "[c", bang = true })
  else
    require("gitsigns").nav_hunk("prev")
  end
end, { silent = true, desc = "Previous hunk" })
