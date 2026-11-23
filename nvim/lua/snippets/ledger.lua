local u = require("modules.snippets")

local function account(trig, dscr, name)
  return u.auto_word(trig, dscr, t(name))
end

return vim.list_extend({
  -- a space at the very start of a line becomes today's date
  s(
    { trig = "^ ", trigEngine = "pattern", dscr = "YYYY-MM-DD", snippetType = "autosnippet" },
    { u.today(), t(" ") }
  ),

  u.auto_word("autotransfer", "movement transaction", {
    u.today(),
    t({
      " MINIERI GUIDO | autotransfer to revolut",
      "  assets:current:revolut                                120,00",
      "  assets:current:fineco",
      "",
    }),
  }),
  u.auto_word("schedacarb", "movement transaction", {
    u.today(),
    t({
      " IMPRESA A. MINIERI SPA | scheda carburante",
      "  expenses:transit:car:fuel                              50,00",
      "  revenues:reimbursement:travel-expenses",
      "",
    }),
  }),

  account("cash", "snippet for cash", "assets:current:cash"),
  account("fineco", "snippet for fineco", "assets:current:fineco"),
  account("revo", "snippet for revolut", "assets:current:revolut"),
  account("paypal", "snippet for paypal", "assets:current:paypal"),
  account("fff", "snippet for fede", "liabilities:current:ponzo-federica  "),
  account("drink", "snippet for drinks", "expenses:food-bev:drinks  "),
  account("eat", "snippet for eat", "expenses:food-bev:eating-out  "),
  account("break", "snippet for break", "expenses:food-bev:breaks  "),
  account("ggg", "snippet for groceries", "expenses:food-bev:groceries  "),
  account("fuel", "snippet for fuel", "expenses:transit:car:fuel  "),
}, u.accents())
