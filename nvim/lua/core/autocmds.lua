-- Import templates for python files
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = {'*.py'},
  desc = 'Use template for python files',
  command = '0r ~/.dotfiles/nvim/templates/python.template'
})

-- Enable spellign for verbose text editing
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'markdown', 'vimwiki'},
  desc = 'Enable spelling while editing verbose files',
  command = 'setlocal spell'
})

-- Set a fixed textwidth for verbose files
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'markdown', 'vimwiki'},
  desc = 'Verbose texts should have a default textwidth',
  command = 'setlocal tw=80'
})

-- 4 spaces for indent for ledger files
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'ledger'},
  desc = 'Indent at 4 spaces',
  command = 'setlocal ts=4 sw=4 sts=4'
})
