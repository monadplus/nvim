local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
  return
end

gitsigns.setup {
  signs                        = {
    add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir                 = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked          = true,
  current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts      = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 0,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority                = 6,
  update_debounce              = 100,
  status_formatter             = nil, -- Use default
  max_file_length              = 40000, -- Disable if file is longer than this (in lines)
  preview_config               = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm                         = {
    enable = false
  },
  on_attach                    = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, silent = true, noremap = true, desc = "Next hunk" })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, silent = true, noremap = true, desc = "Previous hunk" })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true, noremap = true, desc = "Stage" })
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true, noremap = true, desc = "Reset" })
    map('n', '<leader>hS', gs.stage_buffer, { silent = true, noremap = true, desc = "Stage all" })
    map('n', '<leader>hu', gs.undo_stage_hunk, { silent = true, noremap = true, desc = "Undo stage" })
    map('n', '<leader>hR', gs.reset_buffer, { silent = true, noremap = true, desc = "Reset all" })
    map('n', '<leader>hp', gs.preview_hunk, { silent = true, noremap = true, desc = "Preview" })
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, { silent = true, noremap = true, desc = "Blame" })
    map('n', '<leader>hd', gs.diffthis, { silent = true, noremap = true, desc = "Diff" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { silent = true, noremap = true, desc = "Diff ~" })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { silent = true, noremap = true, desc = "Hunk blame" })
    map('n', '<leader>td', gs.toggle_deleted, { silent = true, noremap = true, desc = "Hunk deleted" })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true, noremap = true, desc = "Hunk" })
  end
}

vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { link = 'Visual' })
