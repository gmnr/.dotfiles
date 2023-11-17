return {

  -- html/css development
  {
    "mattn/emmet-vim",
    config = function()
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
    keys = {
      { mode = "i", "<CR>", "<cmd>lua better_ledger_align()<CR><Right><CR>", { silent = true } },
    },
  },

  {
    "preservim/vim-markdown",
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_conceal = 2
      vim.g.vim_markdown_frontmatter = 1
    end,
    ft = { "markdown" },
  },
}
