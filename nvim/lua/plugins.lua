-- install `lazy.nvim`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- load plugins with no config
	"haya14busa/is.vim",
	"nvim-tree/nvim-web-devicons",
	"tpope/vim-commentary",
	"tpope/vim-fugitive",
	"tpope/vim-repeat",
	"tpope/vim-speeddating",
	"tpope/vim-surround",
	"tpope/vim-unimpaired",
	"wellle/targets.vim",
	"windwp/nvim-autopairs",

	-- colorscheme
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme tokyonight-storm")
		end,
	},

	-- emmet
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
		end,
		ft = { "ledger" },
	},

	-- indent blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.g.indent_blankline_buftype_exclude = { "markdown", "text" }
		end,
	},

	-- quickrun
	{
		"thinca/vim-quickrun",
		ft = {
			"python",
			"javascript",
		},
		config = function()
			vim.cmd(
				[[let g:quickrun_config = {'*': {'hook/time/enable': 1, 'hook/time/format': '[Finished in %gs]', 'outputter/buffer/opener': '%{"bel 12new"}'}}]]
			)
		end,
	},

	-- formatter
	{
		"stevearc/conform.nvim",
		dependencies = { 
      "williamboman/mason.nvim",
      config = function()
        require('mason').setup()
      end
  },
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black" },
			},
			format_on_save = { timeout_ms = 500, lsp_fallback = true },
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		},
		init = function()
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- vim-markdown
	{
		"preservim/vim-markdown",
		config = function()
			vim.g.vim_markdown_folding_disabled = 1
			vim.g.vim_markdown_conceal = 2
			vim.g.vim_markdown_frontmatter = 1
		end,
		ft = { "markdown" },
	},

	-- completion & snippets
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			{
				"SirVer/ultisnips",
				config = function()
					vim.g.UltiSnipsExpandTrigger = "<Tab>"
					vim.g.UltiSnipsJumpForwardTrigger = "<Tab>"
					vim.g.UltiSnipsJumpBackwardTrigger = "<S-Tab>"
					vim.g.UltiSnipsSnippetDirectories = { "snppts" }
				end,
			},
			"honza/vim-snippets",
			"quangnguyen30192/cmp-nvim-ultisnips",
		},
	},

	-- telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.5,
					},
					width = 0.8,
					height = 0.8,
					preview_cutoff = 120,
				},
				sorting_strategy = "ascending",
				winblend = 0,
			},
		},
	},

	-- treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
		build = ":TSUpdate",
	},

	-- gitsigns
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
				change = {
					hl = "GitSignsChange",
					text = "│",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				changedelete = {
					hl = "GitSignsChange",
					text = "~",
					numhl = "GitSignsChangeNr",
					linehl = "GitSignsChangeLn",
				},
				delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
				topdelete = {
					hl = "GitSignsDelete",
					text = "‾",
					numhl = "GitSignsDeleteNr",
					linehl = "GitSignsDeleteLn",
				},
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = {
				interval = 1000,
				follow_files = true,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "right_align",
				delay = 1000,
				ignore_whitespace = false,
			},
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil,
			max_file_length = 40000,
			preview_config = {
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
			yadm = {
				enable = false,
			},
		},
	},

	-- lualine
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {},
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", { "diagnostics", sources = { "nvim_diagnostic" } } },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = { "filename" },
				lualine_b = {},
				lualine_c = {},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = { "fugitive" },
		},
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"onsails/lspkind-nvim",
		},
	},
}, {})

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<ESC>"] = require("telescope.actions").close, -- don't enable normal mode
				["<C-u>"] = false, -- clear prompt with C-u
				["<C-n>"] = require("telescope.actions").move_selection_next,
				["<C-e>"] = require("telescope.actions").move_selection_previous,
				["<C-k>"] = require("telescope.actions").preview_scrolling_down,
				["<C-y>"] = require("telescope.actions").preview_scrolling_up,
			},
		},
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" }, -- look into hidden dirs but not .git
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

pcall(require("telescope").load_extension, "fzf")

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"bash",
		"css",
		"html",
		"javascript",
		"ledger",
		"lua",
		"markdown",
		"python",
	},
	highlight = {
		enable = true,
		disable = { "markdown" },
	},
	indent = {
		enabled = false,
		disable = {},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
	},
	move = {
		enable = true,
		set_jumps = true, -- whether to set jumps in the jumplist
		goto_next_start = {
			["]m"] = "@function.outer",
			["]]"] = "@class.outer",
		},
		goto_next_end = {
			["]M"] = "@function.outer",
			["]["] = "@class.outer",
		},
		goto_previous_start = {
			["[m"] = "@function.outer",
			["[["] = "@class.outer",
		},
		goto_previous_end = {
			["[M"] = "@function.outer",
			["[]"] = "@class.outer",
		},
	},
	swap = {
		enable = true,
		swap_next = {
			["<leader>a"] = "@parameter.inner",
		},
		swap_previous = {
			["<leader>A"] = "@parameter.inner",
		},
	},
	sync_install = true, -- install synchronously
	ignore_install = {}, -- parsers to not install
})

-- Completion config
local cmp = require("cmp")

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

-- load lspkinds icons
local lspkind = require("lspkind")
cmp.setup({
	formatting = {
		format = lspkind.cmp_format({ with_text = true, maxwidth = 80 }),
	},
})

-- config lspgconfig
local nvim_lsp = require("lspconfig")
local servers = {
	"pyright",
	"tsserver",
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

-- apply configuration to diagnostic
local config = {
	virtual_text = false,
	underline = true,
	severity_sort = true,
}
vim.diagnostic.config(config)

local signs = { Error = "► ", Warn = "► ", Hint = "► ", Information = "► " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- config autopairs
local npairs = require("nvim-autopairs")
npairs.setup({
	disable_filetype = {
		"ledger",
		"markdown",
		"text",
		"norg",
	},
})

local Rule = require("nvim-autopairs.rule")

npairs.add_rules({
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
	Rule("( ", " )")
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match(".%)") ~= nil
		end)
		:use_key(")"),
	Rule("{ ", " }")
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match(".%}") ~= nil
		end)
		:use_key("}"),
	Rule("[ ", " ]")
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match(".%]") ~= nil
		end)
		:use_key("]"),
})
