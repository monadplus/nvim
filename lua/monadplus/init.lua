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
