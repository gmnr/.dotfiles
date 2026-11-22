return {

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      require("nvim-treesitter").install({
        "bash",
        "zsh",
        "css",
        "html",
        "javascript",
        "ledger",
        "lua",
        "markdown",
        "markdown_inline",
        "regex",
        "python",
        "sql",
      })
    end,
  },
}
