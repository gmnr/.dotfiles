local F = {}

function F.config()
  require('telescope').setup{
    defaults = {
      file_ignore_patterns = {'.git', '/helper'}
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        hidden = true
      },
      live_grep = {
        theme = "dropdown",
      },
      buffers = {
        theme = "dropdown",
      },
      tags = {
        theme = "dropdown",
      },
      git_status = {
        theme = "dropdown",
      },
      git_files = {
        theme = "dropdown",
      },
      git_branches = {
        theme = "dropdown",
      }
    }
  }
end

return F
