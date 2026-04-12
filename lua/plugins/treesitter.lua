return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    dependencies = {
      {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons'
        },
        opts = {
          enabled = false,
          completions = {
            lsp = { enabled = true },
          }
        },
      },
      {
        'nvim-treesitter/nvim-treesitter-context',
        keys = {
          {
            "<leader>tc",
            "<cmd>TSContext toggle<cr>",
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
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').install {
        "bash",
        "c",
        "html",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "nix",
        "rust",
        "sql",
        "yaml",
        "zig"
      }
    end
  },
}
