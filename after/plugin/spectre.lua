local ok, spectre = pcall(require, "spectre")
if not ok then
  return
end

spectre.setup({})

vim.keymap.set('n', '<Leader>S', spectre.toggle, { silent = true, noremap = false, desc = "Toggle Spectre" })
vim.keymap.set('n', '<Leader>sw', function()
  spectre.open_visual({ select_word = true })
end, { silent = true, noremap = false, desc = "Search current word" })
vim.keymap.set('v', '<Leader>sw', spectre.open_visual, { silent = true, noremap = false, desc = "Search current word" })

vim.keymap.set('n', '<Leader>sp', function()
  spectre.open_file_search({ select_word = true })
end, { silent = true, noremap = false, desc = "Search on current file" })
