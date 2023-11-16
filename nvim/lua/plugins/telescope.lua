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
    opts = {
      defaults = {
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
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<ESC>"] = require("telescope.actions").close, -- don't enable normal mode
              ["<C-u>"] = false, -- clear prompt with C-u
              ["<C-n>"] = require("telescope.actions").move_selection_next,
              ["<C-e>"] = require("telescope.actions").move_selection_previous,
              ["<C-k>"] = require("telescope.actions").preview_scrolling_down,
              ["<C-y>"] = require("telescope.actions").preview_scrolling_up,
            },
          },
        },
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
      })

      pcall(require("telescope").load_extension, "fzf")
    end,
  },
}
