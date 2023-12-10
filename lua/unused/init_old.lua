-- Speed up loading Lua modules in Neovim to improve startup time.
vim.loader.enable()

require('utils.global')
require('basic')

if not vim.g.vscode then
    require('colorscheme')
    require('keybindings')
    require('autocmds')
    require('lsp.setup')
    -- VSCode extension
    require('plugins')
    require('dap.setup')
end