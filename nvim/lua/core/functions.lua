-- Custom functions config
-- save and close buffer
vim.api.nvim_create_user_command('Wd', 'write|bdelete', {})

-- WRITE LUA FUNCTIONS IN GLOBAL SPACE (_G)
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

-- write a note in the editor
function _G.Annotate()

  local date = os.date('%Y%m%d')
  local time = os.date('%H:%M')

  local filename = date .. '.md'
  local fullpath = '/Users/guido/.notes/notepad/' .. filename

  local f = io.open(fullpath, 'r')
  if f ~= nil and io.close(f) then
    local file = io.open(fullpath, 'a')
    file:write('\n> UPDATED @ ' .. time)
    file:close()
  else
    local file = io.open(fullpath, 'w')
    file:write('# ' .. os.date('%Y-%m-%d'))
    file:close()
  end
end

