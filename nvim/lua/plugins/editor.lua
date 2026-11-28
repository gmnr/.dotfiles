return {

  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "sindrets/diffview.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>" },
    },
    opts = {
      signs = {
        section = { "◈", " " },
      },
      graph_style = "kitty",
      mappings = {
        status = {
          [">"] = "Toggle",
          ["<"] = "Toggle",
        },
      },
    },
  },

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
      vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal())
      vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal())
    end,
  },

  {
    "stevearc/quicker.nvim",
    ft = "qf",
    opts = {},
  },

  {
    "nvim-mini/mini.ai",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.ai").setup()
    end,
  },

  {
    "nvim-mini/mini.align",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.align").setup()
    end,
  },

  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "<leader>sa",
          delete = "<leader>sd",
          find = "<leader>sf",
          find_left = "<leader>sF",
          highlight = "<leader>sh",
          replace = "<leader>sc",
          update_n_lines = "<leader>sn",
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      npairs.setup({
        disable_filetype = {
          "ledger",
          "markdown",
          "text",
        },
      })
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
      })
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
    init = function()
      vim.g.quickrun_config = {
        ["*"] = {
          ["outputter/buffer/opener"] = '%{winwidth(0) * 2 < winheight(0) * 5 ? "16new" : "vnew"}',
          ["hook/time/enable"] = 1,
          ["hook/time/format"] = "[Finished in %gs]",
        },
        python = { command = "uv", cmdopt = "run", ["hook/shebang/enable"] = 0 },
      }
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
              action = ":Neogit",
              enabled = function()
                return require("modules.project").root() ~= nil
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
              return require("modules.project").root() ~= nil
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
      picker = {
        sources = {
          buffers = { current = false },
          files = { hidden = true, ignored = true, exclude = { ".venv", "venv" } },
          grep = { hidden = true, exclude = { ".venv", "venv" } },
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
    keys = function()
      local function repo_root()
        return { cwd = require("modules.project").root() }
      end

      local picker_keys = {
        -- find
        {
          "<leader>fd",
          function()
            local root = require("modules.project").root()
            if root then
              Snacks.picker.files({ cwd = root })
            else
              Snacks.picker.projects()
            end
          end,
          desc = "Files in repo (projects outside one)",
        },
        {
          "<leader><space>",
          "files",
          function()
            return { cwd = vim.env.DOTFILES }
          end,
          desc = "Dotfiles",
        },
        { "<leader>,", "buffers", desc = "Buffers" },
        { "<leader>/", "grep", repo_root, desc = "Grep repo" },
        { "<leader>yw", "explorer", repo_root, desc = "Explorer" },
        { "<leader>ya", "smart", desc = "Smart find" },
        { "<leader>yg", "git_files", desc = "Git files" },
        { "<leader>yp", "projects", desc = "Projects" },

        -- git
        { "<leader>yb", "git_branches", desc = "Git branches" },
        { "<leader>yl", "git_log", desc = "Git log" },
        { "<leader>ys", "git_status", desc = "Git status" },
        { "<leader>yd", "git_diff", desc = "Git diff (hunks)" },

        -- search
        { '<leader>y"', "registers", desc = "Registers" },
        { "<leader>:", "commands", desc = "Commands" },
        { "<leader>yh", "help", desc = "Help" },
        { "<leader>yk", "keymaps", desc = "Keymaps" },
        { "<leader>ym", "man", desc = "Man pages" },
        { "<leader>yn", "notifications", desc = "Notifications" },
        { "<leader>yq", "qflist", desc = "Quickfix list" },
        { "<leader>yL", "loclist", desc = "Location list" },
        { "<leader>yy", "resume", desc = "Resume last picker" },
        { "<leader>yu", "undo", desc = "Undo history" },

        { "<leader>yx", "diagnostics_buffer", desc = "Diagnostics (buffer)" },
        { "<leader>yX", "diagnostics", desc = "Diagnostics (all)" },
        {
          "<leader>yS",
          "lsp_symbols",
          { layout = { preset = "right" }, jump = { close = false } },
          desc = "Symbols sidebar",
        },
        {
          "<leader>yR",
          "lsp_references",
          { layout = { preset = "right" }, jump = { close = false } },
          desc = "References sidebar",
        },

        -- lsp
        { "gd", "lsp_definitions", desc = "Definitions" },
        { "gD", "lsp_declarations", desc = "Declarations" },
        { "gI", "lsp_implementations", desc = "Implementations" },
        { "gy", "lsp_type_definitions", desc = "Type definitions" },
      }

      return vim.tbl_map(function(row)
        local lhs, picker, opts = row[1], row[2], row[3]
        local rhs = picker
        if type(picker) == "string" then
          rhs = function()
            Snacks.picker[picker](type(opts) == "function" and opts() or opts)
          end
        end
        return { lhs, rhs, desc = row.desc }
      end, picker_keys)
    end,
  },
}
