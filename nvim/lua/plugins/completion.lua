return {

  -- completion & snippets
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
      {
        "SirVer/ultisnips",
        config = function()
          vim.g.UltiSnipsExpandTrigger = "<Tab>"
          vim.g.UltiSnipsJumpForwardTrigger = "<C-n>"
          vim.g.UltiSnipsJumpBackwardTrigger = "<C-e>"
          vim.g.UltiSnipsSnippetDirectories = { "snppts" }
        end,
      },
      "honza/vim-snippets",
      "quangnguyen30192/cmp-nvim-ultisnips",
    },
    config = function()
      -- Completion config
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      -- disable auto completion for text heavy types
      cmp.setup.filetype({
        "markdown",
        "gitcommit",
        "text",
        "norg",
      }, {
        completion = {
          autocomplete = false,
        },
      })

      -- create custom source for nvim-cmp
      cmp.register_source("hledger_completion", {
        complete = function(self, params, callback)
          local items = {}
          for payee in io.lines("/Users/guido/.finance/.src/completion-source/payees") do
            table.insert(items, {
              label = payee,
              insertText = payee .. " | ",
              filterText = payee,
              kind = cmp.lsp.CompletionItemKind.Class,
            })
          end
          for account in io.lines("/Users/guido/.finance/.src/completion-source/accounts") do
            table.insert(items, {
              label = account,
              insertText = account .. "   ",
              filterText = account,
              kind = cmp.lsp.CompletionItemKind.Method,
            })
          end
          callback({ items = items })
        end,
      })

      -- add source only for ledger file
      cmp.setup.filetype("ledger", {
        sources = cmp.config.sources({
          {
            name = "hledger_completion",
            entry_filter = function(entry, ctx)
              if vim.api.nvim_get_current_line():sub(1, 2) == "  " then
                return require("cmp").lsp.CompletionItemKind.Class ~= entry:get_kind()
              else
                return require("cmp").lsp.CompletionItemKind.Method ~= entry:get_kind()
              end
            end,
          },
        }),
        completion = {
          autocomplete = false,
        },
        matching = {
          disallow_fuzzy_matching = false,
          disallow_partial_fuzzy_matching = false,
        },
      })

      -- enable snippets
      cmp.setup({
        completion = { completeopt = "menu, menuone, noinsert" },
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },

        -- format autocompletion
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          }),
        },

        -- style window for completion
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        -- mappings for navigation
        mapping = {
          ["<C-e>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-n>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

          -- use C-n and C-p for triggering completion
          ["<C-k>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),

          ["<C-y>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              cmp.complete()
            end
          end, { "i", "c" }),

          ["<C-f>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        },

        -- add ordinary sources
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "buffer" },
        }),
      })

      -- for search completion pull data only from buffers
      cmp.setup.cmdline("/", {
        sources = {
          { name = "buffer" },
        },
        completion = {
          autocomplete = false,
        },
      })

      -- disable autocompletion for commands
      cmp.setup.cmdline(":", {
        completion = {
          autocomplete = false,
        },
        -- pull data only from comdline and paths
        sources = cmp.config.sources({
          { name = "path" },
          { name = "cmdline" },
        }),
      })
    end,
  },

  -- lsp
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- config lspgconfig
      local nvim_lsp = require("lspconfig")
      local servers = {
        "pyright",
        "lua_ls",
        "bashls",
      }
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup({
          root_dir = nvim_lsp.util.root_pattern(".git"),
        })
      end

      -- fix global variable vim not found
      nvim_lsp.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },
}
