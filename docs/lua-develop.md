# Neovim

## Execute lua from neovim

- `:lua`
- `:luado`
- `:luafile %` (absolute or relative paths)
- `:source ~/foo.lua` (absolute or relative paths)
- `:runtime faa/foo.lua` (uses the 'runtimepath')

## Execute lua from vimscript

- `luaeval()`
- `v:lua. + function` from global namespace (_G)

## Executing vimscript from lua

- `vim.cmd[[...]]`

## The 'vim' namespace

* `vim.inspect`: lua objects to human-readable string
* `vim.regex`: vim regexes from lua
* `vim.api`: API functions
* `vim.ui`: overridable ui functions
* `vim.loop`: neovim's event loop
* `vim.lsp`: built-in LSP client
* `vim.treesitter`: tree-sitter library

For more info `:help lua-stdlib` and `:help lua-vim`. 
API functions are documented under `:help api-global`.

Inspect value:
- `:lua print(vim.inspect(vim))`
- `:lua =vim.api`

## Managing vim options

- Global options:
  - `vim.api.nvim_set_option()`
- Buffer-local options:
  - `vim.api.nvim_buf_set_option()`
  - `vim.api.nvim_buf_get_option()`
- Window-local options:
  * `vim.api.nvim_win_set_option()`
  * `vim.api.nvim_win_get_option()`
For example:
- `vim.api.nvim_set_option('smarttab', false)`
- `print(vim.api.nvim_get_option('smarttab')) -- false`

More at [lua-vim-options](https://neovim.io/doc/user/lua.html#lua-vim-options)

## ['runtimepath'](https://neovim.io/doc/user/options.html#'runtimepath')

Autoloaded:
* `colors/`
* `compiler/`
* `ftplugin/`
* `ftdetect/`
* `indent/`
* `plugin/`
* `syntax/`

- `nvim/plugin/`: is loaded whenever neovim starts.
- `nvim/ftplugin/`: is only loaded for the specific filetype e.g. `nvim/ftplugin/python.lua` or `nvim/ftplugin/markdown.lua`.
- `nvim/autoload/`: define there functions corresponding to the plugins from `nvim/plugin`.
- `nvim/after/`: settings that you want to change from the normal plugin loading.

## Mapping

Read https://neovim.io/doc/user/map.html

- '' Normal, Visual, Select and Operator-pending
-	n	 Normal
-	v	 Visual and Select
-	s	 Select
-	x	 Visual
-	o	 Operator-pending
-	!	 Insert and Command-line
-	i	 Insert
-	l	 ":lmap" mappings for Insert, Command-line and Lang-Arg
-	c	 Command-line
-	t	 Terminal-Job

`vim.keymap.set` is `noremap` by default (not recursive). If you want the map to be recursive set the `opts` to `{remap = true}`.

See [recursive_mapping](https://neovim.io/doc/user/map.html#recursive_mapping).

## Functions

- vim.startswith

## User commands

```lua
vim.api.nvim_create_user_command(
    'Upper',
    function(opts)
        print(string.upper(opts.args))
    end,
    { nargs = 1 }
)

vim.cmd('Upper hello world') -- prints "HELLO WORLD"
```

See [:help command-attributes](https://neovim.io/doc/user/map.html#command-attributes). `desc` and `force` are also available.

## Highlights

- [`nvim_set_hl({ns_id}, {name}, {*val})`](https://neovim.io/doc/user/api.html#nvim_set_hl()):

```lua
vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = colors.visual, bg = "#FF0000" })
-- Clear the highlight group
vim.api.nvim_set_hl(0, "Visual", {})
```

- [nvim_get_hl_by_id](https://neovim.io/doc/user/api.html#nvim_get_hl_by_id())
- [nvim_get_hl_by_name](https://neovim.io/doc/user/api.html#nvim_get_hl_by_name())

## [Quickfix](https://neovim.io/doc/user/quickfix.html)

Quickfix and location list

## Tips & Tricks

- `nvim --startuptime startup.txt`
- `require()` caches the module. Use [plenary.reload()](https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua].
- Don't pad lua strings! In some cases like `vim.api.nvim_set_keymap` can be problematic.
- `:verbose set formatoptions` to see who made the last change

## Resources

- [nvim-lua-guide](https://github.com/nanotee/nvim-lua-guide)
- `:help lua`
