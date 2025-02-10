-- FUNCTIONS
-- save and close buffer
vim.api.nvim_create_user_command("WRCL", "write|bdelete", {})

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
