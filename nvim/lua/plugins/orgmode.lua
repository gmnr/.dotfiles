local M = {}

function M.config()
  require('orgmode').setup_ts_grammar()
  require('orgmode').setup({
    org_agenda_files = {'~/.notes/*'},
    org_default_notes_file = '~/.notes/inbox.org',
    org_todo_keywords = {'TODO', 'NEXT', 'HOLD', '|', 'DONE', 'CANCELED'},
    org_todo_keyword_faces = {
      NEXT = ':foreground cyan',
      CANCELED = ':foreground magenta',
      HOLD = ':foreground orange'
    },
    org_archive_location = '~/.notes/archive/archive.org',
    org_capture_templates = {
      t = {
        description = 'Task',
        template = '* TODO %?\nEntered on %U',
        target = '~/.notes/inbox.org'
      }
    }
  })
end

return M
