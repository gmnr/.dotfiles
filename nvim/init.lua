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
require('plugins.completion')
require('plugins.gitsigns')
require('plugins.lua-line')
require('plugins.telescope')
require('plugins.treesitter')
require('plugins.organization')

