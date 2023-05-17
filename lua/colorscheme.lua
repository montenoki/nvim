vim.o.background = 'dark'

-- local colorscheme = 'dracula'
local colorscheme
if lite_mode then
    colorscheme = 'solarized8'
else
    colorscheme = 'dracula'
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return
end
