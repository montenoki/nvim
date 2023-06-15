local uConfig = require('uConfig')

local colorscheme

if uConfig.enable.lite_mode then
    vim.o.background = 'light'
    colorscheme = '16-colors'
else
    vim.o.background = 'dark'
    -- colorscheme = 'dracula'
    colorscheme = 'nightfox'
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return nil
end
