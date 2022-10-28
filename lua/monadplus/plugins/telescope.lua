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

-- :help telescope.setup()
telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-h>"] = "which_key",
      },
    },
    prompt_prefix = "   ",
    path_display = { "absolute" },
    -- `hidden = true` is not supported in text grep commands.
    vimgrep_arguments = vimgrep_arguments,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
}

-- Extensions
-- TODO: conditionally execute with `pcall`
telescope.load_extension('fzf')

-- Keymaps
local builtins = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>', builtins.find_files, { silent = true, noremap = true, desc = "Files" })
vim.keymap.set('n', '<leader>/', builtins.live_grep, { silent = true, noremap = true, desc = "Grep" })
vim.keymap.set('n', '<leader>*', builtins.grep_string, { silent = true, noremap = true, desc = "Grep word" })
vim.keymap.set('n', '<leader>,', builtins.buffers, { silent = true, noremap = true, desc = "Buffers" })
vim.keymap.set('n', '<leader>fk', builtins.keymaps, { silent = true, noremap = true, desc = "Keymaps" })
vim.keymap.set('n', '<leader>fh', builtins.help_tags, { silent = true, noremap = true, desc = "Help" })
vim.keymap.set('n', '<leader>fc', builtins.commands, { silent = true, noremap = true, desc = "Commands" })
vim.keymap.set('n', '<leader>fC', builtins.colorscheme, { silent = true, noremap = true, desc = "Colorschemes" })
vim.keymap.set('n', '<leader>fr', builtins.oldfiles, { silent = true, noremap = true, desc = "Recent" })

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
