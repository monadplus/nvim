local ok, tree_ctx = pcall(require, "treesitter-context")
if not ok then
  return
end

tree_ctx.setup {
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
}

vim.keymap.set('n', "<leader>tc", "<cmd>TSContextToggle<cr>",
  { silent = true, noremap = true, desc = "Treesitter context" })
