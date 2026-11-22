local source = {}

local kind = vim.lsp.protocol.CompletionItemKind

local payee_icon = "\u{F10C1}"

local account_icons = {
  assets = "\u{F0070}",
  liabilities = "\u{F0FEF}",
  expenses = "\u{F0110}",
  revenues = "\u{F0114}",
  equity = "\u{F05D1}",
}
local default_account_icon = account_icons.assets

local function decorate(item)
  if item.kind == kind.Class then
    item.kind_name, item.kind_icon = "Payee", payee_icon
  else
    item.kind_name = "Account"
    item.kind_icon = account_icons[item.label:match("^[^:]+")] or default_account_icon
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
