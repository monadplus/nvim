# Keybindings: Cheat Sheet

## Tmux

The tmux keybindings are modified by the plugin [tmux-vim-bindings](https://github.com/ek9/tmux-vim-bindings/blob/master/bindings.tmux). Prefix: `M-a` (recall `M = <Alt>`)

- `M-r`: reload
- `M-n`: manual command
- `M-m`: man
- `M-e`: choose session
- `Prefix + )`/`Prefix + (`: next/previous session
- `Prefix + d`: detach session
- `M-t`: rename session
- `Prefix + ,`: rename windows
- `M-w`: list windows
- `M-backtick`: last-window
- `M-tab`: last-pane
- `M-c`: new window
- `M-x`: kill-pane/kill-window
- `M-s`: split window horizontal
- `M-v`: split window vertical
- `M-'`: select window manually
- `M-1/2/.../12`: select window n
- `M-h/j/k/l`: focus pane
- `M-Left/Up/Right/Down`: resize pane
- `M-,`: swap pane
- `M-.`: swap pane

## Neovim

### TimUntersberger/neogit

- `<leader>gg`: status buffer
- `<leader>gc`: commit
- `<leader>gv`: diffview
- `<leader>gh`: file history
- `<leader>gl`: log

On git buffer:
- `d`: open diffview

### sindrets/diffview.nvim

Normal-mode:
- `<leader>vv`: open diffview
  - :DiffviewOpen HEAD~2
  - :DiffviewOpen HEAD~4..HEAD~2
  - :DiffviewOpen d4a7abd
  - :DiffviewOpen origin/main...HEAD
  - :DiffviewOpen HEAD~2 -- foo.lua
- `<leader>vc`: close diffview
- `<leader>vh`: diffview file history

Visual-mode:
- `<leader>v`: diffview file history

On Diffview:
  - File panel (Left):
    - `j`/ `k`: next/previous
    - `<tab>`/`<s-tab>`: next/previous entry
    - `<leader>b`: toggle panel
    - `g<C-x>`: cycle layout
    - `]x`/`[x`: next/previous conflict
    - `-`: toggle stage
    - `S`: Stage all
    - `U`: Unstage all
    - `X`: Restore entry
    - `<c-b>`: scroll up
    - `<c-f>`: scroll down
    - `i`: listing style
    - `f`: flatten dirs
    - `R`: refresh
  - view (Right):
    - `<leader>c`
      - `o`: our changes
      - `t`: their changes
      - `b`: base changes
      - `a`: all changes
    - `dx`: none of the changes
    - `u`: undo
    - `<tab>`/`<s-tab>`: next/previous entry
    - `]x`/`[x`: next/previous conflict
    - `g<C-x>`: cycle layout

Fore more info:
- :h :DiffviewFileHistory
- :h diffview-merge-tool

### lewis6991/gitsigns.nvim

Navigation:
- `]c`: next hunk
- `[c`: previous hunk

Actions:
- `<leader>hs`: stage hunk
- `<leader>hS`: stage buffer
- `<leader>hu`: undo stage hunk
- `<leader>hr`: reset hunk
- `<leader>hR`: reset buffer
- `<leader>hp`: preview hunk
- `<leader>hb`: blame line
- `<leader>tb`: toggle blame line
- `<leader>hd`: diff buffer
- `<leader>hD`: diff hunk
- `<leader>td`: toggle deleted

### numToStr/Comment.nvim

NORMAL mode:
- `gcc` - Toggles the current line using linewise comment
- `gbc` - Toggles the current line using blockwise comment
- `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
- `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
- `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
- `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment

- `gco` - Insert comment to the next line and enters INSERT mode
- `gcO` - Insert comment to the previous line and enters INSERT mode
- `gcA` - Insert comment to end of the current line and enters INSERT mode

VISUAL mode:
- `gc` - Toggles the region using linewise comment
- `gb` - Toggles the region using blockwise comment

### neovim/nvim-lspconfig

Navigation:
- `[d`: next diagnostic
- `]d`: previous diagnostic

Normal:
- `gd`: go to definition
- `gD`: go to references
- `gi`: go to implementation
- `K`: hover short docs
- `<C-K>`: hover long docs

- `<leader>rn`: rename
- `<leader>ca`: code action
- `<leader>f`: format
- `<leader>e`: hover
- `<leader>q`: list diagnostics

- `<leader>wa`: add workspace folder
- `<leader>wr`: remove workspace folder
- `<leader>wl`: list workspace folders

#### folke/trouble.nvim

- `j`: next
- `k`: previous
- `<cr>`/`<tab>`: jump and close
- `q`: close
- `<c-s>`: open hsplit
- `<c-v>`: open vsplit

### L3MON4D3/LuaSnip

Normal:
- `<C-space>`: complete
- `<C-e>`: abort
- `<CR>`: confirm
- `<Tab>`: next
- `<S-Tab>`: previous
- `<C-d>`: scroll up (dialog)
- `<C-f>`: scroll down (dialog)

Snippet:
- `<Tab>`: next
- `<S-Tab>`: previous

### kylechui/nvim-surround

Normal:
- `ys{motion}{char}`: add
- `ds{char}`: delete
- `cs{target}{replacement}`: change

Visual/Select:
- `S{char}`: add

More at https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt

### mbbill/undotree

- `U`: open undo tree
- `?`: help

### mg979/vim-visual-multi

> leader here refers to VM_leader (default '\\')

Extended mode (normal mode):
- [count]<C-n>: Find Word
  - `n`: next
  - `N`: select previous
  - `q`: skip and find next
  - `Q`: remove current
  - `]`: go to next
  - `[`: go to previous
  - `y/d/c/~/gu/gU` (don't wait for a motion)
  - `s`: select region e.g `siw`
  - `R`: replace pattern in region
  - `S`: surround (depends on nvim-surround)
  - Find Word also works on Visual/Select mode. 
    Select part of a word and <C-n>
  - `<C-a>`: increase numbers
- `leader-A`: select all words in the file
- `leader-/`: regex

Cursor mode (normal mode):
- `<C-Down>`/`<C-Up>`: Add Cursor Down/Up
- `<S-Right>` and `<S-Down>`: Select Right/Left
- `{y/d/c}<motion>`
- `s`: select region e.g `3<C-Down>siw` would create 3 cursors and select the current word
- `\\a` or `\\<` or `\\>`: Align (each do a different thing)
  E.g. Align the three bullet points: put your curson on the first `'-'` and press `2<C-Down>\\<-`
  ```
  - s...
    - s...
     - s...
  ```

- `Tab`: Switch cursor and extended mode

Visual-mode:
- `leader-c`: create cursors from visual selection

> vim-visual-multi can do a lot more, but this is enough to take out 80% of it.

### Folds

Using [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo).

- `z`
  - `c`: Close
  - `c`: Close
  - `o`: Open
  - `r`: Fold less
  - `R`: Open all folds
  - `m`: Fold more
  - `M`: Close all folds
  - `p`: Preview
    - `<c-u>`: scroll up
    - `<c-d>`: scroll down

### Spelling

`]s`: Move to the next misspelt word
`[s`: Move to the previous misspelt word
`z=`: Provide suggestions (you can entire the suggestion ID and enter to replace the word)
`zg`: Add a word to the dictionary

More at [spell](https://neovim.io/doc/user/spell.html)
