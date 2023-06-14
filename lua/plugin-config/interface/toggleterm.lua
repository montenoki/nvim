local uConfig = require('uConfig')
local toggleterm = requirePlugin('toggleterm')
local keys = uConfig.keys.toggleterm

if toggleterm == nil or not uConfig.enable.toggleterm then
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
    open_mapping = '<c-\\>',
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
        local opt = { noremap = true, silent = true }
        -- q / <leader>tg 关闭 terminal
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<CMD>close<CR>', opt)
        vim.api.nvim_buf_set_keymap(term.bufnr, 'n', '<A-g>', '<CMD>close<CR>', opt)
        -- ESC 键取消，留给lazygit
        if vim.fn.mapcheck('<Esc>', 't') ~= '' then
            vim.api.nvim_del_keymap('t', '<Esc>')
        end
    end,
    on_close = function(_)
        -- 添加回来
        local opt = { noremap = true, silent = true }
        vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opt)
    end,
})

local terms = {}

function _G.term_toggle(style)
    local number = vim.v.count
    if terms[number] == nil then
        terms[number] = Terminal:new({})
    end
    terms[number].direction = style
    terms[number].id = number
    terms[number]:toggle()
end

function _G.lazygit_toggle()
    lazygit:toggle()
end

local mode = { 'n', 'i', 't' }

keymap(mode, keys.lazygit_toggle, '<CMD>lua lazygit_toggle()<CR>')
keymap(mode, keys.float_toggle, '<CMD>lua term_toggle([[float]])<CR>')
keymap(mode, keys.botton_toggle, '<CMD>lua term_toggle([[horizontal]])<CR>')
keymap('t', keys.term_quit, '<C-\\><C-n>')
