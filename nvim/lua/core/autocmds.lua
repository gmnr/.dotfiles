-- Autocommands
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = {'*.py'},
  desc = 'Use template for python files',
  command = '0r ~/.dotfiles/nvim/templates/python.template'
})

-- FileType autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'markdown', 'vimwiki'},
  desc = 'Enable spelling while editing verbose files',
  command = 'setlocal spell'
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = {'markdown', 'vimwiki'},
  desc = 'Verbose texts should have a default textwidth',
  command = 'setlocal tw=80'
})
