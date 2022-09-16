-- Static plugins config

-- emmet config
vim.g.user_emmet_mode='nv'
vim.g.user_emmet_leader_key='<leader>'

-- ultisnips config
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
vim.g.UltiSnipsSnippetDirectories={'snppts'}

-- vim-ledger
vim.g.ledger_bin = 'hledger'
vim.g.ledger_decimal_sep = ','

-- quickrun
vim.cmd([[
let g:quickrun_config = {
      \'*': {
      \'hook/time/enable': 1,
      \'hook/time/format': '[Finished in %gs]',
      \'outputter/buffer/opener': '%{"bel 12new"}'}}  " set options for quickrun
]])
