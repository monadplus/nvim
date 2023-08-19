local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local telescope_config = require("telescope.config")
local actions = require("telescope.actions")

local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")
table.insert(vimgrep_arguments, "--trim")

-- Disable highlighting for certain files
local previewers = require('telescope.previewers')
local _bad = { '.*%.csv', '.*%.js' }
local bad_files = function(filepath)
  for _, v in ipairs(_bad) do
    if filepath:match(v) then
      return false
    end
  end

  return true
end

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}
  if opts.use_ft_detect == nil then opts.use_ft_detect = true end
  opts.use_ft_detect = opts.use_ft_detect == false and false or bad_files(filepath)
  previewers.buffer_previewer_maker(filepath, bufnr, opts)
end

-- :help telescope.setup()
telescope.setup {
  defaults = {
    layout_strategy = 'flex',
    layout_config = {
      bottom_pane = {
        height = 25,
        preview_cutoff = 200,
        prompt_position = "bottom"
      },
      center = {
        height = 0.4,
        preview_cutoff = 40,
        prompt_position = "top",
        width = 0.5
      },
      cursor = {
        height = 0.9,
        preview_cutoff = 40,
        width = 0.8
      },
      horizontal = {
        height = 0.95,
        preview_cutoff = 200,
        prompt_position = "bottom",
        width = 0.95,
      },
      vertical = {
        height = 0.95,
        preview_cutoff = 40,
        prompt_position = "bottom",
        width = 0.95
      }
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-h>"] = "which_key",
        ["<C-p>"] = actions.cycle_history_next,
        ["<C-n>"] = actions.cycle_history_prev,
      },
    },
    prompt_prefix = "   ",
    path_display = { "absolute" },
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },
    buffer_previewer_maker = new_maker,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
    buffers = {
      layout_strategy = 'bottom_pane',
    },
    marks = {
      layout_strategy = 'bottom_pane',
    },
    colorscheme = {
      theme = 'dropdown',
    },
    command_history = {
      layout_strategy = 'bottom_pane',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
}

-- Extensions
-- TODO: conditionally execute with `pcall`
telescope.load_extension('fzf')
telescope.load_extension('smart_history')
telescope.load_extension('hoogle')

-- Keymaps
local builtins = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtins.find_files, { silent = true, noremap = true, desc = "Files" })
vim.keymap.set('n', '<leader>/', builtins.live_grep, { silent = true, noremap = true, desc = "Grep" })
vim.keymap.set('n', '<leader>*', builtins.grep_string, { silent = true, noremap = true, desc = "Grep word" })
vim.keymap.set('n', '<leader>,', builtins.buffers, { silent = true, noremap = true, desc = "Buffers" })
vim.keymap.set('n', '<leader>fk', builtins.keymaps, { silent = true, noremap = true, desc = "Keymaps" })
vim.keymap.set('n', '<leader>fh', builtins.help_tags, { silent = true, noremap = true, desc = "Help" })
vim.keymap.set('n', '<leader>fc', builtins.command_history, { silent = true, noremap = true, desc = "Commands history" })
vim.keymap.set('n', '<leader>fC', builtins.colorscheme, { silent = true, noremap = true, desc = "Colorschemes" })
vim.keymap.set('n', '<leader>fr', builtins.oldfiles, { silent = true, noremap = true, desc = "Recent" })
vim.keymap.set('n', '<leader>fm', builtins.marks, { silent = true, noremap = true, desc = "marks" })

local ok0 = pcall(require, "notify")
if ok0 then
  telescope.load_extension('notify')
  vim.keymap.set('n', '<leader>fn', telescope.extensions.notify.notify,
    { silent = true, noremap = true, desc = "Notifications" })
end


local ok1 = pcall(require, "todo-comments")
if ok1 then
  vim.keymap.set('n', '<leader>ft', "<cmd>TodoTelescope<cr>", { silent = true, noremap = true, desc = "TODOs" })
end

local ok2 = pcall(require, "lazygit")
if ok2 then
  telescope.load_extension('lazygit')
  vim.keymap.set('n', '<leader>fs', telescope.extensions.lazygit.lazygit,
    { silent = true, noremap = true, desc = "Submodule" })
end

local manix_loaded, telescope_manix = pcall(require, "telescope-manix")
if manix_loaded then
  telescope.load_extension('manix')
  vim.keymap.set('n', '<leader>fn', telescope_manix.search,
    { silent = true, noremap = true, desc = "Nix (manix)" })
  vim.keymap.set('n', '<leader>fN', function()
      telescope_manix.search {
        manix_args = {}, -- for example: `{'--source', 'nixpkgs_doc', '--source', 'nixpkgs_comments'}`
        cword = true
      }
    end,
    { silent = true, noremap = true, desc = "Nix (manix)" })
end

local ok3 = pcall(require, "harpoon")
if ok3 then
  telescope.load_extension('harpoon')
  vim.keymap.set('n', '<leader>ff', telescope.extensions.harpoon.marks,
    { silent = true, noremap = true, desc = "Harpoon" })
end

vim.keymap.set('n', '<leader>mh', telescope.extensions.hoogle.hoogle,
  { silent = true, noremap = true, desc = "Hoogle" })
