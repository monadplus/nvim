-- :help visual-multi

-- https://github.com/mg979/vim-visual-multi/wiki/Mappings
vim.g.VM_mouse_mappings = 0
vim.g.default_mappings = 1
vim.g.VM_leader = '\\'

vim.g.VM_maps = {
  ["Find Under"] = "<C-d>",
  ["Find Subword Under"] = "<C-d>",
  ["Add Cursor Down"] = "<C-Down>",
  ["Add Cursor Up"] = "<C-Up>",
}

vim.g.VM_Extend_hl = "VM_Extend_hl" -- visual-mode
vim.g.VM_Cursor_hl = "VM_Cursor_hl" -- normal-mode
vim.g.VM_Mono_hl = "VM_Mono_hl"
vim.g.VM_Insert_hl = "VM_Insert_hl"

local ok, dracula = pcall(require, "dracula")
if ok then
  local colors = dracula.colors()
  vim.api.nvim_set_hl(0, 'VM_Extend_hl', { bg = colors.purple })
  vim.api.nvim_set_hl(0, 'VM_Cursor_hl', { bg = colors.bright_blue })
  vim.api.nvim_set_hl(0, 'VM_Mono_hl', { bg = colors.purple })
  vim.api.nvim_set_hl(0, 'VM_Insert_hl', { bg = colors.pink })
end
