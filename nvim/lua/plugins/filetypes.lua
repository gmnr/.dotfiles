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

      -- define function to align at <CR>
      function better_ledger_align()
        if string.find(vim.fn.getline("."):sub(-1), "%d") then
          local str = vim.fn.getline(".")
          local elements = {}

          for el in str:gmatch("%S+") do
            table.insert(elements, el)
          end

          local amt = elements[#elements]
          if not string.find(amt, ",") then
            vim.cmd("normal A,00")
          else
            local pos = string.find(amt, ",")
            if pos == #amt - 1 then
              vim.cmd("normal A0")
            end
          end
          vim.cmd(":LedgerAlign")
          return ""
        else
          return ""
        end
      end
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
