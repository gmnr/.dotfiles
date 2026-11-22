-- AUTOCOMMANDS
local api = vim.api

-- define groups
local OperateQuickrun = api.nvim_create_augroup("OperateQuickrun", { clear = true })
local YankHighlight = api.nvim_create_augroup("YankHighlight", {})

api.nvim_create_autocmd("BufNewFile", {
  desc = "Import template for python files",
  pattern = { "*.py" },
  command = "0r ~/.dotfiles/nvim/templates/python.template",
})

api.nvim_create_autocmd("FileType", {
  desc = "automatically close temporary buffers with q",
  pattern = {
    "qf",
    "man",
    "NeogitStatus",
    "git",
    "help",
    "lspinfo",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

api.nvim_create_autocmd("BufNew", {
  desc = "while a quickrun output is open, q closes it (also from the src buffer)",
  group = OperateQuickrun,
  pattern = "quickrun://output",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>bw! quickrun://output<CR>", { silent = true })
  end,
})

api.nvim_create_autocmd("BufUnload", {
  desc = "restore macro functionality when output is closed",
  group = OperateQuickrun,
  pattern = "quickrun://output",
  callback = function()
    pcall(vim.keymap.del, "n", "q")
  end,
})

api.nvim_create_autocmd("FileType", {
  desc = "Start git messages in insert mode",
  pattern = { "gitcommit", "gitrebase" },
  command = "startinsert | 1",
})

api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = YankHighlight,
  pattern = "*",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 300 })
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

local mru = require("modules.mru_buffers")
api.nvim_create_autocmd("BufEnter", {
  group = api.nvim_create_augroup("MruBuffers", { clear = true }),
  callback = function(args)
    mru.record(args.buf)
  end,
})

mru.record(api.nvim_get_current_buf())
