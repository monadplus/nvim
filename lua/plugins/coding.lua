return {

  -- lsp progress
  {
    'j-hui/fidget.nvim',
    lazy = false,
    opts = {
      notification = {
        window = {
          winblend = 0,
        },
      },
    },
  },
  {
    'mrcjkb/haskell-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    version = '^3',
    ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
  },

  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/todo-comments.nvim',
    },
    keys = {
      {
        "<leader>xx",
        "<cmd>TroubleToggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "All",
      },
      {
        "<leader>xc",
        "<cmd>TroubleClose<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Close",
      },
      {
        "<leader>xd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Diagnostics",
      },
      {
        "<leader>xr",
        "<cmd>TroubleToggle lsp_references<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "References",
      },
      {
        "<leader>xq",
        "<cmd>TroubleToggle quickfix<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Quickfix",
      },
      {
        "<leader>xl",
        "<cmd>TroubleToggle loclist<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Loclist",
      },
      {
        "<leader>xt",
        "<cmd>TodoTrouble<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "TODOs",
      },
    },
    opts = {

      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 10, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      fold_open = "", -- icon used for open folds
      fold_closed = "", -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping
        previous = "k", -- previous item
        next = "j", -- next item
        jump_close = { "<cr>", "<tab>" }, -- jump to the diagnostic and close the list
        open_split = { "<c-s>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh

        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file

        open_tab = {}, -- open buffer in new tab
        toggle_mode = {}, -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = {}, -- toggle auto_preview
        hover = {}, -- opens a small popup with the full multiline message
        preview = {}, -- preview the diagnostic location
        jump = { "o" }, -- jump to the diagnostic or open / close folds
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      signs = {
        error = "",
        warning = "",
        hint = "󰍉",
        information = "",
        other = "",
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    },
  },

  {
    'kosayoda/nvim-lightbulb',
    disabled = true, -- Disabled: performance cost > usefulness
    dependencies = { 'Mofiqul/dracula.nvim' },
    config = function()
      local ok, lightbulb = pcall(require, "nvim-lightbulb")
      if not ok then
        return
      end

      lightbulb.setup {
        sign = {
          enabled = true,
          priority = 8,
        },
        autocmd = {
          enabled = true,
          pattern = { "*.rs" },
          events = { "CursorHold", "CursorHoldI" }
        }
      }

      local icon = "󰛩"
      local hl = 'LightBulbSign'
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })

      local colors = require("dracula").colors()
      vim.api.nvim_set_hl(0, hl, { fg = colors.bright_blue })
    end,
  },

  {
    'mfussenegger/nvim-lint',
    enabled = false,
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        haskell = { 'hlint', }
      }

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local lspconfig = require 'lspconfig'

      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true, noremap = true, desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true, noremap = true, desc = "Next diagnostic" })
      vim.keymap.set('n', '<leader>me', vim.diagnostic.open_float,
        { silent = true, noremap = true, desc = "Show diagnostic" })

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
          vim.keymap.set('n', 'gi', "<cmd>TroubleToggle lsp_implementations<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "Implementation" })
        else
          vim.keymap.set('n', 'gr', vim.lsp.buf.references,
            { noremap = true, silent = true, buffer = bufnr, desc = "References" })
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
            { noremap = true, silent = true, buffer = bufnr, desc = "Implementation" })
        end
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
        vim.keymap.set('n', '<leader>mL', ":LspLog<CR>",
          { noremap = true, silent = true, buffer = bufnr, desc = "LSP log" })
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
      vim.g.haskell_tools = {
        tools = {
          codeLens = {
            autoRefresh = false, -- Disable all code lens
          },
          hoogle = {
            mode = 'telescope-web', -- auto, telescope-local, telescope-web, browser
          },
          hover = {
            enable = false,
            auto_focus = false,
          },
          definition = {
            hoogle_signature_fallback = false,
          },
          tags = {
            enable = vim.fn.executable('fast-tags') == 1,
            package_events = { 'BufWritePost' },
          },
        },
        hls = {
          on_attach = function(client, bufnr, ht)
            lsp_on_attach(client, bufnr)

            vim.keymap.set('n', '<space>ma', vim.lsp.codelens.run,
              { noremap = true, silent = true, desc = "Run code lens" })
            vim.keymap.set('n', '<space>mH', ht.hoogle.hoogle_signature,
              { noremap = true, silent = true, desc = "Hoogle under cursor" })
            vim.keymap.set('n', '<leader>mc', ht.project.open_package_cabal,
              { noremap = true, silent = true, desc = "Open .cabal" })
            vim.keymap.set('n', '<leader>mC', ht.project.open_package_yaml,
              { noremap = true, silent = true, desc = "Open stack.yaml" })
            vim.keymap.set('n', '<leader>mt', function()
              ht.repl.toggle(vim.api.nvim_buf_get_name(0))
            end, { noremap = true, silent = true, desc = "Repl: buffer" })
            vim.keymap.set('n', '<leader>mT', ht.repl.toggle,
              { noremap = true, silent = true, desc = "Repl: project" })
            vim.keymap.set('n', '<leader>mq', ht.repl.quit,
              { noremap = true, silent = true, desc = "Repl: quit" })
            vim.keymap.set('n', '<leader>mi', ht.repl.cword_info,
              { noremap = true, silent = true, desc = "Repl: info (cword)" })
            vim.keymap.set('n', '<leader>ml', function()
              ht.repl.load_file(vim.api.nvim_buf_get_name(0))
            end, { noremap = true, silent = true, desc = "Load" })
          end,

          default_settings = {
            haskell = {
              formattingProvider = 'ormolu',
              cabalFormattingProvider = 'cabalfmt',
              maxCompletions = 40,
              -- typecheck the entire project on initial load.
              checkProject = true,
              checkParents = 'checkOnSave',
              plugin = {
                hlint = { -- hlint
                  codeActionsOn = true,
                  diagnosticsOn = true,
                },
                pragmas = { -- autocomplete pragmas
                  codeActionsOn = true,
                  completionOn = true,
                },
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
                  globalOn = true,
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

      require('telescope').load_extension('ht')

      -- Markdown (marksman)
      lsp_custom_settings.marksman = {}

      lsp_custom_settings.rust_analyzer = {
        ['rust-analyzer'] = {
          imports = {
            granularity = {
              group = "crate",
            },
            prefix = "crate",
          },
          checkOnSave = {
            enable = true,
          },
          diagnostics = {
            experimental = {
              enable = true
            },
          },
          procMacro = {
            enable = true
          },
          cargo = {
            features = "all"
          },
        }
      }

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

      -- Python (pyright)
      lsp_custom_settings.pyright = {}

      -- Ziglang
      lsp_custom_settings.zls = {}

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
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#change-diagnostic-symbols-in-the-sign-column-gutter
      local signs = { Error = "", Warn = "", Hint = "󰍉", Info = "" }
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
    end
  },

  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    opts = {
      panel = {
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
        enabled = true,
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
    },
  }
}
