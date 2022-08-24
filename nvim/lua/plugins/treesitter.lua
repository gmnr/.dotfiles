local F = {}

function F.config()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false, -- disable standard vim highlighting
    },
    indent = {
      enabled = false,
      disable = {},
    },
    ensure_installed = {'bash', 'css', 'html', 'javascript', 'json5', 'lua', 'ledger', 'python'},
    sync_install = true, -- install synchronously
		ignore_install = {}, -- parsers to not install
  }
end

return F
