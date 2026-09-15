local M = {}

local mru = {}
local function is_excluded(buf)
  return vim.bo[buf].filetype == "quickrun"
end

function M.record(buf)
  for i, b in ipairs(mru) do
    if b == buf then
      table.remove(mru, i)
      break
    end
  end
  table.insert(mru, 1, buf)
end

function M.goto_last()
  local cur = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(mru) do
    if buf ~= cur and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and not is_excluded(buf) then
      vim.api.nvim_set_current_buf(buf)
      return
    end
  end
end

return M
