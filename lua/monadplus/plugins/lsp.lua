local ok, neoconf = pcall(require, "neoconf")
if ok then
  neoconf.setup({
    -- <PROJECT_ROOT>/neoconf.json
    local_settings = ".neoconf.json",
    -- ~/.config/nvim/neoconf.json
    global_settings = "neoconf.json",
    -- import existing settinsg from other plugins
    import = {
      vscode = true, -- local .vscode/settings.json
      coc = true,    -- global/local coc-settings.json
      nlsp = true,   -- global/local nlsp-settings.nvim json settings
    },
    -- send new configuration to lsp clients when changing json settings
    live_reload = true,
    -- set the filetype to jsonc for settings files, so you can use comments
    -- make sure you have the jsonc treesitter parser installed!
    filetype_jsonc = true,
    plugins = {
      -- configures lsp clients with settings in the following order:
      -- - lua settings passed in lspconfig setup
      -- - global json settings
      -- - local json settings
      lspconfig = {
        enabled = true,
      },
      -- configures jsonls to get completion in .nvim.settings.json files
      jsonls = {
        enabled = true,
        -- only show completion in json settings for configured lsp servers
        configured_servers_only = true,
      },
      -- configures lua_ls to get completion of lspconfig server settings
      lua_ls = {
        -- by default, lua_ls annotations are only enabled in your neovim config directory
        enabled_for_neovim_config = true,
        -- explicitely enable adding annotations. Mostly relevant to put in your local .nvim.settings.json file
        enabled = false,
      },
    },
  })
end

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

----------------------------------------------------------
-- Keybindings

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true, noremap = true, desc = "Previous diagnostic" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true, noremap = true, desc = "Next diagnostic" })
vim.keymap.set('n', '<leader>me', vim.diagnostic.open_float, { silent = true, noremap = true, desc = "Show diagnostic" })

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
  vim.keymap.set('n', 'gD', function()
    vim.cmd(':vsplit')
    vim.lsp.buf.definition {
      reuse_win = true,
      on_list = on_list
    }
  end, { noremap = true, silent = true, buffer = bufnr, desc = "Definition (vsplit)" })
  if pcall(require, "trouble") then
    vim.keymap.set('n', 'gr', "<cmd>TroubleToggle lsp_references<cr>",
      { noremap = true, silent = true, buffer = bufnr, desc = "References" })
  else
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,
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
  vim.keymap.set('n', '<leader>mL', ":LspLog<CR>", { noremap = true, silent = true, buffer = bufnr, desc = "LSP log" })
end

----------------------------------------------------------
-- Languages configuration

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Add your custom configurations here.
local lsp_custom_settings = {}

-- Must be called before lua_ls
require("neodev").setup {}

-- https://github.com/luals/lua-language-server
lsp_custom_settings.lua_ls = {
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

-- See https://github.com/MrcJkb/haskell-tools.nvim#advanced-configuration
local ht = require('haskell-tools')
ht.setup {
  tools = {
    codeLens = {
      autoRefresh = false, -- Disable all code lens
    },
    hoogle = {
      mode = 'telescope-web', -- autor, telescope-local, telescope-web, browser
    },
    hover = {
      disable = true,
      auto_focus = false,
    },
    tags = {
      enable = vim.fn.executable('fast-tags') == 1,
      package_events = { 'BufWritePost' },
      filetypes = { 'haskell' },
    },
  },
  hls = {
    on_attach = function(client, bufnr)
      lsp_on_attach(client, bufnr)

      vim.keymap.set('n', '<space>ma', vim.lsp.codelens.run,
        { noremap = true, silent = true, desc = "Run code lens" })
      vim.keymap.set('n', '<space>mh', ht.hoogle.hoogle_signature,
        { noremap = true, silent = true, desc = "Hoogle" })
      vim.keymap.set('n', '<leader>mc', ht.project.open_project_file,
        { noremap = true, silent = true, desc = "Open *.cabal/stack.yaml" })
      vim.keymap.set('n', '<leader>mC', ht.project.open_package_cabal,
        { noremap = true, silent = true, desc = "Open *.cabal" })
      vim.keymap.set('n', '<leader>mt', function()
        ht.repl.toggle(vim.api.nvim_buf_get_name(0))
      end, { noremap = true, silent = true, desc = "Repl: buffer" })
      vim.keymap.set('n', '<leader>mT', ht.repl.toggle,
        { noremap = true, silent = true, desc = "Repl: project" })
      vim.keymap.set('n', '<leader>mq', ht.repl.quit,
        { noremap = true, silent = true, desc = "Repl: quit" })
      vim.keymap.set('n', '<leader>ml', function()
        ht.repl.load_file(vim.api.nvim_buf_get_name(0))
      end, { noremap = true, silent = true, desc = "Load" })
    end,
    settings = {
      haskell = {
        formattingProvider = 'ormolu',
        cabalFormattingProvider = 'cabalfmt',
        maxCompletions = 40,
        -- typecheck the entire project on initial load.
        checkProject = true,
        plugin = {
          class = { -- missing class methods
            codeLensOn = false,
          },
          importLens = { -- make import lists fully explicit
            codeLensOn = false,
          },
          refineImports = { -- refine imports
            codeLensOn = false,
          },
          tactics = { -- wingman
            codeLensOn = false,
          },
          moduleName = { -- fix module names
            globalOn = false,
          },
          eval = { -- evaluate code snippets
            globalOn = false,
          },
          ['ghcide-type-lenses'] = { -- show/add missing type signatures
            globalOn = false,
          },
        },
      },
    },
  },
}

local telescope_loaded, telescope = pcall(require, "telescope")
if telescope_loaded then
  telescope.load_extension('ht')
end

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

      vim.keymap.set('n', '<leader>mc', rt.open_cargo_toml.open_cargo_toml,
        { noremap = true, silent = true, desc = "Open Cargo.toml" })
      vim.keymap.set('n', '<leader>ma', rt.hover_actions.hover_actions,
        { noremap = true, silent = true, desc = "Hover code actions" })
      vim.keymap.set('n', '<leader>mm', rt.expand_macro.expand_macro,
        { noremap = true, silent = true, desc = "Expand macro" })
      vim.keymap.set('n', '<leader>mp', rt.parent_module.parent_module,
        { noremap = true, silent = true, desc = "Parent module" })
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          -- Disable to speed up rust-analyzer on long project (but say goodbye to some features..)
          enable = true,
        },
        procMacro = {
          enable = true
        },
      }
    }
  },
  tools = {
    inlay_hints = {
      auto = false,
    },
    hover_actions = {
      auto_focus = true,
    }
  }
})

-- Bash (bash-language-server)
lsp_custom_settings.bashls = {}

-- Nix (nil)
lsp_custom_settings.nil_ls = {
  ['nil'] = {
    formatting = {
      command = { "nixpkgs-fmt" },
    },
  },
}

-- Yaml (yaml-language-server)
lsp_custom_settings.yamlls = {} -- schema validation must be configured here

-- C/C++ (ccls)
lsp_custom_settings.ccls = {} -- schema validation must be configured here
--More at https://github.com/MaskRay/ccls/wiki/Project-Setup

-- php
lsp_custom_settings.intelephense = {}

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

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
