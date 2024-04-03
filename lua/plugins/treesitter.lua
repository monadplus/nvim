return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter-textobjects' },
      {
        'nvim-treesitter/nvim-treesitter-context',
        keys = {
          {
            "<leader>tc",
            "<cmd>TSContextToggle<cr>",
            mode = { "n" },
            silent = true,
            noremap = true,
            desc = "Treesitter context",
          },
        },
        opts = {
          enable = true,
          max_lines = 0,
          trim_scope = 'outer',
          min_window_height = 0,
          patterns = {
            default = {
              'class',
              'function',
              'method',
              'for',
              'while',
              'if',
              'switch',
              'case',
            },
            tex = {
              'chapter',
              'section',
              'subsection',
              'subsubsection',
            },
            rust = {
              'impl_item',
              'struct',
              'enum',
              'anonymous_function',
              "loop_expression",
            },
            markdown = {
              'section',
            },
            json = {
              'pair',
            },
            yaml = {
              'block_mapping_pair',
            },
          },
          exact_patterns = {},
          zindex = 20,
          mode = 'cursor',
          separator = nil,
        },
      }
    },
    build = function()
      require('nvim-treesitter.install').update({ with_sync = true })
    end,
    config = function()
      local disable_on_large_files = {
        'javascript',
        'json',
        'yaml',
      }

      require 'nvim-treesitter.configs'.setup {

        ensure_installed = {
          "agda",
          "bash",
          "c",
          "haskell",
          "json",
          "jsonc", -- neoconf depends on
          "lua",
          "markdown",
          "markdown_inline",
          "nix",
          "org",
          "rust",
          "sql",
          "yaml",
          "zig",
        },

        -- Install parsers synchronously
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        -- ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          -- `false` will disable the whole extension
          enable = true,
          disable = function(lang, buf)
            if disable_on_large_files[lang] ~= nil then
              local max_filesize = 10 * 1024 -- 10 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end
          end,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = { "org" },
        },

        indent = {
          enabled = true
        },

        -- Not working as expected
        incremental_selection = {
          enable = false,
          keymaps = {
            -- set to `false` to disable one of the mappings
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
      }

      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
              ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },

          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
            },
          },
        },

      }

      local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
    end
  },
}
