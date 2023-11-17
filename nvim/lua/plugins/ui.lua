return {

  -- highlight
  "haya14busa/is.vim",

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-storm")

      -- add colors to types in autocompletion
      vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE guifg=#808080")
      vim.cmd("highlight! CmpItemAbbrMatch      guibg=NONE guifg=#98C379")
      vim.cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#98C379")
      vim.cmd("highlight! CmpItemKindInterface  guibg=NONE guifg=#98C379")
      vim.cmd("highlight! CmpItemKindUnit       guibg=NONE guifg=#98C379")
      vim.cmd("highlight! CmpItemKindFunction   guibg=NONE guifg=#C678DD")
      vim.cmd("highlight! CmpItemKindKeyword    guibg=NONE guifg=#C678DD")
      vim.cmd("highlight! CmpItemKindMethod     guibg=NONE guifg=#E06C75")
      vim.cmd("highlight! CmpItemKindProperty   guibg=NONE guifg=#E06C75")
      vim.cmd("highlight! CmpItemKindVariable   guibg=NONE guifg=#61AFEF")
      vim.cmd("highlight! CmpItemKindText       guibg=NONE guifg=#ABB2BF")
      vim.cmd("highlight! CmpItemKindClass      guibg=NONE guifg=#E5C07B")

      -- modify spell error highlighings
      vim.cmd("highlight! SpellBad              guibg=NONE guifg=#E5C07B")
      vim.cmd("highlight! SpellCap              guibg=NONE guifg=#E5C07B")
      vim.cmd("highlight! SpellLocal            guibg=NONE guifg=#E5C07B")
      vim.cmd("highlight! SpellRare             guibg=NONE guifg=#E5C07B")

      -- define custom colors for gitsigns
      vim.cmd("highlight! GitSignsAdd           guibg=NONE guifg=#92BE65")
      vim.cmd("highlight! GitSignsAddNr         guibg=NONE guifg=#92BE65")
      vim.cmd("highlight! GitSignsChange        guibg=NONE guifg=#7AA2F7")
      vim.cmd("highlight! GitSignsChangeNr      guibg=NONE guifg=#7AA2F7")
      vim.cmd("highlight! GitSignsDelete        guibg=NONE guifg=#D74B4B")
      vim.cmd("highlight! GitSignsDeleteNr      guibg=NONE guifg=#D74B4B")
    end,
  },

  -- indent blankline
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      indent = {
        char = "│",
        tab_char = "│",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          -- "Trouble",
          "ledger",
          "lazy",
          "mason",
        },
      },
    },
    main = "ibl",
  },

  -- indent scope
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          -- "Trouble",
          "ledger",
          "lazy",
          "mason",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        changedelete = {
          hl = "GitSignsChange",
          text = "▎",
          numhl = "GitSignsChangeNr",
          linehl = "GitSignsChangeLn",
        },
        delete = { hl = "GitSignsDelete", text = "~", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
        topdelete = {
          hl = "GitSignsDelete",
          text = "_",
          numhl = "GitSignsDeleteNr",
          linehl = "GitSignsDeleteLn",
        },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "right_align",
        delay = 1000,
        ignore_whitespace = false,
      },
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false,
      },
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
        lualine_c = { "filename" },
        lualine_x = { "encoding", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "fugitive" },
    },
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
}
