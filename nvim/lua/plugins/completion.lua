return {

  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      keymap = {
        preset = "none",
        ["<C-k>"] = { "select_next", "show" },
        ["<C-y>"] = { "select_prev", "show" },
        ["<C-e>"] = { "scroll_documentation_up", "fallback" },
        ["<C-n>"] = { "scroll_documentation_down", "fallback" },
        ["<Esc>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },

      completion = {
        menu = { auto_show = false, border = "rounded", max_height = 25 },
        documentation = { window = { border = "rounded" } },
        list = { selection = { preselect = true, auto_insert = false } },
        accept = { auto_brackets = { enabled = true } }, -- replaces the autopairs hook
      },

      sources = {
        default = { "lsp" },
        per_filetype = {
          ledger = { "hledger" },
          markdown = { "buffer" },
          text = { "buffer" },
        },
        providers = {
          lsp = {
            -- don't suggest Text items when an LSP is active
            transform_items = function(_, items)
              local text = vim.lsp.protocol.CompletionItemKind.Text
              return vim.tbl_filter(function(item)
                return item.kind ~= text
              end, items)
            end,
          },
          hledger = { name = "hledger", module = "modules.blink_hledger" },
        },
      },

      cmdline = {
        keymap = {
          preset = "none",
          ["<C-k>"] = { "select_next", "show" },
          ["<C-y>"] = { "select_prev", "show" },
          ["<CR>"] = { "accept", "fallback" },
        },
        -- search completes from the buffer, `:` from commands and paths
        sources = function()
          local type = vim.fn.getcmdtype()
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          return type == ":" and { "cmdline" } or {}
        end,
      },
    },
  },
}
