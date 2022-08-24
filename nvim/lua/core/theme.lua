-- one dark and color compatibility
vim.cmd('colorscheme onedark')
vim.cmd('let $NVIM_TUI_ENABLE_TRUE_COLOR=1')

-- add colors to types in autocompletion
vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE guifg=#808080')
vim.cmd('highlight! CmpItemAbbrMatch      guibg=NONE guifg=#98C379')
vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#98C379')
vim.cmd('highlight! CmpItemKindInterface  guibg=NONE guifg=#98C379')
vim.cmd('highlight! CmpItemKindUnit       guibg=NONE guifg=#98C379')
vim.cmd('highlight! CmpItemKindFunction   guibg=NONE guifg=#C678DD')
vim.cmd('highlight! CmpItemKindKeyword    guibg=NONE guifg=#C678DD')
vim.cmd('highlight! CmpItemKindMethod     guibg=NONE guifg=#E06C75')
vim.cmd('highlight! CmpItemKindProperty   guibg=NONE guifg=#E06C75')
vim.cmd('highlight! CmpItemKindVariable   guibg=NONE guifg=#61AFEF')
vim.cmd('highlight! CmpItemKindText       guibg=NONE guifg=#ABB2BF')
vim.cmd('highlight! CmpItemKindClass      guibg=NONE guifg=#E5C07B')

-- modify spell error highlighings
vim.cmd('highlight! SpellBad   guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellCap   guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellLocal guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellRare  guibg=NONE guifg=#E5C07B')