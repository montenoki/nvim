-- TODO:
local uConfig = require('uConfig')
local uToggleTerm = uConfig.toggleterm

if uToggleTerm == nil or not uToggleTerm.enable then
    return
end

local toggleterm = requirePlugin('toggleterm')
if toggleterm == nil then
    return
end

toggleterm.setup({
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return vim.o.columns * 0.3
        end
    end,
    insert_mappings = true,
    start_in_insert = true,
    terminal_mappings = true,
})

local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
    cmd = 'lazygit',
    dir = 'git_dir',
    direction = 'float',
    float_opts = {
        border = 'double',
    },
    on_open = function(term)
        vim.cmd('startinsert!')
        -- q / <leader>tg 关闭 terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<leader>tg', '<cmd>close<CR>', { noremap = true, silent = true })
        -- ESC 键取消，留给lazygit
        if vim.fn.mapcheck('<Esc>', 't') ~= '' then
            vim.api.nvim_del_keymap('t', '<Esc>')
        end
    end,
    on_close = function(_)
        -- 添加回来
        vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {
            noremap = true,
            silent = true,
        })
    end,
})

local xterm = Terminal:new({})

local M = {}

M.lazygit_toggle = function()
    lazygit:toggle()
end

M.botton_toggle = function()
    xterm.direction = 'horizontal'
    xterm:toggle()
end

M.float_toggle = function()
    xterm.direction = 'float'
    xterm:toggle()
end

vim.keymap.set({ 'n', 't' }, uToggleTerm.lazygit_toggle, M.lazygit_toggle)
vim.keymap.set({ 'n', 't' }, uToggleTerm.float_toggle, M.float_toggle)
vim.keymap.set({ 'n', 't' }, uToggleTerm.botton_toggle, M.botton_toggle)
