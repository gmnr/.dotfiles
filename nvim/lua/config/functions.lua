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

  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end

  if is_inside_work_tree[cwd] then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end

-- live grep
function _G.open_live_grep()
  require("telescope.builtin").live_grep()
end

-- open config in their directory
function _G.open_conf()
  require("telescope.builtin").find_files({ cwd = "~/.dotfiles" })
end

-- open notes in their directory
function _G.open_notes()
  require("telescope.builtin").find_files({ cwd = "~/.notes" })
end

-- open grep in notes directory
function _G.open_grep_notes()
  require("telescope.builtin").live_grep({ cwd = "~/.notes" })
end

-- update payees and account
function _G.hledger_update()
  os.execute(
    "/usr/local/bin/hledger -f /Users/guido/.finance/all.journal payees > /Users/guido/.finance/.src/completion-source/payees"
  )
  os.execute(
    "/usr/local/bin/hledger -f /Users/guido/.finance/all.journal accounts | /usr/bin/python3 /Users/guido/.finance/.src/scripts/filter-account.py > /Users/guido/.finance/.src/completion-source/accounts"
  )
  print("Payees and Accounts Updated")
end
