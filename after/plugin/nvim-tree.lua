local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- :help nvim-tree
nvim_tree.setup({
  open_on_setup = false,
  open_on_setup_file = false,
  sort_by = "name",
  diagnostics = {
    enable = false, -- Cluttered
  },
  view = {
    adaptive_size = true,
    centralize_selection = false,
    mappings = {
      list = {
        { key = "<C-s>", action = "split" },
        { key = "<C-v>", action = "vsplit" },
        { key = "y", action = "copy_name" },
        { key = "Y", action = "copy_absolute_path" },
        { key = "gy", action = "copy_path" },
      },
    },
  },
  renderer = {
    add_trailing = true,
    group_empty = true,
    highlight_git = false, -- color depending on git status
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set('', '<c-f>', ':NvimTreeToggle<cr>', { silent = true, noremap = true, desc = "Toggle Tree" })
vim.keymap.set('', '<c-s>', ':NvimTreeFindFile<cr>', { silent = true, noremap = true, desc = "Find Tree" })
