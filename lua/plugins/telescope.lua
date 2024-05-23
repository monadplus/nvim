return {
  'MrcJkb/telescope-manix',

  'luc-tielen/telescope_hoogle',

  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make' -- dependencies: gcc, make
  },

  {
    'nvim-telescope/telescope-smart-history.nvim',
    dependencies = { 'kkharji/sqlite.lua' }
  },

  {
    'dhruvmanila/browser-bookmarks.nvim',
    tag = 'v3.1.0',
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
    }
  },

  -- TODO: hello
  -- FIX: hello
  -- HACK: hello
  -- WARN: hello
  -- WARNING: hello
  -- PERF: hello
  -- NOTE: hello
  -- TEST: hello
  {
    'folke/todo-comments.nvim',
    dependencies = "nvim-lua/plenary.nvim",
    lazy = false,
    keys = {
      {
        "]t",
        function() require("todo-comments").jump_next() end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Next todo comment",
      },
      {
        "[t",
        function() require("todo-comments").jump_prev() end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Previous todo comment",
      },
    },
    opts = {
      signs = false,
      sign_priority = 8,
      keywords = {
        -- You can disable signs individually
        FIX  = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      gui_style = {
        fg = "NONE",
        bg = "BOLD",
      },
      merge_keywords = true,
      highlight = {
        before = "",                     -- "fg" or "bg" or empty
        keyword = "wide",                -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
        after = "",                      -- "fg" or "bg" or empty
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,            -- uses treesitter to match keywords in comments only
        max_line_len = 400,              -- ignore lines longer than this
        exclude = {},                    -- list of file types to exclude highlighting
      },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
        warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
        info = { "DiagnosticInfo", "#2563EB" },
        hint = { "DiagnosticHint", "#10B981" },
        default = { "Identifier", "#7C3AED" },
        test = { "Identifier", "#FF00FF" }
      },
      search = {
        command = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        },
        -- regex that will be used to match keywords.
        -- don't replace the (KEYWORDS) placeholder
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'MrcJkb/telescope-manix',
      'luc-tielen/telescope_hoogle',
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-telescope/telescope-smart-history.nvim',
      'dhruvmanila/browser-bookmarks.nvim',
      'folke/todo-comments.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function(_, _)
      local telescope = require('telescope')
      local telescope_config = require("telescope.config")
      local actions = require("telescope.actions")

      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
      table.insert(vimgrep_arguments, "--hidden")
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!.git/*")
      table.insert(vimgrep_arguments, "--trim")
      table.insert(vimgrep_arguments, "--sort")
      table.insert(vimgrep_arguments, "path")

      -- Disable highlighting for certain files
      local previewers = require('telescope.previewers')
      local _bad = { '.*%.csv', '.*%.js' }
      local bad_files = function(filepath)
        for _, v in ipairs(_bad) do
          if filepath:match(v) then
            return false
          end
        end

        return true
      end

      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}
        if opts.use_ft_detect == nil then opts.use_ft_detect = true end
        opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      end

      -- Setup
      telescope.setup {
        defaults = {
          layout_strategy = 'flex',
          layout_config = {
            bottom_pane = {
              height = 25,
              preview_cutoff = 200,
              prompt_position = "bottom"
            },
            center = {
              height = 0.4,
              preview_cutoff = 40,
              prompt_position = "top",
              width = 0.5
            },
            cursor = {
              height = 0.9,
              preview_cutoff = 40,
              width = 0.8
            },
            horizontal = {
              height = 0.95,
              preview_cutoff = 200,
              prompt_position = "bottom",
              width = 0.95,
            },
            vertical = {
              height = 0.95,
              preview_cutoff = 40,
              prompt_position = "bottom",
              width = 0.95
            }
          },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-h>"] = "which_key",
              ["<C-p>"] = actions.cycle_history_next,
              ["<C-n>"] = actions.cycle_history_prev,
            },
          },
          prompt_prefix = "   ",
          path_display = { "absolute" },
          -- `hidden = true` is not supported in text grep commands.
          vimgrep_arguments = vimgrep_arguments,
          history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 100,
          },
          buffer_previewer_maker = new_maker,
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*", "--sort", "path" },
            layout_strategy = 'bottom_pane',
          },
          buffers = {
            layout_strategy = 'bottom_pane',
          },
          marks = {
            layout_strategy = 'bottom_pane',
          },
          colorscheme = {
            theme = 'dropdown',
          },
          command_history = {
            layout_strategy = 'bottom_pane',
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          bookmarks = {
            selected_browser = 'firefox',
            profile_name = 'default-release',
            url_open_command = 'xdg-open',
          },
        },
      }

      -- Extensions
      telescope.load_extension('fzf')
      telescope.load_extension('smart_history')
      telescope.load_extension('hoogle')

      telescope.load_extension('bookmarks')
      vim.keymap.set('n', '<leader>fb', '<cmd>Telescope bookmarks<cr>', { desc = 'Browser bookmarks' })

      -- Keymaps
      local builtins = require('telescope.builtin')
      vim.keymap.set('n', '<leader><leader>', builtins.find_files, { silent = true, noremap = true, desc = "Files" })
      vim.keymap.set('n', '<leader>/', builtins.live_grep, { silent = true, noremap = true, desc = "Grep" })
      vim.keymap.set('n', '<leader>*', builtins.grep_string, { silent = true, noremap = true, desc = "Grep word" })
      vim.keymap.set('n', '<leader>,', builtins.buffers, { silent = true, noremap = true, desc = "Buffers" })
      vim.keymap.set('n', '<leader>fk', builtins.keymaps, { silent = true, noremap = true, desc = "Keymaps" })
      vim.keymap.set('n', '<leader>fh', builtins.help_tags, { silent = true, noremap = true, desc = "Help" })
      vim.keymap.set('n', '<leader>fc', builtins.command_history,
        { silent = true, noremap = true, desc = "Commands history" })
      vim.keymap.set('n', '<leader>fC', builtins.colorscheme, { silent = true, noremap = true, desc = "Colorschemes" })
      vim.keymap.set('n', '<leader>fr', builtins.oldfiles, { silent = true, noremap = true, desc = "Recent" })
      vim.keymap.set('n', '<leader>fm', builtins.marks, { silent = true, noremap = true, desc = "marks" })

      -- folke/todo-comments.nvim
      vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<cr>", { silent = true, noremap = true, desc = "TODOs" })

      -- FIXME: doesn't load
      local telescope_manix = require('telescope-manix')
      telescope.load_extension('manix')
      vim.keymap.set('n', '<leader>fn', telescope_manix.search,
        { silent = true, noremap = true, desc = "Nix (manix)" })
      vim.keymap.set('n', '<leader>fN', function()
          telescope_manix.search {
            manix_args = {}, -- for example: `{'--source', 'nixpkgs_doc', '--source', 'nixpkgs_comments'}`
            cword = true
          }
        end,
        { silent = true, noremap = true, desc = "Nix (manix)" }
      )

      vim.keymap.set('n', '<leader>mh', telescope.extensions.hoogle.hoogle,
        { silent = true, noremap = true, desc = "Hoogle" })
    end
  },
}
