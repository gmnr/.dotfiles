-- Completion config
local M = {}

function M.config()
  local cmp = require('cmp')

  -- disable auto completion for text heavy types
  cmp.setup.filetype({'markdown', 'gitcommit', 'text', 'norg'}, {
    completion = {
      autocomplete = false
    }
  })

  -- create custom source for nvim-cmp
  cmp.register_source('hledger_completion', {
    complete = function(self, params, callback)
      local items = {}
      for payee in io.lines('/Users/guido/.finance/.src/completion-source/payees') do
        table.insert(items, {
          label = payee,
          insertText = payee .. ' | ',
          filterText = payee,
          kind = cmp.lsp.CompletionItemKind.Class
        })
      end
      for account in io.lines('/Users/guido/.finance/.src/completion-source/accounts') do
        table.insert(items, {
          label = account,
          insertText = account .. '   ',
          filterText = account,
          kind = cmp.lsp.CompletionItemKind.Method
        })
      end
      callback({ items = items })
    end,
  })

  -- add source only for ledger file
  cmp.setup.filetype('ledger', {
    sources = cmp.config.sources({
      { name = 'hledger_completion',
      entry_filter = function(entry, ctx)
        if vim.api.nvim_get_current_line():sub(1,2) == '  ' then
          return require('cmp').lsp.CompletionItemKind.Class ~= entry:get_kind()
        else
          return require('cmp').lsp.CompletionItemKind.Method ~= entry:get_kind()
        end 
      end },
    }),
    completion = {
      autocomplete = false
    },
    matching = {
      disallow_fuzzy_matching = false,
      disallow_partial_fuzzy_matching = false
    }
  })

  -- enable snippets
  cmp.setup({
    completion = {completeopt = 'menu, menuone, noinsert'},
    snippet = {
      expand = function(args)
        vim.fn['UltiSnips#Anon'](args.body)
      end,
    },

    -- style window for completion
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },

    -- mappings for navigation
    mapping = {
      ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

      -- use C-n and C-p for triggering completion
      ['<C-n>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, { 'i', 'c' }),

      ['<C-p>'] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end, { 'i', 'c' }),

      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    },

    -- add ordinary sources
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'ultisnips' },
      { name = 'buffer' },
    })
  })

  -- for search completion pull data only from buffers
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    },
    completion = {
      autocomplete = false,
    }
  })

  -- disable autocompletion for commands
  cmp.setup.cmdline(':', {
    completion = {
      autocomplete = false,
    },
    -- pull data only from comdline and paths
    sources = cmp.config.sources({
      { name = 'path' },
      { name = 'cmdline' }
    })
  })

  -- load lspkinds icons
  local lspkind = require('lspkind')
  cmp.setup {
    formatting = {
      format = lspkind.cmp_format({with_text = true, maxwidth = 80})
    }
  }

  -- config lspgconfig
  local nvim_lsp = require('lspconfig')
  -- Use a loop to conveniently call 'setup' on multiple servers and
  local servers = {'pyright', 'tsserver', 'lua_ls', 'bashls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      root_dir = nvim_lsp.util.root_pattern('.git'),
    }
  end

  -- fix global variable vim not found
  nvim_lsp.lua_ls.setup{
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        }
      }
    }
  }

  -- apply configuration to diagnostic
  local config = {
    virtual_text = false,
    underline = true,
    severity_sort = true,
  }
  vim.diagnostic.config(config)

  local signs = { Error = '► ', Warn = '► ', Hint = '► ', Information = '► ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- add config for lsp saga
  local saga = require('lspsaga').setup ({
    border_style = 'single',
    saga_winblend = 0,
    move_in_saga = { prev = '<C-p>',next = '<C-n>'},
    diagnostic_header = { ' ', ' ', ' ', 'ﴞ ' },
    -- show_diagnostic_source = true,
    -- diagnostic_source_bracket = {},
    max_preview_lines = 10,
    code_action_icon = '',
    code_action_num_shortcut = true,
    code_action_lightbulb = {
      enable = true,
      sign = true,
      enable_in_insert = true,
      sign_priority = 20,
      virtual_text = true,
    },
    finder_icons = {
      def = '  ',
      ref = '諭 ',
      link = '  ',
    },
    finder_request_timeout = 1500,
    finder_action_keys = {
      open = 'o',
      vsplit = 's',
      split = 'i',
      tabe = 't',
      quit = 'q',
      scroll_down = '<C-f>',
      scroll_up = '<C-b>', -- quit can be a table
    },
    code_action_keys = {
      quit = 'q',
      exec = '<CR>',
    },
    rename_action_quit = 'q',
    rename_in_select = true,
    show_outline = {
      win_position = 'right',
      win_with = '',
      win_width = 30,
      auto_enter = true,
      auto_preview = true,
      virt_text = '┃',
      jump_key = 'o',
      auto_refresh = true,
    },
    server_filetype_map = {},
  })

  local npairs = require('nvim-autopairs')
  npairs.setup({
    disable_filetype = { 'ledger', 'markdown', 'text', 'norg' }
  })

  local Rule = require('nvim-autopairs.rule')

  npairs.add_rules {
    Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}' }, pair)
    end),
    Rule('( ', ' )')
    :with_pair(function() return false end)
    :with_move(function(opts)
      return opts.prev_char:match('.%)') ~= nil
    end)
    :use_key(')'),
    Rule('{ ', ' }')
    :with_pair(function() return false end)
    :with_move(function(opts)
      return opts.prev_char:match('.%}') ~= nil
    end)
    :use_key('}'),
    Rule('[ ', ' ]')
    :with_pair(function() return false end)
    :with_move(function(opts)
      return opts.prev_char:match('.%]') ~= nil
    end)
    :use_key(']')
  }
end

return M
