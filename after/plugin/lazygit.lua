local ok, lazygit = pcall(require, "lazygit")
if not ok then
  return
end

vim.keymap.set('n', '<Leader>gg', lazygit.lazygit, { silent = true, noremap = true, desc = "Status" })
vim.keymap.set('n', '<Leader>gc', lazygit.lazygitconfig, { silent = true, noremap = true, desc = "Configuration" })
vim.keymap.set('n', '<Leader>gh', lazygit.lazygitfiltercurrentfile, { silent = true, noremap = true, desc = "History" })
vim.keymap.set('n', '<Leader>gl', lazygit.lazygitfilter, { silent = true, noremap = true, desc = "Log" })
