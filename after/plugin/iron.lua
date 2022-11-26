-- https://github.com/hkupty/iron.nvim
local iron_loaded, iron = pcall(require, "iron.core")
if not iron_loaded then
  return
end

local ht = require('haskell-tools')

iron.setup {
  config = {
    repl_definition = {
      haskell = {
        command = function(meta)
          local filename = vim.api.nvim_buf_get_name(meta.current_bufnr)
          return ht.repl.mk_repl_cmd(filename)
        end,
      },
    },
    scratch_repl = true, -- repl should be discarded or not
    repl_open_cmd = require('iron.view').bottom(30), -- there are lot of options here
  },
}

vim.keymap.set('n', '<leader>rs', "<cmd>IronRepl<cr>", { silent = true, noremap = true, desc = "Start" })
vim.keymap.set('n', '<leader>rr', "<cmd>IronRestart<cr>", { silent = true, noremap = true, desc = "Restart" })
vim.keymap.set('n', '<leader>rf', "<cmd>IronFocus<cr>", { silent = true, noremap = true, desc = "Focus" })
vim.keymap.set('n', '<leader>rh', "<cmd>IronHide<cr>", { silent = true, noremap = true, desc = "Hide" })
