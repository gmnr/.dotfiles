return {

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = actions.close, -- don't enable normal mode
              ["<C-u>"] = false, -- clear prompt with C-u
              ["<C-k>"] = actions.move_selection_next,
              ["<C-y>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.preview_scrolling_down,
              ["<C-e>"] = actions.preview_scrolling_up,
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
          sorting_strategy = "ascending",
          layout_strategy = "bottom_pane",
          preview_cutoff = 120,
          layout_config = {
            height = 25,
          },
          border = true,
          borderchars = {
            prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
            results = { " " },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          },
          winblend = 0,
          pickers = {
            find_files = {
              find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }, -- look into hidden dirs but not .git
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,
              override_generic_sorter = true,
              override_file_sorter = true,
              case_mode = "smart_case",
            },
            file_browser = {
              theme = "ivy",
              hijack_netrw = true,
            },
          },
        },
      }
    end,
  },
}
