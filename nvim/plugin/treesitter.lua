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
    'ledger',
    'python'
  },
}
