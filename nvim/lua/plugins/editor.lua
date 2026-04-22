return {

  {
    "monaqa/dial.nvim",
    event = "VeryLazy",
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.constant.alias.bool,
          augend.integer.alias.decimal_int,
          augend.date.alias["%d/%m/%Y"],
          augend.date.alias["%Y-%m-%d"],
        },
      })
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
    end,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
  },

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
          {
            icon = " ",
            title = "Keymaps",
            indent = 2,
            padding = 1,
            { icon = " ", key = "a", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "s", desc = "Git Files", action = ":lua Snacks.dashboard.pick('git_status')" },
            { icon = " ", key = "d", desc = "Git Hunks", action = ":lua Snacks.dashboard.pick('git_diff')" },
            { icon = " ", key = "/", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            {
              icon = " ",
              key = "fd",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = '~/.dotfiles', hidden = true})",
            },
            {
              icon = " ",
              key = "g",
              desc = "Git",
              action = ":lua Snacks.lazygit()",
              enabled = function()
                return Snacks.git.get_root() ~= nil
              end,
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          { icon = " ", title = "Projects", section = "projects", limit = 4, indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          {
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git --no-pager diff --stat -B -M -C",
            indent = 2,
            padding = 1,
          },
          { section = "startup" },
        },
      },
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
            sql = true,
          }
          return vim.g.snacks_indent ~= false
            and b.snacks_indent ~= false
            and bo.buftype == ""
            and not excluded_filetypes[bo.filetype]
        end,
      },
      input = { enabled = true },
      lazygit = {
        config = {
          os = {
            editPreset = "nvim-remote",
            edit = '[ -z "$NVIM" ] && (nvim -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" && nvim --server "$NVIM" --remote {{filename}})',
            editAtLine = '[ -z "$NVIM" ] && (nvim +{{line}} -- {{filename}}) || (nvim --server "$NVIM" --remote-send "q" &&  nvim --server "$NVIM" --remote {{filename}} && nvim --server "$NVIM" --remote-send ":{{line}}<CR>")',
          },
          notARepository = "skip",
          gui = {
            authorColors = {
              gmnr = "#e0af68",
            },
            sidePanelWidth = 0.18,
            showFileTree = false,
            scrollHeight = 15,
            scrollPastBottom = false,
            commandLogSize = 3,
            filterMode = "fuzzy",
            mainPanelSplitMode = "vertical",
            enlargedSideViewLocation = "top",
          },
          keybinding = {
            files = {
              toggleTreeView = "",
            },
            universal = {
              nextScreenMode = "`",
              prevScreenMode = "~",
            },
          },
          git = {
            paging = { pager = "delta --dark --paging=never", colorArg = "always" },
          },
          promptToReturnFromSubprocess = false,
        },
        win = {
          height = 0,
          width = 0,
        },
      },
      picker = {
        sources = {
          buffers = { current = false },
          files = { hidden = true },
          grep = { hidden = true },
          projects = {
            filter = { paths = { ["~/.local/share/nvim/lazy/snacks.nvim"] = false, ["/opt/homebrew"] = false } },
          },
          explorer = {
            layout = { layout = { position = "right" } },
            auto_close = true,
            hidden = true,
          },
        },
        layout = { preset = "ivy" },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<c-o>"] = { "qflist", mode = { "i", "n" } },
              ["<c-e>"] = { "preview_scroll_up", mode = { "i", "n" } },
              ["<c-n>"] = { "preview_scroll_down", mode = { "i", "n" } },
              ["<c-d>"] = { "edit_vsplit", mode = { "i", "n" } },
            },
          },
        },
      },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 100 },
          easing = "linear",
        },
        animate_repeat = {
          delay = 50, -- delay in ms before using the repeat animation
          duration = { step = 3, total = 20 },
          easing = "linear",
        },
      },
    },
    keys = {
      {
        "<leader><space>",
        function()
          if vim.loop.cwd() == "/Users/gmnr" then
            Snacks.picker.projects()
          else
            Snacks.picker.smart()
          end
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
          Snacks.picker.grep({ cwd = Snacks.git.get_root() })
        end,
      },
      {
        "<leader>yn",
        function()
          Snacks.picker.notifications()
        end,
      },
      {
        "<leader>yw",
        function()
          Snacks.explorer({ cwd = Snacks.git.get_root() })
        end,
      },
      -- find
      {
        "<leader>fd",
        function()
          Snacks.picker.files({ cwd = "~/.dotfiles" })
        end,
      },
      {
        "<leader>ya",
        function()
          Snacks.picker.files({ cwd = Snacks.git.get_root() })
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
        "<leader>yx",
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
        "<leader>yk",
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
