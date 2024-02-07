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
      function Better_ledger_align()
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

      -- set specific mapping
      vim.keymap.set({ "i" }, "<CR>", "<cmd>lua Better_ledger_align()<CR><Right><CR>", { silent = true })
    end,
    ft = { "ledger" },
  },

  -- sql
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
