" lugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'Raimondi/delimitMate'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'thinca/vim-quickrun'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vimwiki/vimwiki'
Plug 'wellle/targets.vim'

" nvim specific plugins
if has("nvim")
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-path'
  Plug 'quangnguyen30192/cmp-nvim-ultisnips'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'onsails/lspkind-nvim'
endif

" Finish installation
call plug#end()
