# Readme.md

## Requirements

<details closed>
<summary>Make sure install all.</summary>
- unzip
- wget
- curl
- gzip
- tar
- fd
- ripgrep
- git
- python
- gitui
</details>

## Installation

Setup python host

``` shell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim
python -m venv "$HOME\.virtualenvs\debugpy
$HOME\.virtualenvs\neovim\Scripts\python.exe -m pip install neovim
$HOME\.virtualenvs\debugpy\Scripts\python.exe -m pip install debugpy
```

### Windows

```powershell
git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"

```

### Mac OS

```bash
git clone https://github.com/montenoki/nvim ~/.config/nvim
```
