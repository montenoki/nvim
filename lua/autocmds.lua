local myAutoGroup = vim.api.nvim_create_augroup('myAutoGroup', {
    clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = myAutoGroup,
    pattern = '*',
})

-- add new line with 'o' do not continue comments
autocmd('BufEnter', {
    group = myAutoGroup,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            - 'o' -- O and o, don't continue comments
            + 'r' -- But do continue when pressing enter.
    end,
})

-- Auto save views
autocmd('BufWrite', {
    group = myAutoGroup,
    pattern = { '*.lua', '*.py', '*.sh' },
    callback = function()
        vim.lsp.buf.format()
        vim.cmd('mkview')
    end,
})

autocmd({ 'BufRead' }, {
    group = myAutoGroup,
    pattern = { '*.lua', '*.py', '*.sh' },
    callback = function()
        vim.cmd('silent! loadview')
    end,
})

-- Auto update plugins when modify lua/plugins.lua
autocmd('BufWritePost', {
    group = myAutoGroup,
    callback = function()
        local plugins_path
        local os_name = getSysName()
        if os_name == 'Windows' or os_name == 'Windows_NT' then
            plugins_path = 'lua\\plugins.lua'
        else
            plugins_path = 'lua/plugins.lua'
        end
        if vim.fn.expand('<afile>') == plugins_path then
            vim.api.nvim_command('source ' .. plugins_path)
            vim.api.nvim_command('PackerSync')
        end
    end,
})

-- 自动切换输入法，需要安装 im-select
-- https://github.com/daipeihust/im-select
-- autocmd('InsertLeave', {
--     group = myAutoGroup,
--     callback = require('utils.im-select').insertLeave,
-- })
-- autocmd('InsertEnter', {
--     group = myAutoGroup,
--     callback = require('utils.im-select').insertEnter,
-- })
