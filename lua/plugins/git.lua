return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>gg",
        function() require('neogit').open() end,
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Status",
      },
      {
        "<leader>gc",
        function() require('neogit').open { "commit" } end,
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Commit",
      },
      {
        "<leader>gd",
        "<cmd>DiffviewOpen<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Diffview",
      },
      {
        "<leader>gh",
        "<cmd>DiffviewFileHistory %<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "File history",
      },
      {
        "<leader>gl",
        "<cmd>DiffviewFileHistory<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "File Log",
      },
    },
    opts = {
      disable_hint = true,
      disable_commit_confirmation = true,
      disable_insert_on_commit = false,
      use_magit_keybindings = true,
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
    init = function()
      vim.api.nvim_set_hl(0, 'NeogitDiffAdd', { bg = "#004909" })          -- other groups
      vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { bg = "#004909" }) -- current group
      vim.api.nvim_set_hl(0, 'NeogitDiffDelete', { bg = "#680001" })
      vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight', { bg = "#680001" })
    end,
  },

  {
    'sindrets/diffview.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    init = function()
      local colors = require("dracula").colors()
      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0c4a1c", bold = false })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#073c52", bold = false })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#A33636", bold = false })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#041e29", bold = true })
    end,
    keys = {
      {
        "<leader>dd",
        "<cmd>DiffviewOpen<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Open",
      },
      {
        "<leader>dc",
        "<cmd>DiffviewClose<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Close",
      },
      {
        "<leader>dh",
        "<cmd>DiffviewFileHistory %<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "File history",
      },
      {
        "<leader>d",
        "<cmd>:'<,'>DiffviewFileHistory<cr>",
        mode = { 'x', 'v' },
        silent = true,
        noremap = true,
        desc = "Line(s) history",
      },
    },
    config = function()
      local actions = require("diffview.actions")

      require('diffview').setup({
        diff_binaries = false,
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        git_cmd = { "git" },
        use_icons = true,
        watch_index = true,
        icons = {
          folder_closed = "",
          folder_open = "",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          -- Configure the layout and behavior of different types of views.
          -- Available layouts:
          --  'diff1_plain'
          --    |'diff2_horizontal'
          --    |'diff2_vertical'
          --    |'diff3_horizontal'
          --    |'diff3_vertical'
          --    |'diff3_mixed'
          --    |'diff4_mixed'
          -- For more info, see ':h diffview-config-view.x.layout'.
          default = {
            -- Config for changed files, and staged files in diff views.
            layout = "diff2_horizontal",
          },
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff4_mixed",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          },
          file_history = {
            -- Config for changed files in file history views.
            layout = "diff2_horizontal",
          },
        },
        file_panel = {
          listing_style = "tree",            -- One of 'list' or 'tree'
          tree_options = {                   -- Only applies when listing_style is 'tree'
            flatten_dirs = true,             -- Flatten dirs that only contain one single dir
            folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
          },
          win_config = {                     -- See ':h diffview-config-win_config'
            position = "left",
            width = 35,
            win_opts = {}
          },
        },
        file_history_panel = {
          git = {
            log_options = { -- See ':h diffview-config-log_options'
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = { -- See ':h diffview-config-win_config'
            position = "bottom",
            height = 16,
            win_opts = {}
          },
        },
        commit_log_panel = {
          win_config = { -- See ':h diffview-config-win_config'
            win_opts = {},
          }
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {},                 -- See ':h diffview-config-hooks'
        keymaps = {
          disable_defaults = false, -- Disable the default keymaps
          view = {
            -- The `view` bindings are active in the diff buffers
            ["<tab>"]      = actions.select_next_entry,         -- Open the diff for the next file
            ["<s-tab>"]    = actions.select_prev_entry,         -- Open the diff for the previous file
            ["gf"]         = actions.goto_file,                 -- Open the file in a new split in the previous tabpage
            ["<C-w><C-f>"] = actions.goto_file_split,           -- Open the file in a new split
            ["<C-w>gf"]    = actions.goto_file_tab,             -- Open the file in a new tabpage
            ["e"]          = actions.focus_files,               -- Bring focus to the file panel
            ["b"]          = actions.toggle_files,              -- Toggle the file panel.
            ["g<C-x>"]     = actions.cycle_layout,              -- Cycle through available layouts.
            ["[x"]         = actions.prev_conflict,             -- In the merge_tool: jump to the previous conflict
            ["]x"]         = actions.next_conflict,             -- In the merge_tool: jump to the next conflict
            ["co"]         = actions.conflict_choose("ours"),   -- Choose the OURS version of a conflict
            ["ct"]         = actions.conflict_choose("theirs"), -- Choose the THEIRS version of a conflict
            ["cb"]         = actions.conflict_choose("base"),   -- Choose the BASE version of a conflict
            ["ca"]         = actions.conflict_choose("all"),    -- Choose all the versions of a conflict
            ["dx"]         = actions.conflict_choose("none"),   -- Delete the conflict region
          },
          diff1 = { --[[ Mappings in single window diff layouts ]] },
          diff2 = { --[[ Mappings in 2-way diff layouts ]] },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { "n", "x" }, "2do", actions.diffget("ours") },   -- Obtain the diff hunk from the OURS version of the file
            { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "x" }, "1do", actions.diffget("base") },   -- Obtain the diff hunk from the BASE version of the file
            { { "n", "x" }, "2do", actions.diffget("ours") },   -- Obtain the diff hunk from the OURS version of the file
            { { "n", "x" }, "3do", actions.diffget("theirs") }, -- Obtain the diff hunk from the THEIRS version of the file
          },
          file_panel = {
            ["j"]             = actions.next_entry,
            ["<down>"]        = false,
            ["k"]             = actions.prev_entry,
            ["<up>"]          = false,
            ["<cr>"]          = actions.select_entry, -- Open the diff for the selected entry.
            ["o"]             = actions.select_entry,
            ["<2-LeftMouse>"] = false,
            ["-"]             = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
            ["S"]             = actions.stage_all,          -- Stage all entries.
            ["U"]             = actions.unstage_all,        -- Unstage all entries.
            ["X"]             = actions.restore_entry,      -- Restore entry to the state on the left side.
            ["L"]             = actions.open_commit_log,    -- Open the commit log panel.
            ["<c-u>"]         = actions.scroll_view(-0.25), -- Scroll the view up
            ["<c-d>"]         = actions.scroll_view(0.25),  -- Scroll the view down
            ["<tab>"]         = actions.select_next_entry,
            ["<s-tab>"]       = actions.select_prev_entry,
            ["gf"]            = actions.goto_file,
            ["<C-w><C-f>"]    = actions.goto_file_split,
            ["<C-w>gf"]       = actions.goto_file_tab,
            ["i"]             = actions.listing_style,       -- Toggle between 'list' and 'tree' views
            ["f"]             = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
            ["R"]             = actions.refresh_files,       -- Update stats and entries in the file list.
            ["e"]             = actions.focus_files,
            ["b"]             = actions.toggle_files,
            ["g<C-x>"]        = actions.cycle_layout,
            ["[x"]            = actions.prev_conflict,
            ["]x"]            = actions.next_conflict,
          },
          file_history_panel = {
            ["g!"]            = actions.options,          -- Open the option panel
            ["<C-A-d>"]       = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
            ["y"]             = actions.copy_hash,        -- Copy the commit hash of the entry under the cursor
            ["L"]             = actions.open_commit_log,
            ["zR"]            = actions.open_all_folds,
            ["zM"]            = actions.close_all_folds,
            ["j"]             = actions.next_entry,
            ["<down>"]        = actions.next_entry,
            ["k"]             = actions.prev_entry,
            ["<up>"]          = actions.prev_entry,
            ["<cr>"]          = actions.select_entry,
            ["o"]             = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<c-b>"]         = actions.scroll_view(-0.25),
            ["<c-f>"]         = actions.scroll_view(0.25),
            ["<tab>"]         = actions.select_next_entry,
            ["<s-tab>"]       = actions.select_prev_entry,
            ["gf"]            = actions.goto_file,
            ["<C-w><C-f>"]    = actions.goto_file_split,
            ["<C-w>gf"]       = actions.goto_file_tab,
            ["<leader>e"]     = actions.focus_files,
            ["b"]             = actions.toggle_files,
            ["g<C-x>"]        = actions.cycle_layout,
          },
          option_panel = {
            ["<tab>"] = actions.select_entry,
            ["q"]     = actions.close,
          },
        },
      })
    end,
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("gitsigns").setup {
        signs                        = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged                 = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach                    = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true, silent = true, noremap = true, desc = "Next hunk" })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true, silent = true, noremap = true, desc = "Previous hunk" })

          map({ 'n' }, '<leader>hs', gs.stage_hunk, { silent = true, noremap = true, desc = "Stage" })
          map({ 'n' }, '<leader>hr', gs.reset_hunk, { silent = true, noremap = true, desc = "Reset" })
          map({ 'v' }, '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { silent = true, noremap = true, desc = "Stage" })
          map({ 'v' }, '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
            { silent = true, noremap = true, desc = "Reset" })
          map('n', '<leader>hS', gs.stage_buffer, { silent = true, noremap = true, desc = "Stage all" })
          map('n', '<leader>hu', gs.undo_stage_hunk, { silent = true, noremap = true, desc = "Undo stage" })
          map('n', '<leader>hR', gs.reset_buffer, { silent = true, noremap = true, desc = "Reset all" })
          map('n', '<leader>hp', gs.preview_hunk, { silent = true, noremap = true, desc = "Preview" })
          map('n', '<leader>hb', function() gs.blame_line { full = true } end,
            { silent = true, noremap = true, desc = "Blame" })
          map('n', '<leader>hd', gs.diffthis, { silent = true, noremap = true, desc = "Diff" })
          map('n', '<leader>hD', function() gs.diffthis('~') end, { silent = true, noremap = true, desc = "Diff ~" })
          map('n', '<leader>tb', gs.toggle_current_line_blame, { silent = true, noremap = true, desc = "Hunk blame" })
          map('n', '<leader>td', gs.toggle_deleted, { silent = true, noremap = true, desc = "Hunk deleted" })
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true, noremap = true, desc = "Hunk" })
        end
      }
    end,
  },
}
