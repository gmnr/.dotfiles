return {

  -- mason
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls",
        "lua_ls",
        "marksman",
        "basedpyright",
      },
    },
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "stylua",
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
          vim.lsp.config("basedpyright", {
            settings = {
              basedpyright = { analysis = { typeCheckingMode = 'basic' } },
            },
          })

          -- add hover to lsp doc
          local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
          function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = "rounded"
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
          end
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
        holywell_formatter = {
          command = "python3",
          args = { "/Users/gmnr/.dotfiles/formatting/sql-formatter.py" },
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
        sql = { "holywell_formatter" },
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
