local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

trouble.setup {
  position = "bottom", -- position of the list can be: bottom, top, left, right
  height = 10, -- height of the trouble list when position is top or bottom
  width = 50, -- width of the list when position is left or right
  icons = true, -- use devicons for filenames
  mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  fold_open = "", -- icon used for open folds
  fold_closed = "", -- icon used for closed folds
  group = true, -- group results by file
  padding = true, -- add an extra new line on top of the list
  action_keys = { -- key mappings for actions in the trouble list
    -- map to {} to remove a mapping
    previous = "k", -- previous item
    next = "j", -- next item
    jump_close = { "<cr>", "<tab>" }, -- jump to the diagnostic and close the list
    open_split = { "<c-s>" }, -- open buffer in new split
    open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
    close = "q", -- close the list
    cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
    refresh = "r", -- manually refresh

    close_folds = { "zM", "zm" }, -- close all folds
    open_folds = { "zR", "zr" }, -- open all folds
    toggle_fold = { "zA", "za" }, -- toggle fold of current file

    open_tab = {}, -- open buffer in new tab
    toggle_mode = {}, -- toggle between "workspace" and "document" diagnostics mode
    toggle_preview = {}, -- toggle auto_preview
    hover = {}, -- opens a small popup with the full multiline message
    preview = {}, -- preview the diagnostic location
    jump = { "o" }, -- jump to the diagnostic or open / close folds
  },
  indent_lines = true, -- add an indent guide below the fold icons
  auto_open = false, -- automatically open the list when you have diagnostics
  auto_close = false, -- automatically close the list when you have no diagnostics
  auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
  auto_fold = false, -- automatically fold a file trouble list at creation
  auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
  signs = {
    error = "",
    warning = "",
    hint = "󰍉",
    information = "",
    other = "",
  },
  use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

vim.keymap.set('n', '<leader>xx', "<cmd>TroubleToggle<cr>", { silent = true, noremap = true, desc = "All" })
vim.keymap.set('n', '<leader>xd', "<cmd>TroubleToggle document_diagnostics<cr>",
  { silent = true, noremap = true, desc = "Diagnostics" })
vim.keymap.set('n', '<leader>xr', "<cmd>TroubleToggle lsp_references<cr>",
  { silent = true, noremap = true, desc = "References" })
vim.keymap.set('n', '<leader>xq', "<cmd>TroubleToggle quickfix<cr>",
  { silent = true, noremap = true, desc = "Quickfix" })
vim.keymap.set('n', '<leader>xl', "<cmd>TroubleToggle loclist<cr>",
  { silent = true, noremap = true, desc = "Loclist" })
vim.keymap.set('n', '<leader>xt', "<cmd>TodoTrouble<cr>", { silent = true, noremap = true, desc = "TODOs" })
vim.keymap.set('n', '<leader>xc', "<cmd>TroubleClose<cr>", { silent = true, noremap = true, desc = "Close" })
