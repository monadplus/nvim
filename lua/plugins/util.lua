return {
  'nvim-lua/plenary.nvim', -- Better std

  -- Show keybindings after button press
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup {
        preset = "helix",
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 10,
          },
          presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
          },
        },
        replace = {
          key = {
            { "<Leader>",      "SPC" },
            { "<Localleader>", "SPC" },
            { "<Space>",       "SPC" },
            { "<Cr>",          "RET" },
            { "<Tab>",         "TAB" }
          }
        },
        show_help = false,
        disable = {
          bt = {},
          ft = { "TelescopePrompt" },
        },
      }

      wk.add({
        { "<leader>a", desc = "+bookmarks" },
        { "<leader>b", desc = "+buffer" },
        { "<leader>c", desc = "+code" },
        { "<leader>d", desc = "+diffview" },
        { "<leader>f", desc = "+file" },
        { "<leader>g", desc = "+git" },
        { "<leader>h", desc = "+gitsigns" },
        { "<leader>m", desc = "+lsp" },
        { "<leader>o", desc = "+open" },
        { "<leader>r", desc = "+repl" },
        { "<leader>s", desc = "+search" },
        { "<leader>t", desc = "+toggle" },
        { "<leader>x", desc = "+trouble" },
      }, {})
    end
  },

  'junegunn/vim-slash', -- :nohlsearch when cursor moves

  -- Highlight current word
  {
    'RRethy/vim-illuminate',
    config = function()
      local illuminate = require("illuminate")

      illuminate.configure({
        -- ordered by priority
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'neogit',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
      })

      vim.keymap.set('n', ']w', illuminate.goto_next_reference, { desc = "Move to next reference" })
      vim.keymap.set('n', '[w', illuminate.goto_prev_reference, { desc = "Move to previous reference" })
      -- vim.keymap.set({'o', 'x'}, 'h', illuminate.textobj_select)
    end
  },

  -- dim inactive portions of code
  {
    'folke/twilight.nvim',
    keys = {
      {
        "<leader>tt",
        function() require("spectre").toggle() end,
        "<cmd>Twilight<CR>",
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Twilight",
      },
    },
    opts = {
      dimming = {
        alpha = 0.5, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false,    -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 10,          -- amount of lines we will try to show around the current line
      treesitter = true,
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = { "gitcommit" }, -- exclude these filetypes
    },
  },

  -- distraction free mode
  {
    'folke/zen-mode.nvim',
    keys = {
      {
        "<leader>tz",
        "<cmd>ZenMode<CR>",
        mode = { 'n' },
        silent = true,
        noremap = false,
        desc = "Zen",
      },
    },
    opts = {
      plugins = {
        twilight = { enabled = true },
        gitsigns = { enabled = true },
        tmux = { enabled = true },
      },
      on_open = function(win)
        vim.fn.system([[polybar-msg cmd toggle]])
      end,
      on_close = function()
        vim.fn.system([[polybar-msg cmd toggle]])
      end

    },
  },

  -- Fold code like a pro
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    keys = {
      {
        "zR",
        function() require('ufo').openAllFolds() end,
        mode = { 'n' },
        silent = true,
        noremap = true,
        desc = "Open all",
      },
      {
        "zM",
        function() require('ufo').closeAllFolds() end,
        mode = { 'n' },
        silent = true,
        noremap = true,
        desc = "Close all",
      },
      {
        "zp",
        function()
          local ufo = require('ufo')
          local winid = ufo.peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        mode = { 'n' },
        silent = true,
        noremap = true,
        desc = "Peek",
      },
    },
    opts = {
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>'
        }
      },
      -- Use treesitter for folds (lsp doesn't work well for rust)
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }
  },

  -- Delete buffers efficiently
  'famiu/bufdelete.nvim',

  {
    'OXY2DEV/markview.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,
    opts = {
      preview = {
        icon_provider = "devicons"
      }
    },
  },

  -- Disabled
  {
    'nvim-orgmode/orgmode',
    enabled = false,
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
      { 'akinsho/org-bullets.nvim',        lazy = true, branch = 'main' },
    },
    ft = "org",
    config = function()
      local orgmode = require('orgmode')

      -- Load treesitter grammar for org
      orgmode.setup_ts_grammar()

      -- Setup orgmode
      orgmode.setup({
        org_agenda_files = { '~/Dropbox/org/*' },
        org_default_notes_file = '~/Dropbox/org/refile.org',
      })

      require('org-bullets').setup()
    end,
  },

  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true }
    },
    opts = {
      scope = "git",
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
      { "<leader>at", "<cmd>Grapple toggle<cr>",                                  desc = "Grapple toggle tag" },
      -- { "<leader>aa", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
      { "<leader>aa", "<cmd>Telescope grapple tags layout_strategy=vertical<cr>", desc = "Grapple open tags window" },
      { "]a",         "<cmd>Grapple cycle_tags next<cr>",                         desc = "Grapple cycle next tag" },
      { "[a",         "<cmd>Grapple cycle_tags prev<cr>",                         desc = "Grapple cycle previous tag" },
    },
  }

}
