-- sunjon/Shade.nvim has been disabled.
-- Doesn't work on transparent backgrounds.

local ok, shade = pcall(require, "shade")
if not ok then
  return
end

shade.setup {
  opacity_step = 1,
  overlay_opacity = 70,
  keys = {
    brightness_up   = '<C-Up>',
    brightness_down = '<C-Down>',
    -- toggle           = '<Leader>s',
  }
}
