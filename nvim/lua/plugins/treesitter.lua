return {

  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = 'main',
    build = ":TSUpdate",
    init = function()
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      local ensureInstalled = {
        "bash",
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
      }
      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
          :filter(function(parser)
            return not vim.tbl_contains(alreadyInstalled, parser)
          end)
          :totable()
      require('nvim-treesitter').install(parsersToInstall)
    end
  }
}
