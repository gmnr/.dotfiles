" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-fugitive'
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'thinca/vim-quickrun'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'mattn/emmet-vim'
Plug 'junegunn/vim-easy-align'

if has("nvim")
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'onsails/lspkind-nvim'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'nvim-telescope/telescope.nvim'
  " Plug 'hrsh7th/cmp-nvim-lsp'
  "Plug 'kristijanhusak/defx-git'
  "Plug 'kristijanhusak/defx-icons'
  "Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'folke/lsp-colors.nvim'
  "Plug 'L3MON4D3/LuaSnip'
  "Plug 'hrsh7th/cmp-buffer'
  "Plug 'kyazdani42/nvim-web-devicons'
  "Plug 'nvim-lua/popup.nvim'
  "Plug 'nvim-telescope/telescope.nvim'
endif

call plug#end()
