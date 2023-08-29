-- Telescope plugin config
local M = {}

function M.config()
  local actions = require('telescope.actions')

  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ['<ESC>'] = actions.close,  -- don't enable normal mode
          ['<C-u>'] = false  -- clear prompt with C-u
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },  -- find_files should look into hidden dirs, but not into .git
      },
    }
  }

  Project_files = function()  -- define global function that uses git if dir is available otherwise find_files
    local ok = pcall(require('telescope.builtin').git_files)
    if not ok then
      require('telescope.builtin').find_files()
    end
  end

end

return M
