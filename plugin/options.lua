-- disable netrw; recommended by nvim-tree.lua
vim.g.loaded = 1
-- vim.g.loaded_netrw = 1 -- Disabling this makes 'gx' not working
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

opt.pumblend = 17 -- Floating windows transparency
opt.wildmode = "longest:full" -- autocomplete opts
opt.wildoptions = "pum" -- autocomplete opts
opt.wildignore = "Carg.lock" -- Ignore fails
opt.wildignore:append { "*.o", "*~" }
vim.g.loaded_matchparen = 1 -- disable paren highlight
opt.showmatch = true
opt.tabstop = 2 -- tab width
opt.shiftwidth = 2 -- '>>' width
opt.softtabstop = 2
opt.expandtab = true -- space instead of tab
opt.smartindent = true
opt.wrap = true -- do not break lines
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 1000 -- maximum number of undo
opt.scrolloff = 8
opt.equalalways = true -- resize windows on new
opt.splitright = true
opt.splitbelow = true
-- vim.o.laststatus = 0 -- last status height
-- vim.o.cmdheight = 0 -- command height
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.clipboard = "unnamedplus"
opt.termguicolors = true
opt.ignorecase = true
opt.smartcase = true -- depends on ignorecase
opt.breakindent = true
opt.showbreak = ">>>"
opt.linebreak = true
opt.belloff = "all"
opt.inccommand = "split"
opt.updatetime = 1000
opt.timeoutlen = 500
vim.o.fillchars = [[eob:~,fold: ,foldopen:,foldsep: ,foldclose:]]
-- https://github.com/kevinhwang91/nvim-ufo/issues/4#issuecomment-1160512800
opt.foldcolumn = '0'
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 0
opt.foldenable = false

opt.spelllang = 'en_us'

-- https://github.com/nvim-orgmode/orgmode#links-are-not-concealed
opt.conceallevel = 2
opt.concealcursor = 'vc'
