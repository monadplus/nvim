-- FIXME: markdown-preview is never found
-- local ok, _ = pcall(require, "markdown-preview")
-- if not ok then
--   return
-- end

local md_group = vim.api.nvim_create_augroup('markdown_mode', { clear = true })

vim.api.nvim_create_autocmd({ 'Filetype', 'BufEnter' }, {
  desc = 'Load markdown mode',
  group = md_group,
  pattern = { '*.md', '*.markdown' },
  callback = function()
    vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>',
      { silent = true, noremap = true, desc = "Preview markdown" })
  end
})

--- TODO: errors when leaving a *.md file
-- vim.api.nvim_create_autocmd({ 'BufLeave' }, {
--   desc = 'Unload markdown mode',
--   group = md_group,
--   pattern = { '*.md', '*.markdown' },
--   callback = function()
--     vim.keymap.del('n', '<leader>mp', { buffer = true })
--   end
-- })
