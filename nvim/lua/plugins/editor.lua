return {

  "tpope/vim-fugitive",

  { "tpope/vim-repeat", event = "VeryLazy" },

  { "tpope/vim-speeddating", event = "VeryLazy" },

  { "tpope/vim-surround", event = "VeryLazy" },

  { "tpope/vim-unimpaired", event = "VeryLazy" },

  {
    "wellle/targets.vim",
    event = "VeryLazy",
    config = function()
      vim.cmd([[
      nnoremap <silent> <Leader>a :set opfunc=Append<CR>g@
      nnoremap <silent> <Leader>i :set opfunc=Insert<CR>g@
      function! Append(type, ...)
          call feedkeys("`]a", 'n')
      endfunction
      function! Insert(type, ...)
          call feedkeys("`[i", 'n')
      endfunction
      ]])
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        exclude_dirs = { "~/Documents/advent-of-code/*" },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      return {
        npairs.setup({
          disable_filetype = {
            "ledger",
            "markdown",
            "text",
            "norg",
          },
        }),
        npairs.add_rules({
          Rule(" ", " "):with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ "()", "[]", "{}" }, pair)
          end),
          Rule("( ", " )")
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match(".%)") ~= nil
            end)
            :use_key(")"),
          Rule("{ ", " }")
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match(".%}") ~= nil
            end)
            :use_key("}"),
          Rule("[ ", " ]")
            :with_pair(function()
              return false
            end)
            :with_move(function(opts)
              return opts.prev_char:match(".%]") ~= nil
            end)
            :use_key("]"),
        }),
      }
    end,
  },

  -- quickrun
  {
    "thinca/vim-quickrun",
    ft = {
      "python",
      "javascript",
      "typescript",
      "sh",
    },
    config = function()
      vim.cmd([[let g:quickrun_config = {'*': {'hook/time/enable': 1, 'hook/time/format': '[Finished in %gs]'}}]])
    end,
  },

  -- snacks
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
      dim = {},
      explorer = { enabled = true },
      indent = {
        filter = function(buf)
          local b = vim.b[buf]
          local bo = vim.bo[buf]
          local excluded_filetypes = {
            help = true,
            ledger = true,
            lazy = true,
            man = true,
            mason = true,
          }
          return vim.g.snacks_indent ~= false
            and b.snacks_indent ~= false
            and bo.buftype == ""
            and not excluded_filetypes[bo.filetype]
        end,
      },
      input = { enabled = true },
      picker = {
        layout = { preset = "ivy" },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-k>"] = { "list_down", mode = { "i", "n" } },
              ["<c-y>"] = { "list_up", mode = { "i", "n" } },
              ["<c-e>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
            },
          },
        },
      },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      words = { enabled = true },
    },
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
      },
      {
        "<leader>ye",
        function()
          Snacks.explorer()
        end,
      },
      -- find
      {
        "<leader>fd",
        function()
          Snacks.picker.files({ cwd = "~/.dotfiles", hidden = true })
        end,
      },
      {
        "<leader>ya",
        function()
          Snacks.picker.files({ cwd = Snacks.git.get_root(), hidden = true })
        end,
      },
      {
        "<leader>yg",
        function()
          Snacks.picker.git_files()
        end,
      },
      {
        "<leader>yp",
        function()
          Snacks.picker.projects()
        end,
      },
      -- git
      {
        "<leader>yb",
        function()
          Snacks.picker.git_branches()
        end,
      },
      {
        "<leader>yl",
        function()
          Snacks.picker.git_log()
        end,
      },
      {
        "<leader>ys",
        function()
          Snacks.picker.git_status()
        end,
      },
      {
        "<leader>yd",
        function()
          Snacks.picker.git_diff()
        end,
      },
      -- search
      {
        '<leader>y"',
        function()
          Snacks.picker.registers()
        end,
      },
      {
        "<leader>:",
        function()
          Snacks.picker.commands()
        end,
      },
      {
        "<leader>yr",
        function()
          Snacks.picker.diagnostics()
        end,
      },
      {
        "<leader>yh",
        function()
          Snacks.picker.help()
        end,
      },
      {
        "<leader>ym",
        function()
          Snacks.picker.keymaps()
        end,
      },
      {
        "<leader>ym",
        function()
          Snacks.picker.man()
        end,
      },
      {
        "<leader>yq",
        function()
          Snacks.picker.qflist()
        end,
      },
      {
        "<leader>yy",
        function()
          Snacks.picker.resume()
        end,
      },
      {
        "<leader>yu",
        function()
          Snacks.picker.undo()
        end,
      },
      {
        "<leader>yc",
        function()
          Snacks.picker.colorschemes()
        end,
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
      },
    },
  },
}
