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
            pythonPath = "/usr/local/bin/python3.11",
            pythonVersion = "3.11",
          },
        },
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
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<CR>" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<CR>" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<CR>" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<CR>" },
    },
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

      vim.diagnostic.config({ virtual_text = false, underline = true, severity_sort = true })
      local signs = { Error = "✘", Warn = "", Hint = "⚑", Information = "»" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
}
