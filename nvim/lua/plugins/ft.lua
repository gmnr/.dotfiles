return {

  -- html/css development
  {
    "mattn/emmet-vim",
    init = function()
      -- default leader (<C-y>)
      vim.g.user_emmet_mode = "nv"
    end,
    ft = { "html", "css" },
  },

  -- ledger
  {
    "ledger/vim-ledger",
    init = function()
      vim.g.ledger_bin = "hledger"
      vim.g.ledger_decimal_sep = ","
    end,
    ft = { "ledger" },
  },

  -- snippets: <Tab> expands, <C-n>/<C-e> jump (insert-mode jumps live in blink's keymap)
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = { "honza/vim-snippets" },
    ft = { "markdown", "ledger", "python", "javascript", "html", "css", "text" },
    config = function()
      local ls = require("luasnip")
      ls.setup({
        enable_autosnippets = true,
        update_events = "TextChanged,TextChangedI", -- mirrors ($1 ... $1) follow as you type
        cut_selection_keys = "<Tab>", -- visual <Tab> saves the selection for ${VISUAL}
      })

      -- own snippets (nvim/lua/snippets/<filetype>.lua, priority 1000) win over honza/vim-snippets
      require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
      require("luasnip.loaders.from_snipmate").lazy_load({ default_priority = 1 })

      local function feed(key)
        vim.api.nvim_feedkeys(vim.keycode(key), "n", false)
      end

      -- <Tab> expands a snippet, or is a plain <Tab>
      vim.keymap.set("i", "<Tab>", function()
        if ls.expandable() then
          ls.expand()
        else
          feed("<Tab>")
        end
      end, { silent = true, desc = "Expand snippet" })

      -- <Tab> on a selected placeholder leaves select mode, as it did with UltiSnips
      vim.keymap.set("s", "<Tab>", "<Esc>", { silent = true, desc = "Leave select mode" })

      -- jumps from a selected placeholder
      for key, dir in pairs({ ["<C-n>"] = 1, ["<C-e>"] = -1 }) do
        vim.keymap.set("s", key, function()
          if ls.jumpable(dir) then
            ls.jump(dir)
          else
            feed(key)
          end
        end, { silent = true, desc = "Snippet jump" })
      end
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
