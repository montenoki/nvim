# Readme.md

## Installation

### 1. **Setup Python Provider**

``` shell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim
python -m venv "$HOME\.virtualenvs\debugpy
$HOME\.virtualenvs\neovim\Scripts\python.exe -m pip install neovim
$HOME\.virtualenvs\debugpy\Scripts\python.exe -m pip install debugpy
```

### 2. **Install Requirements**

<details closed>
<summary>Make sure install all.</summary>

- unzip, git, curl, wget, tar, gzip, fd, ripgrep

- python, gitui

- im-select

</details>

### 3. Clone

- Windows

```powershell
git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"
```

- Linux or Mac

```bash
git clone https://github.com/montenoki/nvim ~/.config/nvim
```
