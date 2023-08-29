-- Init config
-- load core config
require('core.autocmds')
require('core.functions')
require('core.mappings')
require('core.options')
require('core.plugins')
require('core.theme')

-- load static plugins config
require('plugins.static')

-- load dynamic plugins config
require('plugins.completion').config()  -- cmp / lspconfig / lspking / lspsaga
require('plugins.gitsigns').config()
require('plugins.lua-line').config()
require('plugins.telescope').config()
require('plugins.treesitter').config()
require('plugins.organization').config()
