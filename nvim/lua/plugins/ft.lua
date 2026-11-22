return {

  -- html/css development
  {
    "mattn/emmet-vim",
    init = function()
      vim.g.user_emmet_mode = "nv"
      vim.g.user_emmet_leader_key = "<leader>"
    end,
    ft = { "html", "css" },
  },

  -- ledger
  {
    "ledger/vim-ledger",
    config = function()
      vim.g.ledger_bin = "hledger"
      vim.g.ledger_decimal_sep = ","
    end,
    ft = { "ledger" },
  },

  {
    "SirVer/ultisnips",
    dependencies = { "honza/vim-snippets" },
    ft = { "markdown", "ledger", "python", "javascript", "html", "css", "text" },
    init = function()
      vim.g.UltiSnipsExpandTrigger = "<Tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<C-n>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<C-e>"
      vim.g.UltiSnipsSnippetDirectories = { "snppts" }
    end,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    config = function()
      local presets = require("markview.presets")

      require("markview").setup({
        splitview_winopts = {
          split = "right",
        },
        preview = {
          enable = false,
          icon_provider = "devicons",
        },
        markdown = {
          headings = presets.headings.marker,
          horizontal_rules = presets.thin,
          tables = presets.single,
        },
      })
      require("modules.markview_split").setup()
    end,
  },
}
