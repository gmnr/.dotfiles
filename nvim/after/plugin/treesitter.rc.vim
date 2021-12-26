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
 textobjects = {
    select = {
      enable = true,

      lookahead = true,

      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['an'] = '@conditional.outer',
        ['in'] = '@conditional.inner',
        ['ak'] = '@comment.outer',
        ['ik'] = '@comment.inner',
      }
    }
  }
}
EOF
