-- FUNCTIONS
-- update payees and account
function _G.hledger_update()
  os.execute(
    "/opt/homebrew/bin/hledger -f /Users/gmnr/.finance/all.journal payees > /Users/gmnr/.dotfiles/hledger/completion-source/payees"
  )
  os.execute(
    "/opt/homebrew/bin/hledger -f /Users/gmnr/.finance/all.journal accounts | /opt/homebrew/bin/python3 /Users/gmnr/.dotfiles/hledger/scripts/filter-account.py > /Users/gmnr/.dotfiles/hledger/completion-source/accounts"
  )
  print("Payees and Accounts Updated")
end
