-- Neorg plugin config
require('neorg').setup {
  load = {
    ['core.defaults'] = {},
    ['core.concealer'] = {},
    ['core.dirman'] = {
      config = {
        workspaces = {
          test = '~/.notes/norg',
        },
      },
    },
  },
}
