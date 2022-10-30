# Issues

## 'treesitter/highlighter: Error executing lua problem in neovim config'

```
:TSUpdate 
```

In theory this should be autoexecuted by packer :shrug:

## :MarkdownPreview doesn't work

Check markdown-preview is installed:

```bash
cd /home/arnau/.local/share/nvim/site/pack/packer/start
git clone https://github.com/iamcco/markdown-preview.nvim.git
cd markdown-preview.nvim
yarn install
yarn build
```
