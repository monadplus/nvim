local ok, neogit = pcall(require, "neogit")
if not ok then
  return
end

-- https://github.com/TimUntersberger/neogit#configuration
neogit.setup {
  disable_hint = true,
  disable_context_highlighting = false,
  disable_commit_confirmation = true,
  disable_insert_on_commit = false,
  use_magit_keybindings = true,
  integrations = {
    -- Uses 'sindrets/diffview.nvim' for diffs
    telescope = true,
    diffview = true,
  },
}

vim.keymap.set('n', '<Leader>gg', neogit.open, { silent = true, noremap = true, desc = "Status" })
vim.keymap.set('n', '<Leader>gc', function() neogit.open { "commit" } end,
  { silent = true, noremap = true, desc = "Commit" })
vim.keymap.set('n', '<Leader>gv', '<cmd>DiffviewOpen<cr>', { silent = true, noremap = true, desc = "Diffview" })
vim.keymap.set('n', '<Leader>gh', '<cmd>DiffviewFileHistory %<cr>', { silent = true, noremap = true, desc = "File history" })
vim.keymap.set('n', '<Leader>gl', '<cmd>DiffviewFileHistory<cr>', { silent = true, noremap = true, desc = "File Log" })

vim.api.nvim_set_hl(0, 'NeogitDiffAdd', { bg = "#004909" }) -- other groups
vim.api.nvim_set_hl(0, 'NeogitDiffAddHighlight', { bg = "#004909" }) -- current group
vim.api.nvim_set_hl(0, 'NeogitDiffDelete', { bg = "#680001" })
vim.api.nvim_set_hl(0, 'NeogitDiffDeleteHighlight', { bg = "#680001" })
