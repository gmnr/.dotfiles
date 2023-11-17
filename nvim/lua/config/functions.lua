-- FUNCTIONS
-- save and close buffer
vim.api.nvim_create_user_command("Wd", "write|bdelete", {})

-- Align ledger amounts and add trailing zeros when needed
function _G.better_ledger_align()
  if string.find(vim.fn.getline("."):sub(-1), "%d") then
    local str = vim.fn.getline(".")
    local elements = {}

    for el in str:gmatch("%S+") do
      table.insert(elements, el)
    end

    local amt = elements[#elements]
    if not string.find(amt, ",") then
      vim.cmd("normal A,00")
    else
      local pos = string.find(amt, ",")
      if pos == #amt - 1 then
        vim.cmd("normal A0")
      end
    end
    vim.cmd(":LedgerAlign")
    return ""
  else
    return ""
  end
end

-- write a note in the editor
function _G.annotate()
  local date = os.date("%Y%m%d")
  local time = os.date("%H:%M")

  local filename = date .. ".md"
  local fullpath = "/Users/guido/.notes/notepad/" .. filename

  local f = io.open(fullpath, "r")
  if f ~= nil and io.close(f) then
    local file = io.open(fullpath, "a")
    file:write("\n> UPDATED @ " .. time)
    file:close()
  else
    local file = io.open(fullpath, "w")
    file:write("# " .. os.date("%Y-%m-%d"))
    file:close()
  end
end

-- go to root dir when using telescope
function _G.project_files()
  local is_inside_work_tree = {}
  local ivy = require("telescope.themes").get_ivy()

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files(ivy)
  else
    require("telescope.builtin").find_files(ivy)
  end
end
