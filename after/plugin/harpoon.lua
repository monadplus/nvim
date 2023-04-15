local ok, harpoon = pcall(require, "harpoon")
if not ok then
  return
end

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

harpoon.setup {
  global_settings = {
    -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
    save_on_toggle = false,
    -- saves the harpoon file upon every change. disabling is unrecommended.
    save_on_change = true,
    -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
    enter_on_sendcmd = false,
    -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
    tmux_autoclose_windows = false,
    -- filetypes that you want to prevent from adding to the harpoon list menu.
    excluded_filetypes = { "harpoon" },
    -- set marks specific to each git branch inside git repository
    mark_branch = false,
  }
}

vim.keymap.set('n', '<leader>aa', harpoon_mark.add_file, { silent = true, noremap = true, desc = "Add file" })
vim.keymap.set('n', '<leader>af', harpoon_ui.toggle_quick_menu, { silent = true, noremap = true, desc = "List files" })
vim.keymap.set('n', '<leader>ap', harpoon_ui.nav_prev, { silent = true, noremap = true, desc = "Previous mark" })
vim.keymap.set('n', '<leader>an', harpoon_ui.nav_next, { silent = true, noremap = true, desc = "Next mark" })
