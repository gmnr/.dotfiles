-- define a local Plug variable
local Plug = vim.fn['plug#']

-- start install
vim.call('plug#begin')

Plug 'windwp/nvim-autopairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-easy-align'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'hrsh7th/nvim-cmp'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-orgmode/orgmode'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})
Plug('mattn/emmet-vim', {['for'] = {'html', 'css'}})
Plug('ledger/vim-ledger', {['for'] = {'ledger'}})

vim.call('plug#end')
