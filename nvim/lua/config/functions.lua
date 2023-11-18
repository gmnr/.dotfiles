-- FUNCTIONS
-- save and close buffer
vim.api.nvim_create_user_command("WRCL", "write|bdelete", {})

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
