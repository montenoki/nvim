<!-- markdownlint-disable MD013 -->
<!-- markdownlint-disable MD024 -->
<!-- markdownlint-disable MD033 -->
# nvim

My neovim configs.

## Requirements

<details closed>
<summary>Ensure you have the following installed on your system.</summary>

- **curl**: Get a file from an HTTP, HTTPS or FTP server

- **fd**: Simple, fast and user-friendly alternative to find

- **gitui**: Blazing fast terminal-ui for git written in rust

- **gzip**: Popular GNU data compression program

- **im-select**: Switch your input method in shell.

- **node.js**

- **python**

- **ripgrep**: Search tool like grep and The Silver Searcher

- **tar**: GNU version of the tar archiving utility

- **unzip**: Extraction utility for .zip compressed archives

- **wget**: Internet file retriever

</details>

### Mac

```bash
brew tap daipeihust/tap && brew install curl fd gitui gzip im-select node python ripgrep tar unzip wget
```

## Installation

### Clone

### 2. **Setup Python Provider**

#### Windows

``` shell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim
python -m venv "$HOME\.virtualenvs\debugpy
$HOME\.virtualenvs\neovim\Scripts\python.exe -m pip install neovim
$HOME\.virtualenvs\debugpy\Scripts\python.exe -m pip install debugpy
```

#### Mac or Linux

``` shell
zsh "$HOME/.config/nvim/setup_py_provider.sh"
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
