-- Plugins loader config
-- define a local Plug variable
local Plug = vim.fn['plug#']

-- start install
vim.call('plug#begin')

Plug 'folke/tokyonight.nvim'
Plug 'haya14busa/is.vim'
Plug 'honza/vim-snippets'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'junegunn/vim-easy-align'
Plug 'lewis6991/gitsigns.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-neorg/neorg'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvimdev/lspsaga.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
Plug 'SirVer/ultisnips'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'windwp/nvim-autopairs'
Plug('ledger/vim-ledger', {['for'] = { 'ledger' }})
Plug('mattn/emmet-vim', {['for'] = { 'html', 'css' }})
Plug('nvim-treesitter/nvim-treesitter', {['do'] = vim.fn['TSUpdate']})
Plug('preservim/vim-markdown', {['for'] = { 'markdown' }})

vim.call('plug#end')
