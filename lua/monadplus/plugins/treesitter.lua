local ok = pcall(require, "nvim-treesitter")
if not ok then
  return
end

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
    "nix",
    "org",
    "rust",
    "sql",
    "yaml",
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
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "rust" },

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
