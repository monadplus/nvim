# Keybindings

> This is a work-in-progress.

List of all additional keybindings on top of the default Neovim keybindings.

For more details see [plugins configuration](../lua/plugins).

## Git

### Neogit: git porcelain

- `<leader>gg`: git status
- `<leader>gc`: git commit
- `<leader>gd`: diff
- `<leader>gh`: file history
- `<leader>gl`: git log

### Diffview

Normal-mode:
- `<leader>dv`: open diffview
  - :DiffviewOpen HEAD~2
  - :DiffviewOpen HEAD~4..HEAD~2
  - :DiffviewOpen d4a7abd
  - :DiffviewOpen origin/main...HEAD
  - :DiffviewOpen HEAD~2 -- foo.lua
- `<leader>dc`: close diffview
- `<leader>dh`: diffview file history

Visual-mode:
- `<leader>d`: diffview file history

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

### Gitsigns

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

## Auto-complete

## Telescope

## Editing

### nvim-spectre: search and replace panel

- `<leader>S`: Open spectre
- `<leader>ss`: Replace current word
- `<leader>sw`: Replace currend word in file

### vim-easy-align: align code

- `ga`: EasyAlign
    - Example: `gaip=` -> inner paragraph, align around '='
    - Visual also works!

- `gaip`: inner paragraph
    - `=`: around 1st occurrences
    - `2=`: around 2st occurrences
    - `*=`: around all occurrences
    - `<enter>`: Switching betweeen left/right/center alignment modes
- `gaip<space>` for align around whitespaces
- `gaip,` comma

### Comment.nvim

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

### vim-visual-multi

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
- `\\A`: select all words in the file
- `\\/`: regex

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
- `\\c`: create cursors from visual selection

> vim-visual-multi can do a lot more, but this is enough to take out 80% of it.

## nvim-surround: surround code with ease

Normal:
- `ys{motion}{char}`: add
- `ds{char}`: delete
- `cs{target}{replacement}`: change

Visual/Select:
- `S{char}`: add

More at https://github.com/kylechui/nvim-surround/blob/main/doc/nvim-surround.txt

### Spelling

`]s`: Move to the next misspelt word
`[s`: Move to the previous misspelt word
`z=`: Provide suggestions (you can entire the suggestion ID and enter to replace the word)
`zg`: Add a word to the dictionary

More at [spell](https://neovim.io/doc/user/spell.html)

### Undotree

Better undo

- `U`: open undo tree
- `?`: help

## Treesitter

## Coding

### LSP

Navigation:
- `[d`: next diagnostic
- `]d`: previous diagnostic

Normal:
- `gd`: go to definition
- `gD`: go to definition (vsplit)
- `gr`: go to references
- `gi`: go to implementation
- `K`: hover short docs
- `<C-k>`: hover long docs
- `<leader>ca`: code action
- `<leader>me`: Show errors under cursor
- `<leader>mf`: format
- `<leader>mr`: rename
- `<leader>mR`: Restart LSP
- `<leader>mL`: Show LSP logs

- `<leader>wa`: add workspace folder
- `<leader>wr`: remove workspace folder
- `<leader>wl`: list workspace folders

#### haskell

- `<leader>ma`: Hover code actions
- `<leader>mc`: Open *.cabal
- `<leader>mC`: Open stack.yaml
- `<leader>mh`: Telescope hoogle
  - `<CR>`: entry to clipboard
  - `<C-b>`: open in browser
- `<leader>mH`: Telescope hoogle under cursor
  - `<CR>`: entry to clipboard
  - `<C-b>`: open in browser
  - `<C-r>`: replace word under cursor
- `<leader>mt`: repl buffer
- `<leader>mT`: repl project
- `<leader>ml`: repl load file
- `<leader>mq`: quit repl

### Snippets

Snippets are defined [here](./snippets).

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

### Trouble.nvim

Better quicklist, lsp references, etc.

Trouble commands are under the prefix `x`.

In a quicklist:
- `j`: next
- `k`: previous
- `<cr>`/`<tab>`: jump and close
- `q`: close
- `<c-s>`: open hsplit
- `<c-v>`: open vsplit

## UI

## Util

### Folds

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

### Orgmode

> This plugin is disabled

For help: `g?`

- Agenda: `<leader>oa`
- Capture: `<leader>oc`
- Org files:
  - `<Tab>` / `<S-Tab>`: toggle folding
  - `<<` / `>>`: promote headline
  - `<s` / `>s`: promote subtree
  - `<leader><cr>`: add headline/list item
  - `<C-space>`: checkbox
  - `<leader>oi`: insert timestamp/deadline/headline/todo item
  - `<C-a>\<C-x>`: increase/decrease date
  - `cid`: change date via calendar

Tutorial: https://github.com/nvim-orgmode/orgmode/wiki/Getting-Started
