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
        html = { "prettier" },
        markdown = { "prettier" },
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
      require("lspsaga").setup({})
      vim.diagnostic.config({ virtual_text = false, underline = true, severity_sort = true })
      local signs = { Error = "✘", Warn = "", Hint = "⚑", Information = "»" }
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
      diagnostic_header = { "✘ ", " ", "⚑ ", "» " },
      show_diagnostic_source = true,
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
