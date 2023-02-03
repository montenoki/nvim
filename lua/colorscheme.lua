vim.o.background = 'dark'

local colorscheme = 'dracula'
-- tokyonight
-- OceanicNext
-- gruvbox
-- zephyr
-- nord
-- onedark
-- nightfox

-- 透明化
vim.g.dracula_transparent_bg = true

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
    vim.notify('colorscheme: ' .. colorscheme .. ' Not Found!')
    return
end
