local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- use_rocks doesn't work
-- https://github.com/wbthomason/packer.nvim/issues/524

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'    -- Better std

  -- Git
  use {
    'NeogitOrg/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }
  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release'
  }
  -- use 'kdheepak/lazygit.nvim' -- Using neogit

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use 'nvim-treesitter/nvim-treesitter-context'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'
  use {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
    branch = '2.x.x',
  }
  use {
    'folke/trouble.nvim',
    requires = 'nvim-tree/nvim-web-devicons',
  }
  use 'hkupty/iron.nvim'
  -- use 'kosayoda/nvim-lightbulb' -- Disabled: performance cost > usefulness
  -- use 'folke/neoconf.nvim' -- can't make it work
  -- use 'mfussenegger/nvim-lint'

  -- Debugging
  use 'mfussenegger/nvim-dap'
  use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

  -- Autocomplete
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'rafamadriz/friendly-snippets'

  -- UI
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      { 'nvim-tree/nvim-web-devicons', opt = true },
      { 'arkav/lualine-lsp-progress' },
    }
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    -- tag = 'nightly'
  }
  use 'stevearc/oil.nvim'
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- requires: gcc, make
  use { 'nvim-telescope/telescope-smart-history.nvim', requires = { 'kkharji/sqlite.lua' } }
  use { 'glepnir/dashboard-nvim', commit = 'f7d623457d6621b25a1292b24e366fae40cb79ab' }
  use {
    'lukas-reineke/indent-blankline.nvim',
    tag = "v2.20.8",
  }
  use 'MrcJkb/telescope-manix'
  use 'luc-tielen/telescope_hoogle'
  use 'sindrets/winshift.nvim'
  use 'https://gitlab.com/yorickpeterse/nvim-window.git'

  -- Text editing
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- recommended
  }
  use 'numToStr/Comment.nvim'
  use 'junegunn/vim-slash' -- :nohlsearch when cursor moves
  use 'mbbill/undotree'    -- Undo UI
  use 'windwp/nvim-autopairs'
  use {
    'kylechui/nvim-surround',
    tag = "*", -- Latest stable release
  }
  use 'mg979/vim-visual-multi'
  -- use 'chentoast/marks.nvim' -- Not so useful
  use {
    'ThePrimeagen/harpoon',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }
  use 'Vonr/align.nvim'
  use { 'junegunn/vim-easy-align',
    -- FIXME: not loading
    config = function()
      vim.cmd [[
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
      ]]
    end
  }

  -- Themes
  use 'Mofiqul/dracula.nvim'

  -- Fancy
  use 'RRethy/vim-illuminate' -- Highlight current word
  use 'karb94/neoscroll.nvim' -- Smooth <C-d>, <C-u>, ...
  use 'folke/twilight.nvim'   -- dim inactive portions of code
  use 'folke/zen-mode.nvim'   -- distraction free mode
  use {
    'folke/todo-comments.nvim',
    requires = "nvim-lua/plenary.nvim",
  }

  -- Utils
  -- use 'rmagatti/auto-session' -- NOTE: it does error from time to time
  use 'nvim-orgmode/orgmode'
  use 'folke/which-key.nvim'
  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async'
  }
  use 'famiu/bufdelete.nvim'
  use {
    'dhruvmanila/browser-bookmarks.nvim',
    tag = 'v3.1.0',
    requires = {
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
    }
  }

  -- Neovim + Lua development
  use 'folke/neodev.nvim'
  -- use 'rcarriga/nvim-notify'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
