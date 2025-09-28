return {

  -- mason
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "lua_ls",
        "marksman",
        "pyright",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
            "pyright",
            "black",
          },
        },
      },
      {
        "neovim/nvim-lspconfig",
        config = function()
          vim.lsp.config("lua_ls", {
            settings = { Lua = { diagnostics = { globals = { "vim", "Snacks" } } } },
          })
          vim.lsp.config("bashls", {
            filetypes = { "zsh", "sh", "bash" },
          })
          vim.lsp.config("pyright", {
            settings = {
              python = { analysis = { diagnosticSeverityOverrides = { reportPossiblyUnboundVariable = "none" } } },
            },
          })

          -- add here diagnostic config
          vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            severity_sort = true,
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = "✘",
                [vim.diagnostic.severity.WARN] = "",
                [vim.diagnostic.severity.HINT] = "⚑",
                [vim.diagnostic.severity.INFO] = "»",
              },
            },
          })
        end,
      },
    },
  },

  -- formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    lazy = true,
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Run conform",
        mode = "",
      },
    },
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters = {
        my_sql_formatter = {
          command = "python3",
          args = { "/Users/gmnr/.dotfiles/scripts/sql-formatter.py" },
          stdin = true,
        },
        prettier = {
          prepend_args = function()
            return {
              "--print-width",
              "80",
              "--prose-wrap",
              "always",
            }
          end,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        json = { "jq" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
        sql = { "my_sql_formatter" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  -- diagnostic
  {
    "folke/trouble.nvim",
    event = "LspAttach",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
      { "<leader>XX", "<cmd>Trouble diagnostics toggle<cr>" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>" },
    },
    opts = {}, -- don't omit
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
