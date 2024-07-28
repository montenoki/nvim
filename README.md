<!-- markdownlint-disable MD013 -->

<!-- markdownlint-disable MD024 -->

<!-- markdownlint-disable MD033 -->

# nvim

`<a href="https://dotfyle.com/montenoki/nvim"><img src="https://dotfyle.com/montenoki/nvim/badges/plugins?style=flat" alt="plugins"/>``</a>`
`<a href="https://dotfyle.com/montenoki/nvim"><img src="https://dotfyle.com/montenoki/nvim/badges/leaderkey?style=flat" alt="leaderkey"/>``</a>`
`<a href="https://dotfyle.com/montenoki/nvim"><img src="https://dotfyle.com/montenoki/nvim/badges/plugin-manager?style=flat" alt="plugin manager"/>``</a>`

My neovim configs.

## Try my configs

Clone the repository and install the plugins:

```bash
git clone git@github.com:montenoki/nvim ~/.config/montenoki/nvim
NVIM_APPNAME=montenoki/nvim/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```bash
NVIM_APPNAME=montenoki/nvim/ nvim
```

## Requirements

> Install requires Neovim 0.9+. Always review the code before installing a configuration.

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

### Arch

```bash
sudo pacman -S gitui python python-pip ripgrep unzip wget nodejs npm
```

### Mac

```bash
brew tap daipeihust/tap && brew install curl fd gitui gzip im-select node python ripgrep tar unzip wget
```

## Installation

### 1. Clone

#### Windows

```powershell
git clone https://github.com/montenoki/nvim "$env:LOCALAPPDATA\nvim"
```

#### Mac or Linux

```bash
git clone git@github.com:montenoki/nvim ~/.config/nvim
```

### 2. **Setup Python Provider**

#### Windows

```shell
mkdir "$HOME\.virtualenvs"
python -m venv "$HOME\.virtualenvs\neovim"
cd $HOME
.virtualenvs\neovim\Scripts\python.exe -m pip install pynvim debugpy
```

#### Mac or Linux

```shell
sh "$HOME/.config/nvim/setup_provider.sh"
```

### 3. Install plugins

```bash
nvim --headless +"Lazy! sync" +qa
```

## Plugins

### bars-and-lines

- [luukvbaal/statuscol.nvim](https://dotfyle.com/plugins/luukvbaal/statuscol.nvim)
- [SmiteshP/nvim-navic](https://dotfyle.com/plugins/SmiteshP/nvim-navic)

### colorscheme

- [EdenEast/nightfox.nvim](https://dotfyle.com/plugins/EdenEast/nightfox.nvim)

### colorscheme-creation

- [rktjmp/lush.nvim](https://dotfyle.com/plugins/rktjmp/lush.nvim)

### comment

- [numToStr/Comment.nvim](https://dotfyle.com/plugins/numToStr/Comment.nvim)
- [folke/todo-comments.nvim](https://dotfyle.com/plugins/folke/todo-comments.nvim)

### completion

- [zbirenbaum/copilot.lua](https://dotfyle.com/plugins/zbirenbaum/copilot.lua)
- [simrat39/rust-tools.nvim](https://dotfyle.com/plugins/simrat39/rust-tools.nvim)
- [hrsh7th/nvim-cmp](https://dotfyle.com/plugins/hrsh7th/nvim-cmp)

### cursorline

- [RRethy/vim-illuminate](https://dotfyle.com/plugins/RRethy/vim-illuminate)

### debugging

- [mfussenegger/nvim-dap](https://dotfyle.com/plugins/mfussenegger/nvim-dap)
- [rcarriga/nvim-dap-ui](https://dotfyle.com/plugins/rcarriga/nvim-dap-ui)
- [theHamsta/nvim-dap-virtual-text](https://dotfyle.com/plugins/theHamsta/nvim-dap-virtual-text)

### dependency-management

- [Saecki/crates.nvim](https://dotfyle.com/plugins/Saecki/crates.nvim)

### diagnostics

- [folke/trouble.nvim](https://dotfyle.com/plugins/folke/trouble.nvim)

### editing-support

- [keaising/im-select.nvim](https://dotfyle.com/plugins/keaising/im-select.nvim)
- [echasnovski/mini.ai](https://dotfyle.com/plugins/echasnovski/mini.ai)
- [HiPhish/rainbow-delimiters.nvim](https://dotfyle.com/plugins/HiPhish/rainbow-delimiters.nvim)
- [echasnovski/mini.pairs](https://dotfyle.com/plugins/echasnovski/mini.pairs)
- [nvim-treesitter/nvim-treesitter-context](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-context)

### formatting

- [stevearc/conform.nvim](https://dotfyle.com/plugins/stevearc/conform.nvim)

### fuzzy-finder

- [nvim-telescope/telescope.nvim](https://dotfyle.com/plugins/nvim-telescope/telescope.nvim)

### git

- [NeogitOrg/neogit](https://dotfyle.com/plugins/NeogitOrg/neogit)
- [sindrets/diffview.nvim](https://dotfyle.com/plugins/sindrets/diffview.nvim)
- [lewis6991/gitsigns.nvim](https://dotfyle.com/plugins/lewis6991/gitsigns.nvim)

### indent

- [lukas-reineke/indent-blankline.nvim](https://dotfyle.com/plugins/lukas-reineke/indent-blankline.nvim)
- [echasnovski/mini.indentscope](https://dotfyle.com/plugins/echasnovski/mini.indentscope)

### keybinding

- [LinArcX/telescope-command-palette.nvim](https://dotfyle.com/plugins/LinArcX/telescope-command-palette.nvim)
- [folke/which-key.nvim](https://dotfyle.com/plugins/folke/which-key.nvim)

### lsp

- [jose-elias-alvarez/null-ls.nvim](https://dotfyle.com/plugins/jose-elias-alvarez/null-ls.nvim)
- [simrat39/symbols-outline.nvim](https://dotfyle.com/plugins/simrat39/symbols-outline.nvim)
- [mfussenegger/nvim-lint](https://dotfyle.com/plugins/mfussenegger/nvim-lint)
- [nvimtools/none-ls.nvim](https://dotfyle.com/plugins/nvimtools/none-ls.nvim)
- [neovim/nvim-lspconfig](https://dotfyle.com/plugins/neovim/nvim-lspconfig)

### lsp-installer

- [williamboman/mason.nvim](https://dotfyle.com/plugins/williamboman/mason.nvim)

### markdown-and-latex

- [iamcco/markdown-preview.nvim](https://dotfyle.com/plugins/iamcco/markdown-preview.nvim)

### motion

- [ggandor/leap.nvim](https://dotfyle.com/plugins/ggandor/leap.nvim)

### nvim-dev

- [folke/neodev.nvim](https://dotfyle.com/plugins/folke/neodev.nvim)
- [MunifTanjim/nui.nvim](https://dotfyle.com/plugins/MunifTanjim/nui.nvim)
- [nvim-lua/plenary.nvim](https://dotfyle.com/plugins/nvim-lua/plenary.nvim)
- [jbyuki/one-small-step-for-vimkind](https://dotfyle.com/plugins/jbyuki/one-small-step-for-vimkind)

### plugin-manager

- [folke/lazy.nvim](https://dotfyle.com/plugins/folke/lazy.nvim)

### project

- [ahmedkhalf/project.nvim](https://dotfyle.com/plugins/ahmedkhalf/project.nvim)

### scrollbar

- [petertriho/nvim-scrollbar](https://dotfyle.com/plugins/petertriho/nvim-scrollbar)

### search

- [windwp/nvim-spectre](https://dotfyle.com/plugins/windwp/nvim-spectre)

### session

- [rmagatti/auto-session](https://dotfyle.com/plugins/rmagatti/auto-session)

### split-and-window

- [sindrets/winshift.nvim](https://dotfyle.com/plugins/sindrets/winshift.nvim)
- [echasnovski/mini.bufremove](https://dotfyle.com/plugins/echasnovski/mini.bufremove)

### startup

- [glepnir/dashboard-nvim](https://dotfyle.com/plugins/glepnir/dashboard-nvim)
- [nvimdev/dashboard-nvim](https://dotfyle.com/plugins/nvimdev/dashboard-nvim)

### statusline

- [nvim-lualine/lualine.nvim](https://dotfyle.com/plugins/nvim-lualine/lualine.nvim)

### syntax

- [nvim-treesitter/nvim-treesitter](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter)
- [nvim-treesitter/nvim-treesitter-textobjects](https://dotfyle.com/plugins/nvim-treesitter/nvim-treesitter-textobjects)
- [echasnovski/mini.surround](https://dotfyle.com/plugins/echasnovski/mini.surround)

### tabline

- [akinsho/bufferline.nvim](https://dotfyle.com/plugins/akinsho/bufferline.nvim)

### test

- [nvim-neotest/neotest](https://dotfyle.com/plugins/nvim-neotest/neotest)

### utility

- [rcarriga/nvim-notify](https://dotfyle.com/plugins/rcarriga/nvim-notify)
- [stevearc/dressing.nvim](https://dotfyle.com/plugins/stevearc/dressing.nvim)
- [folke/noice.nvim](https://dotfyle.com/plugins/folke/noice.nvim)
- [kevinhwang91/nvim-ufo](https://dotfyle.com/plugins/kevinhwang91/nvim-ufo)

## Language Servers

- cmake
- denols
- html
- marksman
- ruff_lsp
- taplo
- tsserver
