local u = require("modules.snippets")

return vim.list_extend({
  -- two spaces anywhere become a line break
  u.auto_anywhere("  ", "line break", t({ "<br>", "" })),
}, u.accents())
