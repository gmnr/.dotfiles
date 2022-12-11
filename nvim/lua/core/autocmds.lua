local api = vim.api

api.nvim_create_autocmd('BufNewFile', {
  desc = 'Import template for python files',
  pattern = {'*.py'},
  command = '0r ~/.dotfiles/nvim/templates/python.template'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Verbose texts should have a default textwidth and spelling enabled',
  pattern = {'markdown', 'text'},
  command = 'setlocal spell tw=80'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Verbose texts should have a default textwidth and spelling enabled',
  pattern = {'help'},
  command = 'setlocal nospell'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Indent at 4 spaces on ledger files',
  pattern = {'ledger'},
  command = 'setlocal ts=4 sw=4 sts=4'
})

api.nvim_create_autocmd('FileType', {
  pattern = {'ledger'},
  desc = 'Autoalign amounts on ledger files when pressing enter',
  command = 'inoremap <silent> <CR> <C-r>=v:lua.BetterLedgerAlign()<CR><Right><CR>'
})

api.nvim_create_autocmd('BufWritePre', {
  pattern = {'*.journal'},
  desc = 'Remove trailing spaces',
  command = '%s/\\s\\+$//e'
})

api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = api.nvim_create_augroup('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank{hlgroup='IncSearch', timeout=300}
  end,
})
