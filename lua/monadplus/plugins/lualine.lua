local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end

------------------------
-- filetype

local filename = require('lualine.components.filename'):extend()
local highlight = require 'lualine.highlight'
local colors = require 'dracula'.colors()
local default_status_colors = {
  saved = colors.white,
  modified = colors.red,
  readonly = colors.yellow,
}

function filename:init(options)
  options.path = 1
  options.symbols = {
    modified = '',
    readonly = '[RO]',
    unnamed = '[No Name]',
    newfile = '[New]',
  }
  filename.super.init(self, options)
  self.status_colors = {
    saved = highlight.create_component_highlight_group(
      { fg = default_status_colors.saved }, 'filename_status_saved', self.options),
    modified = highlight.create_component_highlight_group(
      { fg = default_status_colors.modified }, 'filename_status_modified', self.options),
    readonly = highlight.create_component_highlight_group(
      { fg = default_status_colors.readonly }, 'filename_status_readonly', self.options),
  }
  if self.options.color == nil then self.options.color = '' end
end

function filename:update_status()
  local data = filename.super.update_status(self)
  if vim.bo.readonly then
    data = highlight.component_format_highlight(self.status_colors.readonly) .. data
  else
    data = highlight.component_format_highlight(vim.bo.modified
      and self.status_colors.modified
      or self.status_colors.saved) .. data
  end
  return data
end

------------------------
-- diff

-- Re-use gitsigns.nvim git info to avoid computing it twice
-- FIX: wrong info; doesn't match 'diff'
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local diff = {
  'diff',
  source = diff_source
}

------------------------
-- window

local function window()
  return vim.api.nvim_win_get_number(0)
end

------------------------

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'dracula-nvim',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  -- +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { filename },
    lualine_x = {
      function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return space ~= 0 and "TW:"..space or ""
      end,
      'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    -- Windows not focus
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {
    'nvim-tree',
    -- 'nvim-dap-ui',
  }
}
