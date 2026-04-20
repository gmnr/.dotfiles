return {

  -- remove highlighted words when moving cursor
  "haya14busa/is.vim",

  -- colorscheme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme tokyonight-storm")
      vim.o.cmdheight = 1
      require("vim._core.ui2").enable({
        enable = true,
        msg = {
          targets = {
            [""] = "msg",
            empty = "cmd",
            bufwrite = "msg",
            confirm = "cmd",
            emsg = "pager",
            echo = "msg",
            echomsg = "msg",
            echoerr = "pager",
            completion = "cmd",
            list_cmd = "pager",
            lua_error = "pager",
            lua_print = "msg",
            progress = "pager",
            rpc_error = "pager",
            quickfix = "msg",
            search_cmd = "cmd",
            search_count = "cmd",
            shell_cmd = "pager",
            shell_err = "pager",
            shell_out = "pager",
            shell_ret = "msg",
            undo = "msg",
            verbose = "pager",
            wildlist = "cmd",
            wmsg = "msg",
            typed_cmd = "cmd",
          },
          cmd = {
            height = 0.5,
          },
          dialog = {
            height = 0.5,
          },
          msg = {
            height = 0.3,
            timeout = 5000,
          },
          pager = {
            height = 0.5,
          },
        },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "msg",
        callback = function()
          local ui2 = require("vim._core.ui2")
          local win = ui2.wins and ui2.wins.msg
          if win and vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_set_option_value(
              "winhighlight",
              "Normal:NormalFloat,FloatBorder:FloatBorder",
              { scope = "local", win = win }
            )
          end
        end,
      })

      local ui2 = require("vim._core.ui2")
      local msgs = require("vim._core.ui2.messages")
      local orig_set_pos = msgs.set_pos
      msgs.set_pos = function(tgt)
        orig_set_pos(tgt)
        if (tgt == "msg" or tgt == nil) and vim.api.nvim_win_is_valid(ui2.wins.msg) then
          pcall(vim.api.nvim_win_set_config, ui2.wins.msg, {
            relative = "editor",
            anchor = "NE",
            row = 1,
            col = vim.o.columns - 1,
            border = "rounded",
          })
        end
      end

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

  -- colorizer
  {
    "catgoose/nvim-colorizer.lua",
    lazy = true,
    event = "BufReadPre",
    opts = {},
  },

  -- lualine
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function get_root()
        -- Get the directory of the current file
        local current_file = vim.fn.expand("%:p:h")

        if vim.bo.buftype ~= "" and vim.startswith(current_file, "Neogitstatus:///") then
          -- if is git status window show the repo name
          current_file = os.getenv("PWD")

          -- if is the no file special buffer
        elseif current_file == "" or vim.fn.isdirectory(current_file) == 0 then
          current_file = os.getenv("PWD")
        end

        current_file = current_file:gsub(" ", "\\ ")

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

        return basename_result:match("^%s*(.-)%s*$") -- trim any whitespace
      end

      local function get_location()
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
          component_separators = { left = " ", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {},
          always_divide_middle = true,
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
        extensions = { "lazy", "quickfix", "trouble" },
      })
    end,
  },
}
