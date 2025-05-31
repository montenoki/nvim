-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g settings

vim.g.maplocalleader = " "

vim.g.snacks_animate = false

-- Set to "basedpyright" to use basedpyright instead of pyright.
vim.g.lazyvim_python_lsp = "pyright"

-- Set to "ruff_lsp" to use the old LSP implementation version.
vim.g.lazyvim_python_ruff = "ruff"

-- Set default for Windows
if vim.fn.has("win32") == 1 then
    LazyVim.terminal.setup("pwsh")
end

-- vim.opt Settings

local opt = vim.opt

-- Line length marker
opt.colorcolumn = "+1"

opt.completeopt = { "menu", "menuone", "popup", "noselect", "noinsert" }

opt.listchars = {
    eol = "↲",
    tab = "→ ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
    -- space = "␣",
}

opt.fixendofline = false

opt.formatoptions =
    { c = true, r = true, q = true, n = true, m = true, M = true, j = true }

opt.grepprg = "rg --vimgrep  -uu"

opt.list = false

opt.laststatus = 3

opt.shiftwidth = 0

opt.spell = false

opt.tabstop = 4

opt.textwidth = 80

-- Use arrow key to move next line when cursor at end of line
opt.whichwrap = "<,>,[,]"

opt.wrap = true

-- fix the problem that cant see last char when scrollbar on.
-- opt.virtualedit = "onemore"

-- Example for configuring Neovim to load user-installed installed Lua rocks:
package.path = package.path
    .. ";"
    .. vim.fn.expand("$HOME")
    .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path
    .. ";"
    .. vim.fn.expand("$HOME")
    .. "/.luarocks/share/lua/5.1/?.lua;"
