-- AUTOCOMMANDS
local api = vim.api

api.nvim_create_autocmd("BufNewFile", {
  desc = "Import template for python files",
  pattern = { "*.py" },
  command = "0r ~/.dotfiles/nvim/templates/python.template",
})

api.nvim_create_autocmd("FileType", {
  desc = "Verbose texts should have a default textwidth and spelling enabled",
  pattern = { "markdown", "text" },
  command = "setlocal spell tw=80",
})

api.nvim_create_autocmd("FileType", {
  desc = "Disable spell in help files",
  pattern = { "help" },
  command = "setlocal nospell",
})

api.nvim_create_autocmd("FileType", {
  desc = "close editing the task",
  pattern = { "taskedit" },
  callback = function()
    vim.keymap.set("n", "<leader>wq", "ZZ", { silent = true })
  end,
})

api.nvim_create_autocmd("FileType", {
  desc = "Indent at 2 spaces on ledger files",
  pattern = { "ledger" },
  command = "setlocal ts=2 sw=2 sts=2",
})

api.nvim_create_autocmd("FileType", {
  desc = "automatically close temporary buffers with q",
  pattern = {
    "qf",
    "man",
    "fugitive",
    "help",
    "lspinfo",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

local OperateQuickrun = api.nvim_create_augroup("OperateQuickrun", { clear = true })
vim.api.nvim_create_autocmd({ "WinNew" }, {
  group = OperateQuickrun,
  pattern = { "*" },
  callback = function()
    vim.api.nvim_create_autocmd({ "BufNew" }, {
      desc = "close quickrun window from src buffer",
      pattern = { "quickrun://output" },
      once = true,
      callback = function()
        vim.keymap.set("n", "q", "<cmd>bw! quickrun://output<CR>", { silent = true })
      end,
    })
  end,
})

api.nvim_create_autocmd("BufUnload", {
  desc = "restore macro functionality when buff is closed",
  group = OperateQuickrun,
  pattern = { "quickrun://output" },
  callback = function()
    vim.keymap.set("n", "q", "q", { silent = true })
  end,
})

api.nvim_create_autocmd("FileType", {
  desc = "Start git messages in insert mode",
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing spaces in journal files",
  pattern = { "*.journal" },
  command = "%s/\\s\\+$//e",
})

api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = api.nvim_create_augroup("yank_highlight", {}),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ hlgroup = "IncSearch", timeout = 300 })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

local OpenQuickfix = api.nvim_create_augroup("OpenQuickfix", { clear = true })
api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Open quickfix list when running a quickfix command",
  group = OpenQuickfix,
  pattern = "[^l]*",
  command = "cwindow",
})

api.nvim_create_autocmd("QuickFixCmdPost", {
  desc = "Open location list when running a location command",
  group = OpenQuickfix,
  pattern = "l*",
  command = "lwindow",
})

-- enable line numbers in preview
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
