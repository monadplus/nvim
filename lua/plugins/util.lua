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

  -- FIXME: archived repo, deprecate
  -- Delete buffers efficiently
  'famiu/bufdelete.nvim',
}
