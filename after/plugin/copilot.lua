local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup({
  panel = {
    -- Using copilot_cmp instead
    enabled = false,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    -- Using copilot_cmp instead
    enabled = false,
    auto_trigger = true,
    debounce = 75,
    keymap = {
      accept = "<M-p>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 18.x
  server_opts_overrides = {},
})

local ok, copilot_cmp = pcall(require, "copilot_cmp")
if not ok then
  return
end

copilot_cmp.setup()
