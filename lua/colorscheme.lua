vim.o.background = 'dark'

if not lite_mode then
    local colorscheme = 'dracula'
    local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
    if not status_ok then
        vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
        return
    end
end
