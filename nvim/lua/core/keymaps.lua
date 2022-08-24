-- leader key
vim.g.mapleader = ' '

-- fix Y behaviour
vim.keymap.set('n', 'Y', 'y$')

-- move across visual lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- open and load .vimrc"
vim.keymap.set('n', '<leader>ev', ':Explore ~/.dotfiles/nvim/lua/core<CR>')
vim.keymap.set('n', '<leader>el', ':Explore ~/.dotfiles/nvim/lua/plugins<CR>')
vim.keymap.set('n', '<leader>sv', ':source ~/.dotfiles/nvim/init.lua<CR>')
vim.keymap.set('n', '<leader>eu', ':PlugUpdate<CR>')

-- quick save and exit
vim.keymap.set('n', '<leader>ww', ':w<CR>')
vim.keymap.set('n', '<leader>ww', ':w<CR>')
vim.keymap.set('n', '<leader>wq', ':Wd<CR>')
vim.keymap.set('n', '<leader>qq', ':bd!<CR>')
vim.keymap.set('n', '<leader>QQ', ':q!<CR>')
vim.keymap.set('n', '<leader>QA', ':qa!<CR>')

--  quick search
vim.keymap.set('n', '<leader>ff', ':%s/')

-- start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set({'n', 'x'}, 'ga', '<Plug>(EasyAlign)')

-- remap backspace to lats used buffer
vim.keymap.set('n', '<BS>', '<C-^>')

-- map vim-fugitive
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gp', ':Git push<CR>')
vim.keymap.set('n', '<leader>gh', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>gl', ':diffget //3<CR>')
vim.keymap.set('n', '<leader>gc', ':GBranches<CR>')

-- telescope mappings
vim.keymap.set('n', '<leader>pp', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<leader>pa', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<leader>pl', '<cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>po', '<cmd>Telescope buffers<CR>')
vim.keymap.set('n', '<leader>pt', '<cmd>Telescope tags<CR>')
vim.keymap.set('n', '<leader>ps', '<cmd>Telescope git_status<CR>')
vim.keymap.set('n', '<leader>pc', '<cmd>Telescope git_branches<CR>')

-- vimviki
vim.keymap.set('n', '<leader>wm', '<cmd>VimwikiIndex<CR>')

-- change the current directory to edited file
vim.keymap.set('n', '<leader>cd', ':cd %:h<CR>')

-- add autocorrect
vim.keymap.set('n', '<leader><Tab>', '1z=')

-- quickrun
vim.keymap.set('n', '<leader>r', ':w<CR>:QuickRun<CR>')

-- toggle paste and manage copy
vim.keymap.set('n', '<leader>yy', ':set invpaste paste?<CR>')
vim.keymap.set('n', '<leader>cp', ':w !pbcopy<CR>')

-- change mappings for location list navigation
vim.keymap.set('n', '[w', ':lprevious<CR>')
vim.keymap.set('n', ']w', ':lnext<CR>')
vim.keymap.set('n', '[W', ':lfirst<CR>')
vim.keymap.set('n', ']W', ':llast<CR>')

-- change prefix for window navigation
vim.keymap.set('n', '<leader>a', '<C-w>')

-- swap fold command
vim.keymap.set('n', 'za', 'zo')
vim.keymap.set('n', 'zo', 'za')

-- gitsigns
vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>hb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', '<leader>hB', ':Gitsigns toggle_current_line_blame<CR>')  -- not working
vim.keymap.set('n', '<leader>hS', ':Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer<CR>')
vim.keymap.set('n', '<leader>hd', ':Gitsigns diffthis<CR>')
vim.keymap.set('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})

-- lsp config
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation)
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>ll', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.formatting)
vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration)
vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition)
vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references)
vim.keymap.set('n', '<F12>', ':Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>le', ':Lspsaga show_line_diagnostics<CR>')
vim.keymap.set('n', '<leader>lE', ':Lspsaga show_cursor_diagnostics<CR>')
vim.keymap.set('n', '<leader>[d', ':Lspsaga diagnostic_jump_prev<CR>')
vim.keymap.set('n', '<leader>]d', ':Lspsaga diagnostic_jump_next<CR>')
vim.keymap.set('n', '<leader>lb', ':LSoutlineToggle<CR>')
vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>')
vim.keymap.set('n', '<leader>lu', ':Lspsaga lsp_finder<CR>')
vim.keymap.set('n', '<leader>ld', ':Lspsaga preview_definition<CR>')
vim.keymap.set('n', '<leader>lr', ':Lspsaga rename<CR>')
