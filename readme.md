<!-- markdownlint-disable MD033 -->
<!-- markdownlint-disable MD024 -->
# README.md

My neovim configs.

## Installation

### 1. **Install Requirements**

<details closed>
  <summary>Make sure following tools be installed.</summary>
  - unzip
  - curl
  - wget
  - tar
  - gzip
  - fd
  - ripgrep
  - python
  - gitui
  - im-select
</details>

### 2. **Setup Python Provider**

#### Windows

``` shell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim
python -m venv "$HOME\.virtualenvs\debugpy
$HOME\.virtualenvs\neovim\Scripts\python.exe -m pip install neovim
$HOME\.virtualenvs\debugpy\Scripts\python.exe -m pip install debugpy
```

#### UNIX-like

``` shell
mkdir ~\.virtualenvs
python -m venv ~\.virtualenvs\neovim
python -m venv ~\.virtualenvs\debugpy
~\.virtualenvs\neovim\bin\python -m pip install --upgrade pip
~\.virtualenvs\debugpy\bin\python -m pip install --upgrade pip
~\.virtualenvs\neovim\bin\python -m pip install neovim
~\.virtualenvs\debugpy\bin\python -m pip install debugpy
```

### 3. Clone

#### Windows

```powershell
git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"
```

#### UNIX-like

```bash
git clone https://github.com/montenoki/nvim ~/.config/nvim
```
