-- save and close buffer
vim.api.nvim_create_user_command('Wd', 'write|bdelete', {})
