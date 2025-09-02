return {

  -- highlight
  "haya14busa/is.vim",

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
    end,
  },

  -- gitsigns
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
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
    },
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function get_root()
        -- Get the directory of the current file
        local current_file = vim.fn.expand("%:p:h")

        if vim.bo.buftype ~= "" and vim.startswith(current_file, "fugitive:///") then
          -- if is fugitive window show the repo name
          current_file = os.getenv("PWD")

          -- if is the no file special buffer
        elseif current_file == "" or vim.fn.isdirectory(current_file) == 0 then
          current_file = os.getenv("PWD")
        end

        -- Change to the directory of the current file
        local cmd = "cd " .. current_file .. " && git rev-parse --show-toplevel 2>/dev/null"
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()

        -- Check if result is empty, indicating an error (not a git repo)
        if result == "" then
          return ""
        end

        -- Get the basename of the top-level directory
        local basename_handle = io.popen("basename " .. result)
        local basename_result = basename_handle:read("*a")
        basename_handle:close()

        local repo_name = basename_result:match("^%s*(.-)%s*$") -- trim any whitespace
        return " " .. repo_name .. " "
      end

      local function location()
        local cwd = require("snacks").git.get_root(vim.fn.expand("%:p"))
        if cwd ~= nil then
          return ""
        else
          return os.getenv("PWD")
        end
      end
      require("lualine").setup({
        options = {
          icons_enabled = true,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            { get_root, separator = "", padding = { right = 0 } },
            { "branch", icon = "", padding = { left = 0 } },
            "diff",
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = "✘ ", warn = " ", info = "» ", hint = "⚑ " },
            },
          },
          lualine_c = { location, "filename" },
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
        extensions = { "lazy", "quickfix", "trouble" },
      })
    end,
  },
}
