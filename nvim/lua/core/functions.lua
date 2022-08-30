-- save and close buffer
vim.api.nvim_create_user_command('Wd', 'write|bdelete', {})

-- write lua functions in global space

-- Align ledger amounts and add trailing zeros when needed
function _G.BetterLedgerAlign()

  if string.find(vim.fn.getline('.'):sub(-1), '%d') then
    local str = vim.fn.getline('.')
    local elements = {}

    for el in str:gmatch('%S+') do table.insert(elements, el) end

    local amt = elements[#elements]
    if not string.find(amt, ',') then
      vim.cmd('normal A,00')
    else
      local pos = string.find(amt, ',')
      if pos == #amt-1 then
        vim.cmd('normal A0')
      end
    end
    vim.cmd(':LedgerAlign')
    return ''
  else
    return ''
  end
end
