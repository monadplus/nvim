return {
  -- LaTeX
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end
  },

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
    'folke/trouble.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'folke/todo-comments.nvim',
    },
    keys = {
      {
        "<leader>xd",
        "<cmd>Trouble diagnostics toggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Diagnostics",
      },
      {
        "<leader>xb",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Diagnostics buffer",
      },
      {
        "<leader>xc",
        "<cmd>Trouble toggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Close",
      },
      {
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false pinned=true win.relative=win win.position=right<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Symbols",
      },
      {
        "<leader>xr",
        "<cmd>Trouble lsp_references toggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "LSP references",
      },
      {
        "<leader>xi",
        "<cmd>Trouble lsp_implementations toggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "LSP implementations",
      },
      {
        "<leader>xq",
        "<cmd>Trouble quickfix toggle<cr>",
        mode = { "n" },
        silent = true,
        noremap = true,
        desc = "Quickfix",
      },
      {
        "<leader>xl",
        "<cmd>Trouble loclist toggle<cr>",
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
      focus = true,
      win = {
        position = "bottom",
      },
      keys = {
        o = "jump",
        ["<cr>"] = "jump_close",
      },
      modes = {
        lsp_base = {
          params = {
            include_declaration = true,
          },
        },
      },
    },
  },

  {
    'kosayoda/nvim-lightbulb',
    enabled = false, -- Disabled: performance cost > usefulness
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
    'neovim/nvim-lspconfig',
    dependencies = {
      'folke/neodev.nvim',
      'nvim-telescope/telescope.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
          bind = true
        },
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
      },
      {
        'saecki/crates.nvim',
        tag = 'stable',
      },
    },
    config = function()
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { silent = true, noremap = true, desc = "Previous diagnostic" })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { silent = true, noremap = true, desc = "Next diagnostic" })
      vim.keymap.set('n', '<leader>me', vim.diagnostic.open_float,
        { silent = true, noremap = true, desc = "Show diagnostic" })

      local function on_list(options)
        vim.fn.setqflist({}, ' ', options)
        vim.api.nvim_command('cfirst 1')
      end

      local lsp_on_attach = function(client, bufnr)
        require "lsp_signature".on_attach({ bind = true }, bufnr)

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
          vim.keymap.set('n', 'gr', "<cmd>Trouble lsp_references toggle<cr>",
            { noremap = true, silent = true, buffer = bufnr, desc = "References" })
          vim.keymap.set('n', 'gi', "<cmd>Trouble lsp_implementations toggle<cr>",
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

      -- https://github.com/LuaLS/lua-language-server
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

      lsp_custom_settings.rust_analyzer = {
        ['rust-analyzer'] = {
          imports = {
            granularity = {
              group = "crate",
            },
            prefix = "crate",
          },
          checkOnSave = {
            enable = true, -- Disable for performance boost
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

      require('crates').setup {
        lsp = {
          enabled = true,
          on_attach = function(client, bufnr)
            lsp_on_attach(client, bufnr)
          end,
          actions = true,
          completion = false,
          hover = false,
        },
        completion = {
          cmp = {
            enabled = true,
          }
        }
      }

      -- https://github.com/bash-lsp/bash-language-server
      lsp_custom_settings.bashls = {}

      -- Nix (nil)
      lsp_custom_settings.nil_ls = {
        ['nil'] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      }

      -- https://github.com/redhat-developer/yaml-language-server
      lsp_custom_settings.yamlls = {} -- schema validation must be configured here

      lsp_custom_settings.clangd = {}

      -- C/C++ (ccls)
      -- More at https://github.com/MaskRay/ccls/wiki/Project-Setup
      -- lsp_custom_settings.ccls = {}

      -- -- C/C++ (ccls)
      -- -- https://clangd.llvm.org/installation#compile_commandsjson
      -- lsp_custom_settings.clangd = {
      --   ['clangd'] = {
      --     cmd = {
      --       "clangd",
      --       "--clang-tidy",
      --       "-j=16",
      --       "--malloc-trim",
      --       "--no-cuda-version-check",
      --     },
      --     filetypes = { "c", "cpp", "cu" },
      --   }
      -- }

      -- Python (pyright)
      lsp_custom_settings.pyright = {}

      -- Ziglang
      lsp_custom_settings.zls = {}

      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      for lsp, settings in pairs(lsp_custom_settings) do
        vim.lsp.enable(lsp)
        vim.lsp.config(lsp, {
          capabilities = lsp_capabilities,
          flags = lsp_flags,
          on_attach = lsp_on_attach,
          settings = settings,
        })
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
  }
}
