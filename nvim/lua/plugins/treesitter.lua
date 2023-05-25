local M = {}

function M.config()
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true,
    },
    indent = {
      enabled = false,
      disable = {},
    },
    ensure_installed = {'bash', 'css', 'html', 'javascript', 'json5', 'ledger', 'lua', 'norg', 'python'},
    sync_install = true, -- install synchronously
		ignore_install = {}, -- parsers to not install
  }
end

return M
