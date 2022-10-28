local ok, hop = pcall(require, "hop")
if not ok then
  return
end

-- :help hop.setup
hop.setup {
  keys = "asdfqwer;lkjpoiuxcv,mnhytgb",
  case_insensitive = true,
}

local directions = require('hop.hint').HintDirection

vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true, desc = "Hop char1" })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true, desc = "Hop char1 (backwards)" })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true, desc = "Hop char1+" })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true, desc = "Hop char1+ (backwards)" })

vim.keymap.set("n", "s", "<cmd>HopWord<CR>", { silent = true, noremap = false, desc = "HopWord" })
vim.keymap.set("n", "S", "<cmd>HopWordMW<CR>", { silent = true, noremap = false, desc = "HopWordMW" })
