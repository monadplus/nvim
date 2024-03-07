return {

  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_bg = true,
      show_end_of_buffer = true,
      italic_comment = true,
    },
    config = function(_, opts)
      require('dracula').setup(opts)

      vim.cmd [[colorscheme dracula]] -- dracula-soft for light environments

      -- Cursor
      vim.opt.guicursor = 'n-v-c:block-Cursor,i:ver25-iCursor,a:blinkon1'
      -- Cursor background
      vim.cmd [[highlight Cursor guifg=NONE guibg=#BFBFBF]]
    end
  },

}
