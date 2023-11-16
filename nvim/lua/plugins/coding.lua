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

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "TroubleToggle", "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle <cr>" },
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>" },
    },
  },
}
