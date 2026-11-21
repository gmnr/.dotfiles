-- AUTOCOMMANDS
local api = vim.api

api.nvim_create_autocmd("BufNewFile", {
  desc = "Import template for python files",
  pattern = { "*.py" },
  command = "0r ~/.dotfiles/nvim/templates/python.template",
})

api.nvim_create_autocmd("FileType", {
  desc = "Verbose texts should have spelling enabled",
  pattern = { "markdown", "text" },
  command = "setlocal spell",
})

api.nvim_create_autocmd("FileType", {
  desc = "Disable numbers for text heavy buffers",
  pattern = {
    "markdown",
    "text",
    "ledger",
    "NeogitStatus",
    "gitcommit",
  },
  command = "setlocal nonumber",
})

local group = api.nvim_create_augroup("MarkviewAutoSplit", { clear = true })

local function is_md_file(buf)
  return vim.bo[buf].filetype == "markdown" and vim.bo[buf].buftype == "" and api.nvim_buf_get_name(buf) ~= ""
end

local function open_split(buf)
  if not is_md_file(buf) then
    return
  end
  vim.schedule(function()
    if api.nvim_buf_is_valid(buf) and api.nvim_get_current_buf() == buf then
      pcall(vim.cmd, "Markview splitOpen")
    end
  end)
end

-- Open the preview split when a markdown file is opened
api.nvim_create_autocmd("BufWinEnter", {
  group = group,
  pattern = "*.md",
  callback = function(args)
    open_split(args.buf)
  end,
})

-- :q / :wq → close the preview first so Neovim doesn't linger with only the preview
api.nvim_create_autocmd("QuitPre", {
  group = group,
  callback = function(args)
    if is_md_file(args.buf) then
      pcall(vim.cmd, "Markview splitClose")
    end
  end,
})

-- :bd or switching to another buffer → close the preview
api.nvim_create_autocmd("BufWinLeave", {
  group = group,
  callback = function(args)
    if is_md_file(args.buf) then
      vim.schedule(function()
        pcall(vim.cmd, "Markview splitClose")
      end)
    end
  end,
})

-- The markdown buffer that triggered lazy-loading
-- (remove this block if you get a double split on the first file)
local cur = api.nvim_get_current_buf()
if vim.bo[cur].filetype == "markdown" then
  open_split(cur)
end

api.nvim_create_autocmd("FileType", {
  desc = "Disable spell in help files",
  pattern = { "help" },
  command = "setlocal nospell",
})

api.nvim_create_autocmd("FileType", {
  desc = "Indent at 2 spaces on ledger and markdown files",
  pattern = { "ledger", "markdown" },
  command = "setlocal ts=2 sw=2 sts=2",
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

local OperateQuickrun = api.nvim_create_augroup("OperateQuickrun", { clear = true })
api.nvim_create_autocmd({ "WinNew" }, {
  group = OperateQuickrun,
  pattern = { "*" },
  callback = function()
    api.nvim_create_autocmd({ "BufNew" }, {
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

api.nvim_create_autocmd("BufWritePre", {
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

local mru = require("modules.mru_buffers")
api.nvim_create_autocmd("BufEnter", {
  group = api.nvim_create_augroup("MruBuffers", { clear = true }),
  callback = function(args)
    mru.record(args.buf)
  end,
})

mru.record(api.nvim_get_current_buf())
