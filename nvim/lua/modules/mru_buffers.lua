local M = {}

local mru = {}
local function is_excluded(buf)
  return vim.bo[buf].filetype == "quickrun"
end

local function forget(buf)
  for i, b in ipairs(mru) do
    if b == buf then
      table.remove(mru, i)
      return
    end
  end
end

function M.record(buf)
  forget(buf)
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

function M.setup()
  local group = vim.api.nvim_create_augroup("MruBuffers", { clear = true })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = group,
    callback = function(args)
      M.record(args.buf)
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    group = group,
    callback = function(args)
      forget(args.buf)
    end,
  })

  -- the buffer nvim started on may never fire BufEnter
  M.record(vim.api.nvim_get_current_buf())
end

return M
