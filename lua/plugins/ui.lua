return {
  -- Smooth <C-d>, <C-u>, ...
  {
    'karb94/neoscroll.nvim',
    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { '<C-u>', '<C-d>', 'zt', 'zz', 'zb' },
      hide_cursor = true,          -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil,       -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
      performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    },
  },

  -- edit directories in a buffer
  {
    'stevearc/oil.nvim',
    tag = 'v2.6.1',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        "-",
        function()
          require('oil').open()
        end,
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Oil.nvim",
      },
    },
    opts = {
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      -- Buffer-local options to use for oil buffers
      buf_options = {
        buflisted = false,
        bufhidden = "hide",
      },
      -- Window-local options to use for oil buffers
      win_options = {
        wrap = false,
        signcolumn = "no",
        cursorcolumn = false,
        foldcolumn = "0",
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = "n",
      },
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
      default_file_explorer = true,
      -- Restore window options to previous values when leaving an oil buffer
      restore_win_options = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = false,
      -- Deleted files will be removed with the trash_command (below).
      delete_to_trash = false,
      -- Change this to customize the command used when deleting to trash
      trash_command = "trash-put",
      -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
      prompt_save_on_select_new_entry = true,
      -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
      -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
      -- Additionally, if it is a string that matches "actions.<name>",
      -- it will use the mapping at require("oil.actions").<name>
      -- Set to `false` to remove a keymap
      -- See :help oil-actions for a list of all available actions
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.close",
        ["<C-l>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["g."] = "actions.toggle_hidden",
      },
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return false
        end,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 10,
        },
      },
      -- Configuration for the actions floating preview window
      preview = {
        -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_width and max_width can be a single value or a list of mixed integer/float types.
        -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
        max_width = 0.9,
        -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
        min_width = { 40, 0.4 },
        -- optionally define an integer/float for the exact width of the preview window
        width = nil,
        -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- min_height and max_height can be a single value or a list of mixed integer/float types.
        -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
        max_height = 0.9,
        -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
        min_height = { 5, 0.1 },
        -- optionally define an integer/float for the exact height of the preview window
        height = nil,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
      -- Configuration for the floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = "rounded",
        minimized_border = "none",
        win_options = {
          winblend = 0,
        },
      },
    },
  },

  {
    'sindrets/winshift.nvim',
    keys = {
      {
        "<C-W>n",
        "<cmd>WinShift<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Shift windows",
      },
      {
        "<C-W>m",
        "<cmd>WinShift swap<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Swap windows",
      },
    },
    opts = {
      highlight_moving_win = true, -- Highlight the window being moved
      focused_hl_group = "Visual", -- The highlight group used for the moving window
      moving_win_options = {
        -- These are local options applied to the moving window while it's
        -- being moved. They are unset when you leave Win-Move mode.
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
      },
      keymaps = {
        disable_defaults = true,
        win_move_mode = {
          ["j"] = "left",
          ["k"] = "down",
          ["l"] = "up",
          ["'"] = "right",
          ["J"] = "far_left",
          ["K"] = "far_down",
          ["L"] = "far_up",
          ["\""] = "far_right",
          ["<left>"] = "left",
          ["<down>"] = "down",
          ["<up>"] = "up",
          ["<right>"] = "right",
          ["<S-left>"] = "far_left",
          ["<S-down>"] = "far_down",
          ["<S-up>"] = "far_up",
          ["<S-right>"] = "far_right",
        },
      },
      ---A function that should prompt the user to select a window.
      ---
      ---The window picker is used to select a window while swapping windows with
      ---`:WinShift swap`.
      ---@return integer? winid # Either the selected window ID, or `nil` to
      ---   indicate that the user cancelled / gave an invalid selection.
      window_picker = function()
        return require("winshift.lib").pick_window({
          -- A string of chars used as identifiers by the window picker.
          picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          filter_rules = {
            -- This table allows you to indicate to the window picker that a window
            -- should be ignored if its buffer matches any of the following criteria.
            cur_win = true, -- Filter out the current window
            floats = true,  -- Filter out floating windows
            filetype = {},  -- List of ignored file types
            buftype = {},   -- List of ignored buftypes
            bufname = {},   -- List of vim regex patterns matching ignored buffer names
          },
          ---A function used to filter the list of selectable windows.
          ---@param winids integer[] # The list of selectable window IDs.
          ---@return integer[] filtered # The filtered list of window IDs.
          filter_func = nil,
        })
      end,
    },
  },

  -- Better <C-W><C-W>
  {
    'https://gitlab.com/yorickpeterse/nvim-window.git',
    lazy = false,
    keys = {
      {
        "<C-W><C-W>",
        function()
          local count = 0
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            if vim.api.nvim_win_is_valid(win) then
              if vim.api.nvim_win_get_config(win).relative == "" then
                count = count + 1
              end
            end
          end

          if (count > 2) then
            require("nvim-window").pick()
          else
            local current = vim.api.nvim_get_current_win()
            for _, value in ipairs(vim.api.nvim_list_wins()) do
              if (value ~= current) then
                vim.api.nvim_set_current_win(value)
              end
            end
          end
        end,
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Shift windows",
      },
    },
    opts = {
      -- The characters available for hinting windows.
      chars = {
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
        'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
      },

      -- A group to use for overwriting the Normal highlight group in the floating
      -- window. This can be used to change the background color.
      normal_hl = 'Normal',

      -- The highlight group to apply to the line that contains the hint characters.
      -- This is used to make them stand out more.
      hint_hl = 'Bold',

      -- The border style to use for the floating window.
      border = 'single'
    },
  },

  -- Undo UI
  {
    'mbbill/undotree',
    lazy = false,
    keys = {
      {
        "U",
        "<cmd>UndotreeToggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Undo Tree",
      },
    },
  },

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      {
        "<C-f>",
        function() require('nvim-tree.api').tree.toggle() end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Tree-view",
      },
      {
        "<C-s>",
        function() require('nvim-tree.api').tree.toggle { find_file = true, focus = true } end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Tree-view find file",
      },
    },
    config = function()
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
        vim.keymap.set('n', '<C-k>', api.node.show_info_popup, opts('Info'))
        vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
        vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
        vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
        vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
        vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
        vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
        vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
        vim.keymap.set('n', '.', api.node.run.cmd, opts('Run Command'))
        vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
        vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
        vim.keymap.set('n', 'B', api.tree.toggle_no_buffer_filter, opts('Toggle No Buffer'))
        vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
        vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts('Toggle Git Clean'))
        vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
        vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
        vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
        vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
        vim.keymap.set('n', 'E', api.tree.expand_all, opts('Expand All'))
        vim.keymap.set('n', 'e', api.fs.rename_basename, opts('Rename: Basename'))
        vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts('Next Diagnostic'))
        vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts('Prev Diagnostic'))
        vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clean Filter'))
        vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
        vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
        vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
        vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
        vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
        vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
        vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
        vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
        vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
        vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
        vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
        vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
        vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
        vim.keymap.set('n', 's', api.node.run.system, opts('Run System'))
        vim.keymap.set('n', 'S', api.tree.search_node, opts('Search'))
        vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts('Toggle Hidden'))
        vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
        vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
        vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
        vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
        vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
      end

      require('nvim-tree').setup({
        on_attach = on_attach,
        sort_by = "name",
        diagnostics = {
          enable = false,
        },
        view = {
          adaptive_size = true,
          centralize_selection = false,
        },
        renderer = {
          add_trailing = true,
          group_empty = true,
          highlight_git = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          ignore = false,
        },
        -- disable_netrw = true,
        -- hijack_netrw = true,
      })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    tag = "v2.20.8",
    dependencies = {
      'Mofiqul/dracula.nvim',
    },
    config = function()
      vim.opt.list = false
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"

      -- :help indent_blankline.txt
      require('indent_blankline').setup {
        char = '│',
        use_treesitter = true,
        show_first_indent_level = false,
        char_highlight_list = {
          "IndentBlanklineIndent1",
        },
        space_char_highlight_list = {
          "IndentBlanklineIndent1",
        },
      }

      local colors = require('dracula').colors()
      vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = colors.visual, })
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'Mofiqul/dracula.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        icons_enabled = true,
        theme = 'dracula-nvim',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        }
      },
      -- +-------------------------------------------------+
      -- | A | B | C                             X | Y | Z |
      -- +-------------------------------------------------+
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { filename },
        lualine_x = {
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = require('dracula').colors().white },
          },
          'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
      },
      inactive_sections = {
        -- Windows not focus
        lualine_a = {},
        lualine_b = {},
        lualine_c = { filename },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {
        'nvim-tree',
      }
    },
    config = function(_, opts)
      local lualine

      ------------------------
      -- filetype

      local filename = require('lualine.components.filename'):extend()
      local highlight = require('lualine.highlight')
      local colors = require('dracula').colors()
      local default_status_colors = {
        saved = colors.white,
        modified = colors.red,
        readonly = colors.yellow,
      }

      function filename:init(options)
        options.path = 1
        options.symbols = {
          modified = '',
          readonly = '[RO]',
          unnamed = '[No Name]',
          newfile = '[New]',
        }
        filename.super.init(self, options)
        self.status_colors = {
          saved = highlight.create_component_highlight_group(
            { fg = default_status_colors.saved }, 'filename_status_saved', self.options),
          modified = highlight.create_component_highlight_group(
            { fg = default_status_colors.modified }, 'filename_status_modified', self.options),
          readonly = highlight.create_component_highlight_group(
            { fg = default_status_colors.readonly }, 'filename_status_readonly', self.options),
        }
        if self.options.color == nil then self.options.color = '' end
      end

      function filename:update_status()
        local data = filename.super.update_status(self)
        if vim.bo.readonly then
          data = highlight.component_format_highlight(self.status_colors.readonly) .. data
        else
          data = highlight.component_format_highlight(vim.bo.modified
            and self.status_colors.modified
            or self.status_colors.saved) .. data
        end
        return data
      end

      ------------------------
      -- diff

      -- Re-use gitsigns.nvim git info to avoid computing it twice
      -- FIX: wrong info; doesn't match 'diff'
      local function diff_source()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed
          }
        end
      end

      local diff = {
        'diff',
        source = diff_source
      }

      ------------------------
      -- window
      local function window()
        return vim.api.nvim_win_get_number(0)
      end

      -- Setup
      require('lualine').setup(opts)
    end
  },

  {
    'glepnir/dashboard-nvim',
    commit = 'f7d623457d6621b25a1292b24e366fae40cb79ab',
    event = 'VimEnter',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'Mofiqul/dracula.nvim',
    },
    keys = {
      {
        "<leader>bn",
        "<cmd>DashboardNewFile<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "New file",
      },
      {
        "<leader>od",
        "<cmd>Dashboard<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Dashboard",
      },
      {
        "<leader>bc",
        "<cmd>%bd<cr><cmd>Dashboard<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Clear all buffers",
      },
    },
    config = function()
      local dashboard = require('dashboard')

      dashboard.hide_statusline = false
      dashboard.hide_tabline = true
      dashboard.hide_winbar = true

      dashboard.custom_header = {
        ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
        ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
        ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
        ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
        ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
        ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
      }

      dashboard.custom_center = {
        {
          icon = '  ',
          desc = 'Find  File                              ',
          action = 'Telescope find_files',
          shortcut = 'SPC f f'
        },
        {
          icon = '  ',
          desc = 'New File                                ',
          action = 'DashboardNewFile',
          shortcut = 'SPC b n'
        },
        {
          icon = '  ',
          desc = 'Lazy                                    ',
          action = 'Lazy',
          shortcut = '       '
        },
      }

      local function get_footer()
        local default_footer = { '', 'Have fun with  ' }
        local count = require("lazy").stats().count;
        default_footer[2] = 'Loaded ' .. count .. ' plugins'
        return default_footer
      end

      dashboard.custom_footer = get_footer()

      local function get_header_pad()
        local header_height = #dashboard.custom_header
        local center_height = (#dashboard.custom_center * 2) + dashboard.center_pad

        local footer_height = 2 + dashboard.footer_pad
        if dashboard.custom_footer ~= nil then
          footer_height = #dashboard.custom_footer + dashboard.footer_pad
        end

        local dashboard_height = header_height + center_height + footer_height

        local win_height = vim.fn.winheight(0)
        local padding = (win_height - dashboard_height) / 2
        return padding
      end

      dashboard.header_pad = get_header_pad()

      -- Highligh groups
      local colors = require('dracula').colors()
      vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = colors.green })
      vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = colors.fg })
      vim.api.nvim_set_hl(0, 'DashboardShortCut', { fg = colors.purple })
      vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = colors.orange })
      for i in ipairs(dashboard.custom_center) do
        dashboard.custom_center[i].icon_hl = { fg = colors.cyan }
      end
    end
  }
}
