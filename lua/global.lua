local lite_flg_path = vim.fn.stdpath("config") .. "/lite_mode.flg"

if vim.fn.empty(vim.fn.glob(lite_flg_path)) == 0 then
    vim.g.lite_mode = true
end

vim.g.mapleader = " "
vim.g.encoding = "UTF-8"