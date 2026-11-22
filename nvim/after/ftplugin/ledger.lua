-- mappings
vim.keymap.set(
  "i",
  "<CR>",
  "<cmd>lua require('modules.hledger').align_amount()<CR><Right><CR>",
  { buffer = 0, silent = true }
)
vim.keymap.set(
  "n",
  "<leader>ee",
  "<cmd>lua require('modules.hledger').align_amount()<CR>",
  { buffer = 0, silent = true }
)
vim.keymap.set("n", "<leader>eu", "<cmd>lua require('modules.hledger').update()<CR>", { buffer = 0, silent = true })
vim.keymap.set("n", "J", "kJ", { buffer = 0, silent = true })
vim.keymap.set("n", "<leader>es", "{2j0daWkJ$", { buffer = 0, silent = true })

-- options
vim.opt_local.number = false
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- remove trailing spaces on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove whitespace",
  buffer = 0,
  group = vim.api.nvim_create_augroup("LedgerTrim" .. vim.api.nvim_get_current_buf(), { clear = true }),
  command = [[%s/\s\+$//e]],
})
