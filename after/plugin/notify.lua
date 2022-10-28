local ok, notify = pcall(require, "notify")
if not ok then
  return
end

notify.setup {
  background_colour = "#000000",
}

-- Change default notification function
-- Now you can call vim.notify("This is an error", "error")
vim.notify = notify

vim.keymap.set("n", "<leader>tn", ":Notifications<CR>", { silent = true, noremap = false, desc = "Notifications" })
