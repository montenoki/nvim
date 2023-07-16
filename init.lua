-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()

require('utils.global')

require('basic')

require('colorscheme')

require('plugins')

require('keybindings')

require('autocmds')

require('lsp.setup')

require('dap.setup')
