-- FUNCTIONS
-- save and close buffer
vim.api.nvim_create_user_command("WRCL", "write|bdelete", {})

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

-- live grep
function _G.open_git_status()
  require("telescope.builtin").git_status()
end

-- open config in their directory
function _G.open_conf()
  require("telescope.builtin").find_files({ cwd = "~/.dotfiles" })
end

-- update payees and account
function _G.hledger_update()
  os.execute(
    "/opt/homebrew/bin/hledger -f /Users/gmnr/.finance/all.journal payees > /Users/gmnr/.finance/.src/completion-source/payees"
  )
  os.execute(
    "/opt/homebrew/bin/hledger -f /Users/gmnr/.finance/all.journal accounts | /usr/bin/python3 /Users/gmnr/.finance/.src/scripts/filter-account.py > /Users/gmnr/.finance/.src/completion-source/accounts"
  )
  print("Payees and Accounts Updated")
end
