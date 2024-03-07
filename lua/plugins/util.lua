return {
  'nvim-lua/plenary.nvim', -- Better std

  -- Show keybindings after button press
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")

      -- :h which-key.txt
      wk.setup {
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
        operators = {},
        key_labels = {
          -- override the label used to display some keys.
          ["<leader>"] = "SPC",
          ["<localleader>"] = "SPC",
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = '<c-d>', -- binding to scroll down inside the popup
          scroll_up = '<c-u>',   -- binding to scroll up inside the popup
        },
        window = {
          border = "double",        -- none, single, double, shadow
          position = "bottom",      -- bottom, top
          margin = { 0, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
          padding = { 1, 3, 1, 3 }, -- extra window padding [top, right, bottom, left]
          winblend = 0              -- [0, 100]
        },
        layout = {
          height = { min = 4, max = 25 },                                             -- min and max height of the columns
          width = { min = 20, max = 50 },                                             -- min and max width of the columns
          spacing = 10,                                                               -- spacing between columns
          align = "left",                                                             -- align columns left, center or right
        },
        ignore_missing = false,                                                       -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false,                                                            -- show help message on the command line when the popup is visible
        triggers = "auto",                                                            -- automatically setup triggers
        triggers_blacklist = {
          i = { "j", "k" },
          v = { "j", "k" },
        },
        disable = {
          buftypes = {},
          filetypes = { "TelescopePrompt" },
        },
      }

      wk.register({
        ["<leader>"] = {
          -- You can rename mappings here
          -- e.g. f = { name = "+file", ['n'] = "foo"}
          b = { name = "+buffer" },
          c = { name = "+code" },
          d = { name = "+diffview" },
          f = { name = "+file" },
          g = { name = "+git" },
          h = { name = "+gitsigns" },
          m = { name = "+lsp" },
          o = { name = "+open" },
          r = { name = "+repl" },
          s = { name = "+search" },
          t = { name = "+toggle" },
          x = { name = "+trouble" },
        }
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

  -- Preview markdown on browser
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = {
        "markdown" }
    end,
    ft = { "markdown" },
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

}
