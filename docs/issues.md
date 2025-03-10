# Issues

## 'treesitter/highlighter: Error executing lua problem in neovim config'

```
:TSUpdate 
```

## Neovim hungs after start (blank screen with no input)

> Last time this didn't work.
> Rebooting solved the issue :shrug:

```sh
nvim --noplugin

# If neovim doesn't start up, it's neovim itself.
# Try downgrading neovim

# Otherwise, something is wrong with your config.
# Try this first (reinstall lazy.nvim)
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
# If this doesn't work.
# Start by moving your config and enable lazy.nvim alone
# and add plugins one by plugin
```
