local ok, align = pcall(require, "align")
if not ok then
  return
end

vim.keymap.set('x', 'aa', function() align.align_to_char(1, true) end,
  { silent = true, noremap = true, desc = "Align (1 char)" })
vim.keymap.set('x', 'as', function() align.align_to_char(2, true, true) end,
  { silent = true, noremap = true, desc = "Align (2 chars)" })
vim.keymap.set('x', 'aw', function() align.align_to_string(false, true, true) end,
  { silent = true, noremap = true, desc = "Align (word)" })
vim.keymap.set('x', 'ar', function() align.align_to_string(true, true, true) end,
  { silent = true, noremap = true, desc = "Align (pattern)" })
