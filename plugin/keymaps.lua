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

vim.keymap.set('n', '<leader>bd', "<cmd>bd!<cr>", { silent = true, noremap = true, desc = "Delete buffer" })
vim.keymap.set('n', '<leader>bD', "<cmd>%bd<cr><cmd>Dashboard<cr>", { silent = true, noremap = true, desc = "Delete all buffer" })
