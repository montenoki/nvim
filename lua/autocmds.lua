local myAutoGroup = vim.api.nvim_create_augroup('myAutoGroup', {
        clear = true,
    })

local autocmd = vim.api.nvim_create_autocmd

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

-- 进入Terminal 自动进入插入模式
autocmd('TermOpen', {
    group = myAutoGroup,
    command = 'startinsert',
})

-- 修改lua/plugins.lua 自动更新插件
autocmd('BufWritePost', {
    group = myAutoGroup,
    callback = function()
        local plugins_path
        if getSysName() == 'Windows' or getSysName() == 'Windows_NT' then
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

-- Highlight on yank
autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = myAutoGroup,
    pattern = '*',
})

-- 用o换行不要延续注释
autocmd('BufEnter', {
    group = myAutoGroup,
    pattern = '*',
    callback = function()
        vim.opt.formatoptions = vim.opt.formatoptions
            - 'o' -- O and o, don't continue comments
            + 'r' -- But do continue when pressing enter.
    end,
})

-- 保存时自动格式化并保存视图
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
