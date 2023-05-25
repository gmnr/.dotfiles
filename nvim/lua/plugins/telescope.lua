local M = {}

function M.config()
  local finders = require("telescope.finders")
  local pickers = require("telescope.pickers")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorters = require("telescope.sorters")

  require("telescope").setup{
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,  -- don't enable normal mode
          ["<C-u>"] = false  -- clear prompt with C-u
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },  -- find_files should look into hidden dirs, but not into .git
      },
    }
  }

  Project_files = function()  -- define global function that uses git if dir is available otherwise find_files
    local ok = pcall(require"telescope.builtin".git_files)
    if not ok then
      require"telescope.builtin".find_files()
    end
  end

  Telescope_hledger_account = function()
    pickers.new {
      results_title = "Hledger Accounts",
      finder = finders.new_oneshot_job({"hledger", "-f", "~/.finance/all.journal", "accounts"}),
      sorter = sorters.get_fuzzy_file(),
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.api.nvim_put({ "  " .. selection[1] .. "   " }, "", false, true)
        end)
        return true
      end,
    }:find()
  end

end

return M
