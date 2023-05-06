local ok, lightbulb = pcall(require, "nvim-lightbulb")
if not ok then
  return
end

lightbulb.setup {
  -- FIX: https://github.com/kosayoda/nvim-lightbulb/issues/39
  -- ignore = {"sumneko_lua", "marksman"},
  sign = {
    enabled = true,
    priority = 8,
  },
  autocmd = {
    enabled = true,
    pattern = { "*.rs" },
    events = { "CursorHold", "CursorHoldI" }
  }
}

local icon = "󰛩"
local hl = 'LightBulbSign'
vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })

local ok, dracula = pcall(require, "dracula")
if ok then
  local colors = dracula.colors()
  vim.api.nvim_set_hl(0, hl, { fg = colors.bright_blue })
end
