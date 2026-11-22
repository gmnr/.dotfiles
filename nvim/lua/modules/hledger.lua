local M = {}

local function journal()
  return vim.env.LEDGER_FILE or vim.fn.expand("~/.finance/all.journal")
end

local function source_dir()
  return vim.env.DOTFILES .. "/hledger"
end

function M.open_journal()
  vim.cmd("edit +$ ~/.finance/periods/" .. os.date("%Y") .. ".journal")
end

function M.align_amount()
  local line = vim.fn.getline(".")
  if not line:sub(-1):find("%d") then
    return
  end

  local amt = line:match("(%S+)%s*$")
  local pos = amt:find(",")
  if not pos then
    vim.cmd("normal A,00")
  elseif pos == #amt - 1 then
    vim.cmd("normal A0")
  end
  vim.cmd("LedgerAlign")
end

-- completion
local cache

local function load()
  local kind = vim.lsp.protocol.CompletionItemKind
  local dir = source_dir() .. "/completion-source/"
  cache = { payees = {}, accounts = {} }
  for payee in io.lines(dir .. "payees") do
    table.insert(cache.payees, { label = payee, insertText = payee .. " | ", filterText = payee, kind = kind.Class })
  end
  for account in io.lines(dir .. "accounts") do
    table.insert(
      cache.accounts,
      { label = account, insertText = account .. "   ", filterText = account, kind = kind.Method }
    )
  end
end

-- postings are indented: offer accounts there, payees on transaction lines
function M.items(line)
  if not cache then
    load()
  end
  line = line or vim.api.nvim_get_current_line()
  return line:sub(1, 2) == "  " and cache.accounts or cache.payees
end

function M.update()
  local hl = source_dir()
  vim.fn.system(("hledger -f %s payees > %s/completion-source/payees"):format(journal(), hl))
  vim.fn.system(
    ("hledger -f %s accounts | python3 %s/scripts/filter-account.py > %s/completion-source/accounts"):format(
      journal(),
      hl,
      hl
    )
  )
  cache = nil
  print("Payees and Accounts Updated")
end

return M
