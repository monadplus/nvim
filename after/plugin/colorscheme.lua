local ok, dracula = pcall(require, "dracula")
if not ok then
  return
end

dracula.setup {
  transparent_bg = true,
}
vim.cmd [[colorscheme dracula]]

-- Cursor
vim.opt.guicursor = 'n-v-c:block-Cursor,i:ver25-iCursor,a:blinkon1'
vim.cmd [[highlight Cursor guifg=NONE guibg=#BFBFBF]] -- cursor background
