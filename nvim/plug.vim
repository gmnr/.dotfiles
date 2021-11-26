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
Plug 'ludovicchabant/vim-gutentags'
Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'


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
endif

" Finish installation
call plug#end()
