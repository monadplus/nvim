local ok, iblankline = pcall(require, "indent_blankline")
if not ok then
  return
end

vim.opt.list = false
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- :help indent_blankline.txt
iblankline.setup {
  char = '│',
  use_treesitter = true,
  show_first_indent_level = false,
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
  space_char_highlight_list = {
    "IndentBlanklineIndent1",
  },
}

local ok, dracula = pcall(require, "dracula")
if ok then
  local colors = dracula.colors()
  vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = colors.visual, })
end
