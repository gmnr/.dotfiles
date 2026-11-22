local M = {}

-- repos whose real path doesn't match the name you know them by
local aliases = {
  { pattern = "Docs.*Hledger", name = ".finance" },
  { pattern = "DBeaverData.*Script", name = ".work_sql" },
}

local function base_dir(path)
  path = path or vim.api.nvim_buf_get_name(0)
  local dir = path ~= "" and vim.fn.fnamemodify(path, ":p:h") or ""
  if dir == "" or vim.fn.isdirectory(dir) == 0 then
    dir = os.getenv("PWD") or vim.uv.cwd()
  end
  return dir
end

function M.root(path)
  return Snacks.git.get_root(base_dir(path))
end

function M.name(path)
  local dir = base_dir(path)
  for _, alias in ipairs(aliases) do
    if dir:match(alias.pattern) then
      return alias.name
    end
  end
  local root = Snacks.git.get_root(dir)
  return root and vim.fs.basename(root) or ""
end

return M
