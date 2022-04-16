set completeopt=menu,menuone,noselect

lua << EOF
  local cmp = require'cmp'

  cmp.setup.filetype({'markdown', 'vimwiki', 'text'}, {
      completion = {
        autocomplete = false
      }
    })

  cmp.setup({
    mapping = {
      ['<C-k>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },

    window = {
      documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      }
    },

    experimental = {
      ghost_text = false,
      native_menu = false
    },

    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    completion = {
    autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local lspkind = require('lspkind')
  cmp.setup {
    formatting = {
      format = lspkind.cmp_format({with_text = true, maxwidth = 70})
    }
  }
EOF
