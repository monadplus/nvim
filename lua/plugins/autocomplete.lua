return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-buffer',  -- buffer words
      'hrsh7th/cmp-path',    -- ':e'
      'hrsh7th/cmp-cmdline', -- '/' and ':'
      {
        'L3MON4D3/LuaSnip',
        version = "v2.*",
        build = "make install_jsregexp"
      },
      'saadparwaiz1/cmp_luasnip',
      {
        'windwp/nvim-autopairs',
        config = true,
      },
    },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      cmp.setup {
        snippet = {
          expand = function(args)
            -- Snippet engine LuaSnip
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            elseif cmp.visible() then
              cmp.abort()
            else
              fallback()
            end
          end),
          ['<CR>'] = cmp.mapping.confirm {
            -- Bug: https://github.com/hrsh7th/nvim-cmp/issues/611
            behavior = cmp.ConfirmBehavior.Insert, -- Replace
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),

        -- vim.keymap.set({"i", "s"}, "<C-E>", function()
        -- 	if ls.choice_active() then
        -- 		ls.change_choice(1)
        -- 	end
        -- end, {silent = true})

        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'orgmode' },
          { name = 'crates' },
        }, {
          { name = 'buffer' },
        })
      }

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      require("luasnip.loaders.from_vscode")
          .lazy_load({ paths = { './snippets' } })
    end
  }
}
