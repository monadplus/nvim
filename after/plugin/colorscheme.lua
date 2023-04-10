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

-- TODO: remove when dracula supports neovim >=0.9
-- https://www.reddit.com/r/neovim/comments/12gvms4/this_is_why_your_higlights_look_different_in_90/
local links = {
  ['@lsp.type.namespace'] = '@namespace',
  ['@lsp.type.type'] = '@type',
  ['@lsp.type.class'] = '@type',
  ['@lsp.type.enum'] = '@type',
  ['@lsp.type.interface'] = '@type',
  ['@lsp.type.struct'] = '@structure',
  ['@lsp.type.parameter'] = '@parameter',
  ['@lsp.type.variable'] = '@variable',
  ['@lsp.type.property'] = '@property',
  ['@lsp.type.enumMember'] = '@constant',
  ['@lsp.type.function'] = '@function',
  ['@lsp.type.method'] = '@method',
  ['@lsp.type.macro'] = '@macro',
  ['@lsp.type.decorator'] = '@function',
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
