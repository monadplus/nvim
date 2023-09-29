--                                __
--   ___      __    ___   __  __ /\_\    ___ ___
-- /' _ `\  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\
-- /\ \/\ \/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \
-- \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
--  \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
--

-- https://neovim.io/doc/user/lua.html#vim.loader
vim.loader.enable()

local ok, _ = pcall(require, 'packer')
if not ok then
  print('Call :PackerInstall and restart neovim')
  _G.packer_installed = false
else
  _G.packer_installed = true
end

-- Set as early as possible.
-- Otherwise, any mapping set before doing this, will be set to the old leader.
vim.g.mapleader = [[ ]]
vim.g.maplocalleader = [[ ]]

require 'monadplus'
