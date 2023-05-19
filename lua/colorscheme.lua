local uConfig = require('uConfig')

local colorscheme

if uConfig.lite_mode then
    vim.o.background = 'light'
    colorscheme = 'dim'
else
    vim.o.background = 'dark'
    colorscheme = 'dracula'
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return nil
end
