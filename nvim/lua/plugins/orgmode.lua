local M = {}

function M.config()
  require('orgmode').setup_ts_grammar()
  require('orgmode').setup({
    org_agenda_files = {'~/.notes/*'},
    org_default_notes_file = '~/.notes/inbox.org',
    org_hide_leading_stars = true,
    mappings = {
      prefix = '<C-r>',
      global = {
        org_agenda = '<C-r>p',
        org_capture = '<C-r>l'
      }
    },
    org_capture_templates = {
      T = { description = 'Tickler',
      template = '* %? \n %u',
      target = '~/.notes/tickler.org'
      },
      t = { description = 'Task',
      template = '* TODO %?',
      target = '~/.notes/inbox.org'
      }
    }
  })
end

return M
