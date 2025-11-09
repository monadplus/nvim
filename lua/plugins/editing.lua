return {
  {
    'kylechui/nvim-surround',
    version = "*", -- Latest stable release
    event = "VeryLazy",
    config = true,
  },

  -- Jump anywhere in the file
  {
    'smoka7/hop.nvim',
    tag = 'v2.5.1', -- latest Jan 1st 2024
    lazy = false,
    config = function()
      local hop = require('hop')
      local directions = require('hop.hint').HintDirection

      hop.setup {
        keys = "asdfghjkl'qwertyuiopzxcvbnm,.",
        case_insensitive = true,
      }

      vim.keymap.set('', 'f', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
      end, { remap = true, desc = "Hop char1" })
      vim.keymap.set('', 'F', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true, desc = "Hop char1 (backwards)" })
      vim.keymap.set('', 't', function()
        hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true, desc = "Hop char1+" })
      vim.keymap.set('', 'T', function()
        hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true, desc = "Hop char1+ (backwards)" })

      vim.keymap.set("n", "s", "<cmd>HopWord<CR>", { silent = true, noremap = false, desc = "HopWord" })
      vim.keymap.set("n", "S", "<cmd>HopWordMW<CR>", { silent = true, noremap = false, desc = "HopWordMW" })
    end
  },

  {
    'numToStr/Comment.nvim',
    opts = {},
    lazy = false,
  },

  {
    'mg979/vim-visual-multi',
    dependencies = {
      'Mofiqul/dracula.nvim',
    },
    config = function()
      vim.g.VM_mouse_mappings = 0
      vim.g.default_mappings = 1
      vim.g.VM_leader = '\\'

      vim.g.VM_maps = {
        ["Find Under"] = "<C-d>",
        ["Find Subword Under"] = "<C-d>",
        ["Add Cursor Down"] = "<C-Down>",
        ["Add Cursor Up"] = "<C-Up>",
      }

      vim.g.VM_Extend_hl = "VM_Extend_hl" -- visual-mode
      vim.g.VM_Cursor_hl = "VM_Cursor_hl" -- normal-mode
      vim.g.VM_Mono_hl = "VM_Mono_hl"
      vim.g.VM_Insert_hl = "VM_Insert_hl"

      local colors = require("dracula").colors()
      vim.api.nvim_set_hl(0, 'VM_Extend_hl', { bg = colors.purple })
      vim.api.nvim_set_hl(0, 'VM_Cursor_hl', { bg = colors.bright_blue })
      vim.api.nvim_set_hl(0, 'VM_Mono_hl', { bg = colors.purple })
      vim.api.nvim_set_hl(0, 'VM_Insert_hl', { bg = colors.pink })
    end
  },

  -- Replace word
  {
    'nvim-pack/nvim-spectre',
    config = true,
    keys = {
      {
        "<leader>S",
        function() require("spectre").toggle() end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Toggle Spectre",
      },
      {
        "<leader>ss",
        function() require("spectre").open_visual({ select_word = true }) end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Search current word",
      },
      {
        "<leader>sw",
        function() require("spectre").open_file_search({ select_word = true }) end,
        mode = { "n" },
        silent = true,
        noremap = false,
        desc = "Search on current file",
      },
    },
    mapping = {
      ['open_in_vsplit'] = {
        map = "<c-v>",
        cmd = "<cmd>lua vim.cmd('vsplit ' .. require('spectre.actions').get_current_entry().filename)<CR>",
        desc = "open in vertical split"
      },
      ['open_in_split'] = {
        map = "<c-s>",
        cmd = "<cmd>lua vim.cmd('split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
        desc = "open in horizontal split"
      },
      ['open_in_tab'] = {
        map = "<c-t>",
        cmd = "<cmd>lua vim.cmd('tab split ' .. require('spectre.actions').get_current_entry().filename)<CR>",
        desc = "open in new tab"
      },
    }
  },

  {
    'junegunn/vim-easy-align',
    lazy = false,
    -- TODO: keys =
    init = function()
      vim.cmd [[
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
      ]]
    end
  },

}
