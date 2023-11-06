-- Telescope plugin config
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<ESC>'] = require('telescope.actions').close,  -- don't enable normal mode
        ['<C-u>'] = false,  -- clear prompt with C-u
        ['<C-n>'] = require('telescope.actions').move_selection_next,
        ['<C-e>'] = require('telescope.actions').move_selection_previous,
        ['<C-k>'] = require('telescope.actions').preview_scrolling_down,
        ['<C-y>'] = require('telescope.actions').preview_scrolling_up
      },
    },
  },
  pickers = {
    find_files = {
      find_command = { 'rg', '--files', '--hidden', '--glob', '!.git/*' },  -- find_files should look into hidden dirs, but not .git
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

-- enable optimization
require('telescope').load_extension('fzf')

-- define global function that uses git if dir is available otherwise find_files
Project_files = function()
  local ok = pcall(require('telescope.builtin').git_files)
  if not ok then
    require('telescope.builtin').find_files()
  end
end
