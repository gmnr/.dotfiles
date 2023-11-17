return {

  "tpope/vim-commentary",

  "tpope/vim-fugitive",

  "tpope/vim-repeat",

  "tpope/vim-speeddating",

  "tpope/vim-surround",

  "tpope/vim-unimpaired",

  "wellle/targets.vim",

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
    },
    config = function()
      vim.cmd(
        [[let g:quickrun_config = {'*': {'hook/time/enable': 1, 'hook/time/format': '[Finished in %gs]', 'outputter/buffer/opener': '%{"bel 12new"}'}}]]
      )
    end,
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      config = function()
        require("mason").setup()
      end,
      build = ":MasonUpdate",
      keys = { { "<leader>cm", "<cmd>Mason<cr>" } },
      opts = {
        ensure_installed = {
          "stylua",
          "pyright",
          "black",
        },
      },
    },
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    lazy = true,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- diagnostic
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle <CR>" },
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>" },
    },
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    ft = { "python", "lua", "bash" },
    config = function()
      -- config lspgconfig
      local nvim_lsp = require("lspconfig")
      local servers = {
        "pyright",
        "lua_ls",
        "bashls",
      }
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup({
          root_dir = nvim_lsp.util.root_pattern(".git"),
        })
      end

      -- fix global variable vim not found
      nvim_lsp.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },

  -- IDE capabilities
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({})
      vim.diagnostic.config({ virtual_text = false, underline = true, severity_sort = true })
      local signs = { Error = "", Warn = "", Hint = "", Information = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      border_style = "single",
      saga_winblend = 0,
      move_in_saga = { prev = "<C-y>", next = "<C-k>" },
      diagnostic_header = { " ", " ", " ", "ﴞ " },
      show_diagnostic_source = true,
      -- diagnostic_source_bracket = {},
      max_preview_lines = 10,
      code_action_icon = "",
      code_action_num_shortcut = true,
      code_action_lightbulb = {
        enable = true,
        sign = true,
        enable_in_insert = true,
        sign_priority = 20,
        virtual_text = true,
      },
      finder_icons = {
        def = "  ",
        ref = "諭 ",
        link = "  ",
      },
      finder_request_timeout = 1500,
      finder_action_keys = {
        open = "o",
        vsplit = "s",
        split = "i",
        tabe = "t",
        quit = "q",
        scroll_down = "<C-f>",
        scroll_up = "<C-b>", -- quit can be a table
      },
      code_action_keys = {
        quit = "q",
        exec = "<CR>",
      },
      rename_action_quit = "q",
      rename_in_select = true,
      show_outline = {
        win_position = "right",
        win_with = "",
        win_width = 30,
        auto_enter = true,
        auto_preview = true,
        virt_text = "┃",
        jump_key = "o",
        auto_refresh = true,
      },
      server_filetype_map = {},
    },
  },
}
