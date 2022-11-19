local ok, wk = pcall(require, "which-key")
if not ok then
  return
end

-- :h which-key.txt
wk.setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 10,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  operators = {},
  key_labels = {
    -- override the label used to display some keys.
    ["<leader>"] = "SPC",
    ["<localleader>"] = "SPC",
    ["<space>"] = "SPC",
    ["<cr>"] = "RET",
    ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = "double", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 0, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 1, 3, 1, 3 }, -- extra window padding [top, right, bottom, left]
    winblend = 0 -- [0, 100]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 10, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

wk.register({
  ["<leader>"] = {
    -- You can rename mappings here
    -- e.g. f = { name = "+file", ['n'] = "foo"}
    b = { name = "+buffer" },
    c = { name = "+code" },
    d = { name = "+debug" },
    f = { name = "+file" },
    g = { name = "+git" },
    h = { name = "+gitsigns" },
    m = { name = "+lsp" },
    o = { name = "+open" },
    t = { name = "+toggle" },
    v = { name = "+diffview" },
    x = { name = "+trouble" },
  }
}, {})
