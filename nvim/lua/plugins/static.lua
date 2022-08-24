-- Static plugins config

-- emmet config
vim.g.user_emmet_mode='nv'
vim.g.user_emmet_leader_key='<leader>'

-- ultisnips config
vim.g.UltiSnipsExpandTrigger = '<Tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
vim.g.UltiSnipsSnippetDirectories={'snppts'}

-- delimitmate
vim.g.delimitMate_expand_cr = 2 -- turns on <CR> expansion
vim.g.delimitMate_expand_space = 1 -- turns on <Space> expansion

-- quickrun
vim.cmd [[
let g:quickrun_config = {
      \'*': {
      \'hook/time/enable': 1,
      \'hook/time/format': '[Finished in %gs]',
      \'outputter/buffer/opener': '%{"bel 12new"}'}}  " set options for quickrun
]]

-- Vimwiki
vim.g.vimwiki_global_ext = 0 -- vimwiki only overrides .wiki files
vim.cmd [[
let g:vimwiki_list = [{
      \ 'path': '~/Documents/VimWiki/gmnr',
      \ 'ext': '.wiki',
      \ 'template_path': '~/Documents/VimWiki/templates',
      \ 'template_default': 'default',
      \ 'auto_export': 1,
      \ 'template_ext': '.html'}]
]]
