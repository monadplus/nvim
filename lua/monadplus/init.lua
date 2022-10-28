-- Packer must be loaded first for a proper bootstrapping
require('monadplus.plugins')

if not packer_installed then
  return
end

local function load_plugins_configs()
  local home = os.getenv("HOME")
  assert(home, '$HOME is not declared')
  local load_lua_dir = require('scripts.load_all')
  load_lua_dir(home .. '/' .. '.config/nvim/lua/monadplus/plugins')
end

load_plugins_configs()

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd('BufWritePost', {
  desc = "Compile plugins after update",
  group = augroup('packer_user_config', { clear = true }),
  pattern = "plugins.lua",
  command = "PackerCompile",
})

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
