# monadplus/nvim

![screenshot dashboard](./screenshots/dashboard.png)
![screenshot lazygit](./screenshots/lazygit.png)
![screenshot rust](./screenshots/rust.png)

## Installation

First, [install](https://github.com/neovim/neovim/wiki/Installing-Neovim) neovim (at least version 8.0).

Secondly, install this configuration:

```bash
git clone git@github.com:monadplus/nvim.git "$HOME/.config/nvim" # or "$XDG_CONFIG_HOME/nvim"
```

Then, we'll need to create this path for our telescope history: `mkdir -p ~/.local/share/nvim/databases/`.

Finally, open neovim and let [lazy.nvim](https://github.com/folke/lazy.nvim) install all plugins for you (you'll need internet connection). 
Don't worry, lazy.nvim will auto-install the first time you open neovim. 
Once everything is installed, restart neovim and check all plugins are correctly installed `:Lazy health`.

## Keybindings

See [keybindings](./docs/keybindings.md).

## Dependencies

> This section is incomplete

- `git`, [fd](https://github.com/sharkdp/fd)
- [nvim-spectre](https://github.com/nvim-pack/nvim-spectre): [ripgrep](https://github.com/BurntSushi/ripgrep) and GNU sed
- [markdown-preview](https://github.com/iamcco/markdown-preview.nvim): [node](https://nodejs.org/en/) and [yarn](https://yarnpkg.com/).

## LSP Servers

This project is configured using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig).
For the lsp client to work, the client needs their corresponding LSP servers.
LSP servers can be installed from your distribution's package manager.
Alternatively, you can configure the plugin [mason.nvim](https://github.com/williamboman/mason.nvim) (**which is not configured**) to automatically install them.

The following languages are configured out of the box. 
You will only have to install their corresponding LSP server.

- `Python`: [pyright](https://github.com/microsoft/pyright)
- `Rust`: [rust-analyzer](https://github.com/rust-lang/rust-analyzer)
- `Haskell`: [haskell-language-server](https://github.com/haskell/haskell-language-server)
- `Nix`: [nil](https://github.com/oxalica/nil)
- `Lua`: [lua-language-server](https://github.com/LuaLS/lua-language-server)
- `Bash`: [bash-language-server](https://github.com/bash-lsp/bash-language-server)
- `Yaml`: [yaml-language-server](https://github.com/redhat-developer/yaml-language-server)
- `Markdown`: [marksman](https://github.com/artempyanykh/marksman)

Feel free to add/remove servers from [lsp.lua](/lua/monadplus/plugins/lsp.lua). See [server configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md) for more information of available servers.

## Issues

Feel free to open an [issue](https://github.com/monadplus/nvim/issues) to fix or improve this configuration.
