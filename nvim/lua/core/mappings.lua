-- Mappings config
-- leader key
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true, remap = false })  -- improve performance of leader key
vim.g.mapleader = ' '

-- fix Y behaviour
vim.keymap.set('n', 'Y', 'y$')

-- saner line navigation
vim.keymap.set('n', 'H', '^')
vim.keymap.set('n', 'L', '$')

-- move across visual lines
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- override ctrl-e to scroll up
vim.keymap.set('n', '<C-f>', '<C-u>')

-- open and load .vimrc
vim.keymap.set('n', '<leader>fd', ':lua require("telescope.builtin").find_files({cwd="~/.dotfiles/nvim/lua/", search_dirs={"plugins", "core"}})<CR>', { silent = true })
vim.keymap.set('n', '<leader>fu', ':PlugUpdate<CR>')
vim.keymap.set('n', '<leader>fw', ':lua Annotate()<CR>:exe "e +$ ~/.notes/notepad/".strftime("%Y%m%d").".md"<CR>', { silent = true })

-- open notes
vim.keymap.set('n', '<leader>pl', ':lua require("telescope.builtin").find_files({cwd="~/.notes"})<CR>', { silent = true })

-- quick save and exit
vim.keymap.set('n', '<leader>ww', ':w<CR>')
vim.keymap.set('n', '<leader>wq', ':Wd<CR>')
vim.keymap.set('n', '<leader>qq', ':bd!<CR>')
vim.keymap.set('n', '<leader>QQ', ':q!<CR>')
vim.keymap.set('n', '<leader>QA', ':qa!<CR>')

-- open and close quickfix and location list
vim.keymap.set('n', '<leader>qo', ':cope<CR>')
vim.keymap.set('n', '<leader>qc', ':ccl<CR>')
vim.keymap.set('n', '<leader>lo', ':lopen<CR>')
vim.keymap.set('n', '<leader>lc', ':lclose<CR>')

--  quick search
vim.keymap.set('n', '<leader>ff', ':%s/')

-- start interactive EasyAlign in visual mode (e.g. vipga)
vim.keymap.set({'n', 'x'}, 'ga', '<Plug>(EasyAlign)')

-- remap backspace to lats used buffer
vim.keymap.set('n', '<BS>', '<C-^>')

-- map vim-fugitive
vim.keymap.set('n', '<leader>gs', ':Git<CR>')
vim.keymap.set('n', '<leader>gy', ':Git push<CR>')
vim.keymap.set('n', '<leader>gm', ':diffget //2<CR>')
vim.keymap.set('n', '<leader>gi', ':diffget //3<CR>')

-- telescope mappings
vim.keymap.set('n', '<leader>yy', ':lua Project_files()<CR>', { silent = true })  -- link custom function to use find_git when .git exists and find_files when it doesn't
vim.keymap.set('n', '<leader>yi', ':Telescope live_grep<CR>', { silent = true })
vim.keymap.set('n', '<leader>yu', ':Telescope buffers<CR>', { silent = true })
vim.keymap.set('n', '<leader>ys', ':Telescope git_status<CR>', { silent = true })
vim.keymap.set('n', '<leader>yc', ':Telescope git_branches<CR>', { silent = true })
vim.keymap.set('n', '<leader>ya', ':Telescope find_files<CR>', { silent = true })
vim.keymap.set('n', '<leader>yg', ':silent grep ')

-- change the current directory to edited file
vim.keymap.set('n', '<leader>cd', ':cd %:h<CR>')

-- add autocorrect
vim.keymap.set('n', '<leader><Tab>', '1z=')

-- quickrun
vim.keymap.set('n', '<leader>p', ':w<CR>:QuickRun<CR>')

-- toggle paste and manage copy
vim.keymap.set('n', '<leader>jj', ':set invpaste paste?<CR>')
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

-- hledger formatting
vim.keymap.set('n', '<leader>bb', ':lua BetterLedgerAlign()<CR>')
vim.keymap.set('n', '<leader>ba', ':!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal payees > /Users/guido/.finance/.src/completion-source/payees<CR>', { silent = true })
vim.keymap.set('n', '<leader>bq', ':!/usr/local/bin/hledger -f /Users/guido/.finance/all.journal accounts | /usr/bin/python3 /Users/guido/.finance/.src/scripts/filter-account.py > /Users/guido/.finance/.src/completion-source/accounts<CR>', { silent = true })

-- gitsigns
vim.keymap.set('n', '<leader>hp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', '<leader>hb', ':Gitsigns blame_line<CR>')
vim.keymap.set('n', '<leader>hB', ':Gitsigns toggle_current_line_blame<CR>')  -- not working
vim.keymap.set('n', '<leader>hS', ':Gitsigns stage_buffer<CR>')
vim.keymap.set('n', '<leader>hR', ':Gitsigns reset_buffer<CR>')
vim.keymap.set('n', '<leader>hd', ':Gitsigns diffthis<CR>')
vim.keymap.set('n', '<leader>hu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true })
vim.keymap.set({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true })
vim.keymap.set('n', ']c', '&diff ? "]c" : ":Gitsigns next_hunk<CR>"', { expr = true })
vim.keymap.set('n', '[c', '&diff ? "[c" : ":Gitsigns prev_hunk<CR>"', { expr = true })

-- lsp config
vim.keymap.set('n', 'E', ':Lspsaga hover_doc<CR>', { silent = true })
vim.keymap.set('n', '[d', ':Lspsaga diagnostic_jump_prev<CR>', { silent = true })
vim.keymap.set('n', ']d', ':Lspsaga diagnostic_jump_next<CR>', { silent = true })
vim.keymap.set('n', 'gI', vim.lsp.buf.implementation)
vim.keymap.set('n', '<C-p>', vim.lsp.buf.signature_help)
vim.keymap.set('n', '<leader>ls', vim.diagnostic.setloclist)
vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>ll', ':Lspsaga show_line_diagnostics<CR>', { silent = true })
vim.keymap.set('n', '<leader>lL', ':Lspsaga show_cursor_diagnostics<CR>', { silent = true })
vim.keymap.set('n', '<leader>la', ':Lspsaga code_action<CR>', { silent = true })
vim.keymap.set('n', '<leader>lf', ':Lspsaga lsp_finder<CR>', { silent = true })
vim.keymap.set('n', '<leader>lr', ':Lspsaga rename<CR>', { silent = true })

