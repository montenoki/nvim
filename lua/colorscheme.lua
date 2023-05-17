vim.o.background = 'dark'

local colorscheme

if not lite_mode then
    colorscheme = 'dracula'
else
    colorscheme = 'dracula' 
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return
end