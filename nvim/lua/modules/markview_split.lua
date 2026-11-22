local M = {}

local api = vim.api

-- a real markdown file on disk (not a scratch, help or plugin buffer)
local function is_md_file(buf)
  return vim.bo[buf].filetype == "markdown" and vim.bo[buf].buftype == "" and api.nvim_buf_get_name(buf) ~= ""
end

-- open the preview for `buf`, once it is the current buffer
function M.open(buf)
  if not is_md_file(buf) then
    return
  end
  vim.schedule(function()
    if api.nvim_buf_is_valid(buf) and api.nvim_get_current_buf() == buf then
      pcall(vim.cmd, "Markview splitOpen")
    end
  end)
end

function M.close()
  pcall(vim.cmd, "Markview splitClose")
end

-- called from the markview plugin spec, so none of this loads until the first
-- markdown file is opened (FileType runs before that file's BufWinEnter, so
-- the first file still gets its split)
function M.setup()
  local group = api.nvim_create_augroup("MarkviewAutoSplit", { clear = true })

  -- open the preview split when a markdown file is shown in a window
  api.nvim_create_autocmd("BufWinEnter", {
    group = group,
    pattern = "*.md",
    callback = function(args)
      M.open(args.buf)
    end,
  })

  -- :q / :wq → close the preview first so Neovim doesn't linger with only the preview
  api.nvim_create_autocmd("QuitPre", {
    group = group,
    callback = function(args)
      if is_md_file(args.buf) then
        M.close()
      end
    end,
  })

  -- :bd or switching to another buffer → close the preview
  api.nvim_create_autocmd("BufWinLeave", {
    group = group,
    callback = function(args)
      if is_md_file(args.buf) then
        vim.schedule(M.close)
      end
    end,
  })
end

return M
