return {

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
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
              ["<C-n>"] = actions.move_selection_next,
              ["<C-e>"] = actions.move_selection_previous,
              ["<C-k>"] = actions.preview_scrolling_down,
              ["<C-y>"] = actions.preview_scrolling_up,
            },
          },
          prompt_prefix = " ",
          selection_caret = " ",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.5,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          sorting_strategy = "ascending",
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
          },
        },
      }
    end,
  },
}
