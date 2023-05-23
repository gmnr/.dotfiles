-- Static plugins config

-- emmet config
vim.g.user_emmet_mode='nv'
vim.g.user_emmet_leader_key='<leader>'

-- ultisnips config
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
vim.g.UltiSnipsSnippetDirectories={'snppts'}

-- indent line
vim.g.indent_blankline_buftype_exclude={'markdown', 'text'}

vim.g.onedark_config={'style:cool'}

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

-- markdown
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_conceal = 2
vim.g.vim_markdown_frontmatter = 1
