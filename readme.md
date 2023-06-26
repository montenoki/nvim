# Installation

## Windows

```powershell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim
python -m venv "$HOME\.virtualenvs\debugpy
$HOME\.virtualenvs\neovim\Scripts\python.exe -m pip install neovim
$HOME\.virtualenvs\debugpy\Scripts\python.exe -m pip install debugpy

git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"

scoop install gitui
```

## Mac OS

```bash
git clone https://github.com/montenoki/nvim ~/.config/nvim
```
