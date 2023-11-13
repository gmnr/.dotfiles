-- OPTIONS
-- basic options
vim.opt.number                     = true  -- enable numbering
vim.opt.termguicolors              = true  -- enable termguicolors
vim.opt.shiftround                 = true  -- round indent to multiples of shiftwidth
vim.opt.cursorline                 = true  -- enable cursorline
vim.opt.ignorecase                 = true  -- ignore case
vim.opt.smartcase                  = true  -- override ignorecase if capital in search pattern
vim.opt.expandtab                  = true  -- use spaces while tabbing
vim.opt.lazyredraw                 = true  -- don't redraw screen while executing macros
vim.opt.gdefault                   = true  -- when substituting the g flag is always enabled
vim.opt.smartindent                = true  -- smart autoindenting
vim.opt.splitright                 = true  -- open next window to the right of current one
vim.opt.showmode                   = false -- hide mode on last row
vim.opt.swapfile                   = false -- disable swapfile
vim.opt.signcolumn                 = 'yes' -- always enable signcolumn
vim.opt.tabstop                    = 2     -- number of spaces a tab counts for
vim.opt.shiftwidth                 = 2     -- number of spaces of each indentation level
vim.opt.softtabstop                = 2     -- insert spaces when tabbing
vim.opt.scrolloff                  = 999   -- keep cursor in the middle of the line
vim.opt.wildignorecase             = true  -- ignore case when writing commands
vim.opt.complete                   = ''    -- disable ordinary autocompletion
vim.opt.conceallevel               = 2     -- enable concealing

-- set leader
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true, remap = false })  -- improve performance of leader key
vim.g.mapleader = ' '

-- diff options
vim.opt.diffopt                    = 'filler,iwhite,internal,algorithm:patience'

-- spelling
vim.opt.spelllang                  = 'en_us,it'  -- set language of spell
vim.opt.spellcapcheck              = ''          -- don't check cap error at beginning of line

-- grep settings (use ripgrep)
vim.opt.grepprg                    = 'rg --vimgrep --no-heading --smart-case'
vim.opt.grepformat                 = '%f:%l:%c:%m,%f:%l:%m'


-- COLORS
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
vim.cmd('highlight! SpellBad              guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellCap              guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellLocal            guibg=NONE guifg=#E5C07B')
vim.cmd('highlight! SpellRare             guibg=NONE guifg=#E5C07B')

-- define custom colors for gitsigns
vim.cmd('highlight! GitSignsAdd           guibg=NONE guifg=#92BE65')
vim.cmd('highlight! GitSignsAddNr         guibg=NONE guifg=#92BE65')
vim.cmd('highlight! GitSignsChange        guibg=NONE guifg=#7AA2F7')
vim.cmd('highlight! GitSignsChangeNr      guibg=NONE guifg=#7AA2F7')
vim.cmd('highlight! GitSignsDelete        guibg=NONE guifg=#D74B4B')
vim.cmd('highlight! GitSignsDeleteNr      guibg=NONE guifg=#D74B4B')


-- AUTOCOMMANDS
local api = vim.api

api.nvim_create_autocmd('BufNewFile', {
  desc = 'Import template for python files',
  pattern = {'*.py'},
  command = '0r ~/.dotfiles/nvim/templates/python.template'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Verbose texts should have a default textwidth and spelling enabled',
  pattern = {'markdown', 'text'},
  command = 'setlocal spell tw=80'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Disable spell in help files',
  pattern = {'help'},
  command = 'setlocal nospell'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Indent at 2 spaces on ledger files',
  pattern = {'ledger'},
  command = 'setlocal ts=2 sw=2 sts=2'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Autoalign amounts on ledger files when pressing enter',
  pattern = {'ledger'},
  command = 'inoremap <silent> <CR> <C-r>=v:lua.BetterLedgerAlign()<CR><Right><CR>'
})

api.nvim_create_autocmd('FileType', {
  desc = 'automatically close the quickfixlist with q',
  pattern = {'qf'},
  command = 'nmap <buffer> q :ccl<CR>'
})

api.nvim_create_autocmd('FileType', {
  desc = 'Start git messages in insert mode',
  pattern  = { 'gitcommit', 'gitrebase', },
  command  = 'startinsert | 1'
})

api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing spaces',
  pattern = {'*.journal'},
  command = '%s/\\s\\+$//e'
})

api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight yanked text',
  group = api.nvim_create_augroup('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank{hlgroup='IncSearch', timeout=300}
  end,
})

local OpenQuickfix = api.nvim_create_augroup('OpenQuickfix', { clear = true })
api.nvim_create_autocmd('QuickFixCmdPost', {
  desc = 'Open quickfix list when running a quickfix command',
  group = OpenQuickfix,
  pattern = '[^l]*',
  command = 'cwindow'
})

api.nvim_create_autocmd('QuickFixCmdPost', {
  desc = 'Open location list when running a location command',
  group = OpenQuickfix,
  pattern = 'l*',
  command = 'lwindow'
})


-- FUNCTIONS
-- save and close buffer
vim.api.nvim_create_user_command('Wd', 'write|bdelete', {})

-- Align ledger amounts and add trailing zeros when needed
function _G.BetterLedgerAlign()
  if string.find(vim.fn.getline('.'):sub(-1), '%d') then
    local str = vim.fn.getline('.')
    local elements = {}

    for el in str:gmatch('%S+') do table.insert(elements, el) end

    local amt = elements[#elements]
    if not string.find(amt, ',') then
      vim.cmd('normal A,00')
    else
      local pos = string.find(amt, ',')
      if pos == #amt-1 then
        vim.cmd('normal A0')
      end
    end
    vim.cmd(':LedgerAlign')
    return ''
  else
    return ''
  end
end

-- write a note in the editor
function _G.Annotate()

  local date = os.date('%Y%m%d')
  local time = os.date('%H:%M')

  local filename = date .. '.md'
  local fullpath = '/Users/guido/.notes/notepad/' .. filename

  local f = io.open(fullpath, 'r')
  if f ~= nil and io.close(f) then
    local file = io.open(fullpath, 'a')
    file:write('\n> UPDATED @ ' .. time)
    file:close()
  else
    local file = io.open(fullpath, 'w')
    file:write('# ' .. os.date('%Y-%m-%d'))
    file:close()
  end
end

-- go to root dir when using telescope
function _G.Project_files()
  local ok = pcall(require('telescope.builtin').git_files)
  if not ok then
    require('telescope.builtin').find_files()
  end
end
