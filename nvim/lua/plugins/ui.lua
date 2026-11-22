return {

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-storm")

      -- define custom colors for gitsigns
      vim.cmd("highlight! GitSignsAdd           guibg=NONE guifg=#92BE65")
      vim.cmd("highlight! GitSignsAddNr         guibg=NONE guifg=#92BE65")
      vim.cmd("highlight! GitSignsChange        guibg=NONE guifg=#7AA2F7")
      vim.cmd("highlight! GitSignsChangeNr      guibg=NONE guifg=#7AA2F7")
      vim.cmd("highlight! GitSignsDelete        guibg=NONE guifg=#D74B4B")
      vim.cmd("highlight! GitSignsDeleteNr      guibg=NONE guifg=#D74B4B")

      -- float border color
      vim.cmd("highlight! FloatBorder      guibg=NONE guifg=#7aa2f7")
    end,
  },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      attach_to_untracked = true,
      current_line_blame_opts = { virt_text_pos = "right_align" },
      preview_config = { border = "rounded" },
    },
  },

  -- colorizer
  {
    "catgoose/nvim-colorizer.lua",
    lazy = true,
    event = "BufReadPre",
    opts = { filetypes = { "css", "tmux", "javascript", "html" } },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local project = require("modules.project")

      local function get_root()
        return project.name()
      end

      local function get_location()
        return project.root() and "" or os.getenv("PWD")
      end
      require("lualine").setup({
        options = {
          icons_enabled = true,
          component_separators = { left = " ", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          disabled_filetypes = {
            statusline = { "NeogitStatus", "NeogitCommitView", "NeogitPopup" },
            winbar = { "NeogitStatus", "NeogitCommitView", "NeogitPopup" },
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { get_root, separator = "" },
            { "branch", icon = "" },
            { "diff", icon = "" },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "✘ ", warn = " ", info = "» ", hint = "⚑ " },
            },
          },
          lualine_c = { get_location, "filename" },
          lualine_x = { "filetype" },
          lualine_y = { "encoding" },
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
        extensions = { "lazy", "quickfix" },
      })
    end,
  },
}
