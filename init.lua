-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()

-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1

require('utils.global')

require('basic')

require('colorscheme')

require('plugins')

require('keybindings')

require('autocmds')

require('lsp.setup')

require('dap.setup')
