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
      function Hledger_CR()
        local line = vim.fn.getline(".")
        if string.find(line:sub(-1), "%d") then
          local elements = {}

          for el in line:gmatch("%S+") do
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

      -- set specific mapping
      vim.keymap.set({ "i" }, "<CR>", "<cmd>lua Hledger_CR()<CR><Right><CR>", { silent = true })
    end,
    ft = { "ledger" },
  },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    config = function()
      require("markview").setup({
        modes = { "n", "i", "no", "c" },
        hybrid_modes = { "i" },
        callbacks = {
          on_enable = function(_, win)
            vim.wo[win].conceallevel = 2
            vim.wo[win].concealcursor = "nc"
          end,
        },
      })
    end,
  },
}
