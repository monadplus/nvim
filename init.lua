--                                __
--   ___      __    ___   __  __ /\_\    ___ ___
-- /' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\
-- /\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \
-- \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
--  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
--

-- https://neovim.io/doc/user/lua.html#vim.loader
vim.loader.enable()

-- Set as early as possible.
-- Otherwise, any mapping set before doing this, will be set to the old leader.
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

-- Lazy.nvim must be loaded first for a proper bootstrapping
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugins from `~/.config/nvim/lua/plugins/*`
require("lazy").setup("plugins", {
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = false,       -- get a notification when new updates are found
    frequency = 3600,     -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
})

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- autocmd('BufWritePost', {
--   desc = "Compile plugins after update",
--   group = augroup('packer_user_config', { clear = true }),
--   pattern = "plugins.lua",
--   command = "PackerCompile",
-- })

autocmd('TextYankPost', {
  desc = "Highlight yanked text",
  group = augroup('lua_highlight', { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Substitute", -- IncSearch
      timeout = 200,
      on_macro = true
    })
  end
})

-- TODO: use lua
vim.cmd [[
augroup AutoAdjustResize
  autocmd!
  autocmd VimResized * execute "normal! \<C-w>="
augroup end
]]

-- FIXME:
-- If you place this options at plugin/options.lua it will be overwritten.
-- You can check it by `:verbose set formatoptions`.
autocmd('BufEnter', {
  desc = "Change format options",
  group = augroup('format_options', { clear = true }),
  pattern = "*",
  callback = function()
    local opt = vim.opt
    opt.formatoptions = opt.formatoptions
        - "a" -- Auto formatting is BAD.
        - "t" -- Don't auto format my code. I got linters for that.
        + "c" -- In general, I like it when comments respect textwidth
        + "q" -- Allow formatting comments w/ gq
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
        + "n" -- Indent past the formatlistpat, not underneath it.
        + "j" -- Auto-remove comments if possible.
        - "2" -- I'm not in gradeschool anymore

    -- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1160512800
    opt.foldcolumn = '0'
    opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    opt.foldlevelstart = 99
    opt.foldenable = true
  end
})
