local ok, nvim_window = pcall(require, "nvim-window")
if not ok then
  return
end

nvim_window.setup({
  -- The characters available for hinting windows.
  chars = {
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  },

  -- A group to use for overwriting the Normal highlight group in the floating
  -- window. This can be used to change the background color.
  normal_hl = 'Normal',

  -- The highlight group to apply to the line that contains the hint characters.
  -- This is used to make them stand out more.
  hint_hl = 'Bold',

  -- The border style to use for the floating window.
  border = 'single'
})

vim.keymap.set("n", "<C-W>w", function()
  -- TODO: this sometimes returns more than 2
  -- when there are only 2 windows on the screen.
  if (#vim.api.nvim_list_wins() > 2) then
    nvim_window.pick()
  else
    local current = vim.api.nvim_get_current_win()
    for _, value in ipairs(vim.api.nvim_list_wins()) do
      if (value ~= current) then
        vim.api.nvim_set_current_win(value)
      end
    end
  end
end, { silent = true, noremap = true, desc = "Move cursor to" })
