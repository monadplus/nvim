local ok, zen = pcall(require, "zen-mode")
if not ok then
  return
end

zen.setup {
  plugins = {
    twilight = { enabled = true },
    gitsigns = { enabled = true },
    tmux = { enabled = false }, -- TODO: never comes backs
  },
  on_open = function(win)
    vim.fn.system([[polybar-msg cmd toggle]])
  end,
  on_close = function()
    vim.fn.system([[polybar-msg cmd toggle]])
  end
}

vim.keymap.set('n', '<leader>tz', "<cmd>ZenMode<CR>", { silent = true, noremap = false, desc = "Zen" })
