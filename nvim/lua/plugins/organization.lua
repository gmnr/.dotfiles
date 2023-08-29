-- Neorg plugin config
local M = {}

function M.config()
  require('neorg').setup {
    load = {
      ["core.defaults"] = {},
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            test = "~/.notes/norg",
          },
        },
      },
    },
  }
end

return M
