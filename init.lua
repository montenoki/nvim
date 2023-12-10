-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()
require("global")
require("plugins")
require("colorscheme")
