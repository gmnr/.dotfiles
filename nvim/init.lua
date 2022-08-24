-- load core config
require('core.autocmds')
require('core.functions')
require('core.keymaps')
require('core.options')
require('core.plugins')
require('core.theme')

-- load static plugins config
require('plugins.delimitmate')
require('plugins.emmet')
require('plugins.quickrun')
require('plugins.ultisnips')
require('plugins.vimwiki')

-- load dynamic plugins config
require('plugins.autocomplete').config()
require('plugins.gitsigns').config()
require('plugins.lua-line').config()
require('plugins.telescope').config()
require('plugins.treesitter').config()
