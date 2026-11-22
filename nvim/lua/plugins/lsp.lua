return {

  -- mason
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "stylua",
        "marksman",
        "basedpyright",
      },
      automatic_enable = { exclude = { "stylua" } },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ui = {
            border = "rounded",
          },
        },
      },
    },
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      vim.lsp.config("lua_ls", {
        settings = { Lua = { diagnostics = { globals = { "vim", "Snacks" }, disable = { "need-check-nil" } } } },
      })
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = { analysis = { typeCheckingMode = "basic" } },
        },
      })
    end,
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
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
      },
    },
    opts = {
      -- log_level = vim.log.levels.DEBUG,
      formatters = {
        holywell_formatter = {
          command = "python3",
          args = { "/Users/gmnr/.dotfiles/sql/sql-formatter.py" },
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
        br_newline = {
          command = "sed",
          args = {
            "-e",
            [=[/^[[:space:]]*\(```\|~~~\)/,/^[[:space:]]*\(```\|~~~\)/b]=],
            "-e",
            [=[/^[[:space:]]*|/b]=],
            "-e",
            [=[s/\(<br[[:space:]]*\/\{0,1\}>\)[[:space:]]*\([^[:space:]]\)/\1\n\2/g]=],
          },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        json = { "jq" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier", "br_newline" },
        sql = { "holywell_formatter" },
        sh = { "beautysh" },
        zsh = { "beautysh" },
      },
      format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
