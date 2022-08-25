local M = {}

function M.config()
  local cmp = require('cmp')

  -- disable autocopletion for text heavy types
  cmp.setup.filetype({'markdown', 'vimwiki', 'text'}, {
      completion = {
        autocomplete = false
      }
    })

  -- enable snippets
  cmp.setup({
    snippet = {
        expand = function(args)
          vim.fn["UltiSnips#Anon"](args.body)
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
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
  local servers = {'pyright', 'html', 'tsserver'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
      root_dir = nvim_lsp.util.root_pattern('.git'),
    }
  end

  -- apply configuration to diagnostic
  local config = {
      virtual_text = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = ''
      },
  }

  vim.diagnostic.config(config)
  local signs = { Error = '► ', Warn = '► ', Hint = '► ', Information = '► ' }
  for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
  vim.o.signcolumn = 'yes'

  -- add config for lsp saga
 	local saga = require('lspsaga')
  saga.init_lsp_saga({
		border_style = "single",
		saga_winblend = 0,
		move_in_saga = { prev = '<C-p>',next = '<C-n>'},
		diagnostic_header = { " ", " ", " ", "ﴞ " },
		show_diagnostic_source = true,
		diagnostic_source_bracket = {},
		max_preview_lines = 10,
		code_action_icon = "",
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
			open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			quit = "q",
			scroll_down = "<C-f>",
			scroll_up = "<C-b>", -- quit can be a table
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>",
		},
		rename_action_quit = "q",
		rename_in_select = true,
		definition_preview_icon = "  ",
		-- show symbols in winbar must nightly
		symbol_in_winbar = {
			in_custom = false,
			enable = false,
			separator = ' ',
			show_file = true,
			click_support = false,
		},
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
end

return M
