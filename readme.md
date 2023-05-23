# Installation

## Windows

```powershell
git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"
pip install neovim
scoop install gitui
```
## Mac OS
```bash
git clone https://github.com/montenoki/nvim ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
brew install lazygit
brew install rg
brew install fd
```
## Arch OS
```
sudo pacman -S ripgrep fd lazygit
```

TODO:
- nvim-tree预览时使用telescope
- 自动保存session的autocmd
- telescope todo list
