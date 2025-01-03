return {

  -- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "fhill2/telescope-ultisnips.nvim",
        config = function()
          require("telescope").load_extension("ultisnips")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "SirVer/ultisnips",
        config = function()
          vim.g.UltiSnipsExpandTrigger = "<Tab>"
          vim.g.UltiSnipsJumpForwardTrigger = "<C-n>"
          vim.g.UltiSnipsJumpBackwardTrigger = "<C-e>"
          vim.g.UltiSnipsSnippetDirectories = { "snppts" }
        end,
      },
      "honza/vim-snippets",
    },
    opts = function()
      local actions = require("telescope.actions")

      return {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--glob=!.git/",
          },
          file_ignore_patterns = {
            ".local/",
            ".cache/",
            "^Downloads/",
            ".git/",
            "Library/",
            "plugged/",
            "node_modules/",
          },
          mappings = {
            i = {
              ["<ESC>"] = actions.close, -- don't enable normal mode
              ["<C-u>"] = false, -- clear prompt with C-u
              ["<C-k>"] = actions.move_selection_next,
              ["<C-y>"] = actions.move_selection_previous,
              ["<C-n>"] = actions.preview_scrolling_down,
              ["<C-e>"] = actions.preview_scrolling_up,
              ["<C-d>"] = actions.select_vertical,
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
        },
        pickers = {
          find_files = {
            find_command = { "fd", "--type", "f", "--color=never", "--hidden" },
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
            hijack_netrw = true,
          },
        },
      }
    end,
  },
}
