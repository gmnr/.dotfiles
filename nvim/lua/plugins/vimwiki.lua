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
