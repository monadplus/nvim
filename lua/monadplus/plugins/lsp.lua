local ok = pcall(require, "lspconfig")
if not ok then
  return
end

----------------------------------------------------------
-- Keybindings

vim.keymap.set('n', '<leader>me', vim.diagnostic.open_float, { silent = true, noremap = true, desc = "Show diagnostic" })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true, noremap = true, desc = "Next diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true, noremap = true, desc = "Previous diagnostic" })

local function on_list(options)
  vim.fn.setqflist({}, ' ', options)
  vim.api.nvim_command('cfirst 1')
end

local lsp_on_attach = function(client, bufnr)
  -- NOTE: Setting this makes "nvim-cmp" stop working.
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gd', function()
    vim.lsp.buf.definition {
      reuse_win = true,
      on_list = on_list
    }
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Definition" })
  if pcall(require, "trouble") then
    vim.keymap.set('n', 'gD', "<cmd>TroubleToggle lsp_references<cr>",
      { noremap = true, silent = true, buffer = bufnr, desc = "References" })
  else
    vim.keymap.set('n', 'gD', vim.lsp.buf.references,
      { noremap = true, silent = true, buffer = bufnr, desc = "References" })
  end
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
    { noremap = true, silent = true, buffer = bufnr, desc = "Implementation" })
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr, desc = "Hover" })
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
    { noremap = true, silent = true, buffer = bufnr, desc = "Help" })
  vim.keymap.set('n', '<leader>mr', vim.lsp.buf.rename,
    { noremap = true, silent = true, buffer = bufnr, desc = "Rename" })
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
    { noremap = true, silent = true, buffer = bufnr, desc = "Code action" })
  vim.keymap.set('n', '<leader>mf', function() vim.lsp.buf.format { async = true } end,
    { noremap = true, silent = true, buffer = bufnr, desc = "Format" })
  vim.keymap.set('n', '<leader>mR', ":LspRestart<CR>",
    { noremap = true, silent = true, buffer = bufnr, desc = "Restart LSP" })
  vim.keymap.set('n', '<leader>ml', ":LspLog<CR>", { noremap = true, silent = true, buffer = bufnr, desc = "LSP log" })
end

----------------------------------------------------------
-- Languages configuration

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Add your custom configurations here.
local lsp_custom_settings = {}

-- Must be called before sumneko_lua
require("neodev").setup {}

-- Lua (sumneko/lua-language-server)
lsp_custom_settings.sumneko_lua = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
    completion = {
      callSnippet = "Replace"
    }
  },
}

-- Haskell (hls)
lsp_custom_settings.hls = {
  haskell = {
    formattingProvider = "ormolu"
  }
}

-- Markdown (marksman)
lsp_custom_settings.marksman = {}

-- Rust (rust-analyzer)
local rt = require("rust-tools")

-- Looks for rust-analyzer in the path.
-- Do a softlink to `$ rustup which rust-analyzer` in `~/.cargo/bin/`
rt.setup({
  server = {
    on_attach = function(client, bufnr)
      lsp_on_attach(client, bufnr)
      vim.keymap.set('n', '<space>mc', rt.open_cargo_toml.open_cargo_toml,
        { noremap = true, silent = true, desc = "Open Cargo.toml" })
    end
  },
})

-- Bash (bash-language-server)
lsp_custom_settings.bashls = {}

-- Nix (rnix)
lsp_custom_settings.rnix = {}

-- Nix (rnix)
lsp_custom_settings.rnix = {}

-- Yaml (yaml-language-server)
lsp_custom_settings.yamlls = {} -- schema validation must be configured here

-- C/C++ (ccls)
lsp_custom_settings.ccls = {} -- schema validation must be configured here
--More at https://github.com/MaskRay/ccls/wiki/Project-Setup

-- php
lsp_custom_settings.phpactor = {}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-ufo
lsp_capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

local lspconfig = require('lspconfig')
for lsp, settings in pairs(lsp_custom_settings) do
  lspconfig[lsp].setup {
    capabilities = lsp_capabilities,
    flags = lsp_flags,
    on_attach = lsp_on_attach,
    settings = settings,
  }
end

----------------------------------------------------------
-- UI

-- :help vim.diagnostic.config
vim.diagnostic.config({
  virtual_text = {
    source = 'if_many',
    prefix = '■',
    severity = { min = vim.diagnostic.severity.WARN }
  },
  signs = {
    severity = { max = vim.diagnostic.severity.INFO }
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Rounded floating windows (global setting)
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'rounded'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- -- Show diagnostic on hover
-- -- Depends on vim.opt.updatetime
-- vim.api.nvim_create_autocmd("CursorHold", {
--   buffer = bufnr,
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = 'rounded',
--       source = nil, -- always, if_many
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end
-- })
