local ok, ufo = pcall(require, "ufo")
if not ok then
  return
end

ufo.setup {
  -- NOTE: Using LSP for now
  -- provider_selector = function(bufnr, filetype, buftype)
  --     return {'treesitter', 'indent'}
  -- end
  preview = {
    win_config = {
      border = { '', '─', '', '', '', '─', '', '' },
      winhighlight = 'Normal:Folded',
      winblend = 0
    },
    mappings = {
      scrollU = '<C-u>',
      scrollD = '<C-d>'
    }
  },
}

vim.keymap.set('n', 'zR', ufo.openAllFolds, { silent = true, noremap = true, desc = "Open all" })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { silent = true, noremap = true, desc = "Close all" })
vim.keymap.set('n', 'zp', function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { silent = true, noremap = true, desc = "Peek" })
