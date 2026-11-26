local source = {}

local kind = vim.lsp.protocol.CompletionItemKind

local payee_icon = "\u{F10C1}"
local payee_hl = "BlinkCmpKindPayee"

local account_icons = {
  assets = "\u{F0070}",
  liabilities = "\u{F0FEF}",
  expenses = "\u{F0110}",
  revenues = "\u{F0114}",
  equity = "\u{F05D1}",
}
local default_account_icon = account_icons.assets

local account_hls = {
  assets = "BlinkCmpKindAssets", -- blue
  liabilities = "BlinkCmpKindLiabilities", -- orange
  expenses = "BlinkCmpKindExpenses", -- red
  revenues = "BlinkCmpKindRevenues", -- green
}

local function set_highlights()
  local function link(name, target)
    vim.api.nvim_set_hl(0, name, { link = target, default = true })
  end
  link("BlinkCmpKindAssets", "Directory") -- blue
  link("BlinkCmpKindLiabilities", "Constant") -- orange
  link("BlinkCmpKindExpenses", "DiagnosticError") -- red
  link("BlinkCmpKindRevenues", "String") -- green
  link(payee_hl, "Function") -- purple
end

set_highlights()
-- colorschemes clear custom highlights, so re-apply them after a switch
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

local function decorate(item)
  if item.kind == kind.Class then
    item.kind_name, item.kind_icon, item.kind_hl = "Payee", payee_icon, payee_hl
  else
    local top = item.label:match("^[^:]+")
    item.kind_name = "Account"
    item.kind_icon = account_icons[top] or default_account_icon
    item.kind_hl = account_hls[top]
  end
end

function source.new()
  return setmetatable({}, { __index = source })
end

function source:enabled()
  return vim.bo.filetype == "ledger"
end

function source:get_completions(ctx, callback)
  local items = require("modules.hledger").items(ctx.line)
  for _, item in ipairs(items) do
    if not item.kind_icon then
      decorate(item)
    end
  end
  callback({
    items = items,
    is_incomplete_forward = false,
    is_incomplete_backward = false,
  })
end

return source
