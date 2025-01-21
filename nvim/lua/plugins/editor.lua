return {

  "tpope/vim-fugitive",

  { "tpope/vim-repeat", event = "VeryLazy" },

  { "tpope/vim-speeddating", event = "VeryLazy" },

  { "tpope/vim-surround", event = "VeryLazy" },

  { "tpope/vim-unimpaired", event = "VeryLazy" },

  {
    "wellle/targets.vim",
    event = "VeryLazy",
    config = function()
      vim.cmd([[
      nnoremap <silent> <Leader>a :set opfunc=Append<CR>g@
      nnoremap <silent> <Leader>i :set opfunc=Insert<CR>g@
      function! Append(type, ...)
          call feedkeys("`]a", 'n')
      endfunction
      function! Insert(type, ...)
          call feedkeys("`[i", 'n')
      endfunction
      ]])
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        exclude_dirs = { "~/Documents/advent-of-code/*" },
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")

      return {
        npairs.setup({
          disable_filetype = {
            "ledger",
            "markdown",
            "text",
            "norg",
          },
        }),
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
        }),
      }
    end,
  },

  -- quickrun
  {
    "thinca/vim-quickrun",
    ft = {
      "python",
      "javascript",
      "typescript",
      "sh",
    },
    config = function()
      vim.cmd([[let g:quickrun_config = {'*': {'hook/time/enable': 1, 'hook/time/format': '[Finished in %gs]'}}]])
    end,
  },
}
