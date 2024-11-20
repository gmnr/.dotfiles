return {

  -- mason
  {
    "williamboman/mason.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    build = ":MasonUpdate",
    keys = { { "<leader>fy", "<cmd>Mason<cr>" } },
    config = true,
    opts = {
      ensure_installed = {
        "stylua",
        "pyright",
        "black",
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "marksman",
          "pyright",
        },
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })

      -- ignore vim global in lua files
      require("lspconfig").pyright.setup({
        settings = {
          python = {
            pythonPath = "/usr/local/bin/python3",
          },
        },
      })

      -- ignore vim global in lua files
      require("lspconfig").bashls.setup({
        filetypes = { "sh", "zsh", "bash" },
      })

      -- ignore vim global in lua files
      require("lspconfig").lua_ls.setup({
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
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        json = { "jq" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        html = { "prettier" },
        markdown = { "prettier" },
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
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>" },
    },
    opts = {}, -- don't omit
  },

  -- lsp saga
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        code_action = {
          keys = {
            quit = "<C-q>",
            exec = "<CR>",
          },
        },
        lightbulb = {
          enable = true,
          sign = true,
          enable_in_insert = false,
          sign_priority = 20,
          virtual_text = false,
        },
        rename = {
          keys = {
            quit = "<C-q>",
            exec = "<CR>",
          },
        },
      })

      -- vim diagnostic config
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
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
