if !exists('g:loaded_nvim_treesitter')
  finish
endif

lua << EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enabled = false,
    disable = {},
  },
  ensure_installed = {
    'bash',
    'css',
    'html',
    'javascript',
    'json5',
    'lua',
    'python',
    'vim'
  },
}
EOF
