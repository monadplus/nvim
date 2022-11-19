local ok, dap = pcall(require, "dap")
if not ok then
  return
end

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
  },
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

local ok, dapui = pcall(require, "dapui")
if not ok then
  return
end

dapui.setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.35 },
        { id = "stacks", size = 0.30 },
        { id = "breakpoints", size = 0.2 },
        { id = "watches", size = 0.15 },
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.2,
      position = "bottom",
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set('n', '<Leader>dd', dapui.toggle, { silent = true, noremap = true, desc = "Toggle UI" })
vim.keymap.set('n', '<Leader>de', dapui.eval, { silent = true, noremap = true, desc = "Eval expression" })
vim.keymap.set('n', '<Leader>db', dap.toggle_breakpoint, { silent = true, noremap = true, desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>dR', dap.run_last, { silent = true, noremap = true, desc = "Rerun" })
vim.keymap.set('n', '<Leader>dr', dap.continue, { silent = true, noremap = true, desc = "Run/Continue" })
