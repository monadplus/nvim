local ok, dashboard = pcall(require, "dashboard")
if not ok then
  return
end

dashboard.hide_statusline = false
dashboard.hide_tabline = true
dashboard.hide_winbar = true

dashboard.custom_header = {
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
}

dashboard.custom_center = {
  { icon = '  ',
    desc = 'Find  File                              ',
    action = 'Telescope find_files',
    shortcut = 'SPC f f' },
  { icon = '  ',
    desc = 'File Browser                            ',
    action = 'Telescope file_browser',
    shortcut = 'SPC f e' },
  { icon = '  ',
    desc = 'New File                                ',
    action = 'DashboardNewFile',
    shortcut = 'SPC b n' },
  { icon = '  ',
    desc = 'Update Plugins                          ',
    action = 'PackerUpdate',
    shortcut = '       ' },
  { icon = '  ',
    desc = 'Exit                                    ',
    action = 'exit',
    shortcut = '       ' },
}

local function get_footer()
  local default_footer = { '', 'Have fun with  ' }
  if packer_plugins ~= nil then
    local count = #vim.tbl_keys(packer_plugins)
    default_footer[2] = 'Loaded ' .. count .. ' plugins'
  end
  return default_footer
end

dashboard.custom_footer = get_footer()

local function get_header_pad()
  local header_height = #dashboard.custom_header
  local center_height = (#dashboard.custom_center * 2) + dashboard.center_pad

  local footer_height = 2 + dashboard.footer_pad
  if dashboard.custom_footer ~= nil then
    footer_height = #dashboard.custom_footer + dashboard.footer_pad
  end

  local dashboard_height = header_height + center_height + footer_height

  local win_height = vim.fn.winheight(0)
  local padding = (win_height - dashboard_height) / 2
  return padding
end

dashboard.header_pad = get_header_pad()

-- Highligh groups
local ok, dracula = pcall(require, "dracula")
if ok then
  local colors = dracula.colors()
  vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = colors.green })
  vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = colors.fg })
  vim.api.nvim_set_hl(0, 'DashboardShortCut', { fg = colors.purple })
  vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = colors.orange })
  for i in ipairs(dashboard.custom_center) do
    dashboard.custom_center[i].icon_hl = { fg = colors.cyan }
  end
end

--[[
local home = os.getenv('HOME')
dashboard.preview_command = 'ueberzug'
dashboard.preview_file_path = home .. '/.config/nvim/static/roxy.jpg'
dashboard.preview_file_height = 22
dashboard.preview_file_width = 38
]]

vim.keymap.set('n', '<leader>bn', '<cmd>DashboardNewFile<cr>', { silent = true, noremap = true, desc = "New file" })
vim.keymap.set('n', '<leader>od', '<cmd>Dashboard<cr>', { silent = true, noremap = true, desc = "Dashboard" })
