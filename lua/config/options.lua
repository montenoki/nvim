-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.g settings

vim.g.maplocalleader = " "

vim.g.autoformat = false

vim.g.snacks_animate = false

-- Set the python path based on operating system
vim.g.python3_host_prog = vim.env.HOME
  .. (
    vim.fn.has("win32") == 1 and "\\.virtualenvs\\neovim\\Scripts\\python.exe"
    or "/.virtualenvs/neovim/bin/python"
  )

-- Set default for Windows
LazyVim.terminal.setup("pwsh")

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

opt.shiftwidth = 0

opt.spell = true

opt.tabstop = 4

opt.textwidth = 80

-- Use arrow key to move next line when cursor at end of line
opt.whichwrap = "<,>,[,]"

opt.wrap = true

-- fix the problem that cant see last char when scrollbar on.
-- opt.virtualedit = "onemore"