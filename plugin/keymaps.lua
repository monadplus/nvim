-- https://github.com/tjdevries/config_manager/blob/1b8ab10ddc06217cd532376e52d74678c3a0e805/xdg_config/nvim/autoload/tj.vim#L144
local function save_and_exec()
  vim.cmd [[
    :silent! write
    :luafile %
  ]]
end

vim.keymap.set('n', '<leader>cx', save_and_exec, { silent = true, noremap = true, desc = "Exec Lua" })

vim.keymap.set('n', '<leader>ts', function()
  vim.o.spell = not (vim.o.spell)
end, { silent = true, noremap = true, desc = "Spell" })

vim.keymap.set('n', '<leader>bt', trim_trailing_whitespaces, { silent = true, noremap = true, desc = "Remove trailing ws" })

vim.keymap.set('n', '<leader>`', "<cmd>b#<cr>", { silent = true, noremap = true, desc = "Previous buffer" })

local loaded, _ = pcall(require, "bufdelete")
if loaded then
  vim.keymap.set('n', '<leader>bd', "<cmd>:Bdelete<cr>", { silent = true, noremap = true, desc = "Delete buffer" })
end
vim.keymap.set('n', '<leader>bD', "<cmd>bd!<cr>", { silent = true, noremap = true, desc = "Delete (force) buffer" })
vim.keymap.set('n', '<leader>bc', "<cmd>%bd<cr><cmd>Dashboard<cr>", { silent = true, noremap = true, desc = "Clear all buffer" })
vim.keymap.set('n', '<leader>bw', "<cmd>w<cr>", { silent = true, noremap = true, desc = "Write" })
vim.keymap.set('n', '<leader>bW', "<cmd>wa<cr>", { silent = true, noremap = true, desc = "Write (all)" })
vim.keymap.set('n', '<leader>bq', "<cmd>wq<cr>", { silent = true, noremap = true, desc = "Write & quit" })
vim.keymap.set('n', '<leader>bQ', "<cmd>qa<cr>", { silent = true, noremap = true, desc = "Quit (all)" })
