local ok = pcall(require, "nvim-treesitter")
if not ok then
  return
end

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
