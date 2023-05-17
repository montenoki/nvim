uConfig = require('uConfig')
lite_mode = uConfig.lite_mode



if not lite_mode then
    vim.o.background = 'dark'
    local colorscheme = 'dracula'

    local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
    if not status_ok then
        vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
        return
    end

end
