local M = {}

function M.config()
  require('orgmode').setup_ts_grammar()
  require('orgmode').setup({
    org_agenda_files = {'~/.notes/*'},
    org_default_notes_file = '~/.notes/refile.org',
    mappings = {
      prefix = '\\'
    }
  })
end

return M
