uConfig = require('uConfig')
lite_mode = uConfig.lite_mode


vim.o.background = 'dark'
local colorscheme

if lite_mode then
    colorscheme = 'PaperColor'
else
    colorscheme = 'dracula'
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)

if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return
end