-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local uConfig = require('uConfig')
local keys = uConfig.keys

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

local opts_remap = { remap = true, silent = true }
local opts_expr = { expr = true, silent = true }

------------- Neovim Keybindings -------------
-- Leader Key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- 命令行下 Ctrl+j/k  上一个下一个
keymap('c', keys.c_next_item, '<C-n>', opts_remap)
keymap('c', keys.c_prev_item, '<C-p>', opts_remap)

-- g_と$を交換
keymap({ 'n', 'v' }, '$', 'g_')
keymap({ 'n', 'v' }, 'g_', '$')

-- 垂直スクロール
keymap({ 'n', 'v' }, keys.n_v_scroll_down_small, '4j') -- 4行
keymap({ 'n', 'v' }, keys.n_v_scroll_up_small, '4k')

keymap({ 'n', 'v' }, keys.n_v_scroll_up_large, '8<C-y>') -- 8行, without move cursor
keymap({ 'n', 'v' }, keys.n_v_scroll_down_large, '8<C-e>')

-- magic search
if uConfig.enable_magic_search then
    keymap({ 'n', 'v' }, '/', '/\\v', { remap = false, silent = false })
else
    keymap({ 'n', 'v' }, '/', '/', { remap = false, silent = false })
end

-- 折り返し行移動
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", opts_expr)
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", opts_expr)

-- vモード インデント移動
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- 選択した行を移動する
keymap('x', 'J', ":move '>+1<CR>gv-gv", opt)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opt)

-- デフォルトの Ctrl + z コマンド無効化
keymap({ 'n', 'i', 'v' }, '<C-z>', '')

-- vモードでペスト後コピーしない
keymap('x', 'p', '"_dP')

-- fold
keymap({ 'n', 'v' }, keys.fold.open, ':foldopen<CR>')
keymap({ 'n', 'v' }, keys.fold.close, ':foldclose<CR>')

-- windows 管理
if keys.s_windows ~= nil and keys.s_windows.enable then
    local skey = keys.s_windows

    keymap('n', 's', '') -- デフォルトの s コマンド無効化
    keymap('n', skey.split_vertically, ':vsp<CR>') -- 縦分割
    keymap('n', skey.split_horizontally, ':sp<CR>') -- 横分割
    keymap('n', skey.close, '<C-w>c') -- 当 window 閉じる
    keymap('n', skey.close_others, '<C-w>o') -- 当 window 以外を閉じる

    -- windows 間の Focus 移動
    keymap('n', skey.jump_left, '<C-w>h')
    keymap('n', skey.jump_down, '<C-w>j')
    keymap('n', skey.jump_up, '<C-w>k')
    keymap('n', skey.jump_right, '<C-w>l')

    -- 大きさ調整
    keymap('n', skey.width_decrease, ':vertical resize -10<CR>')
    keymap('n', skey.width_increase, ':vertical resize +10<CR>')
    keymap('n', skey.height_decrease, ':vertical resize -10<CR>')
    keymap('n', skey.height_increase, ':vertical resize +10<CR>')
    keymap('n', skey.size_equal, '<C-w>=') -- 等幅
end

if keys.s_tab ~= nil then
    local tkey = keys.s_tab
    keymap('n', tkey.split, '<CMD>tab split<CR>')
    keymap('n', tkey.close, '<CMD>tabclose<CR>')
    keymap('n', tkey.next, '<CMD>tabnext<CR>')
    keymap('n', tkey.prev, '<CMD>tabprev<CR>')
    keymap('n', tkey.first, '<CMD>tabfirst<CR>')
    keymap('n', tkey.last, '<CMD>tablast<CR>')
end

-- Terminal

-- Open Terminal: float
keymap('n', '<leader>tt', '<Cmd>lua floatterm_toggle()<CR>')
-- Open Terminal: botton
keymap({ 'n', 'i' }, '<A-\\>', '<Cmd>lua bottonterm_toggle()<CR>')
-- Open Terminal: lazygit
keymap('n', '<leader>tg', '<Cmd>lua lazygit_toggle()<CR>')
-- Exit
keymap('t', '<Esc>', '<C-\\><C-n>')

------------ Plugin Keybindings -------------
local pluginKeys = {}

-- LSP
local lsp = uConfig.lsp
pluginKeys.mapLSP = function(mapbuf)
    -- rename
    mapbuf('n', lsp.rename, '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- code action
    mapbuf('n', lsp.code_action, '<cmd>lua vim.lsp.buf.code_action()<CR>')
    -- format
    if vim.fn.has('nvim-0.8') == 1 then
        mapbuf('n', lsp.format, '<cmd>lua vim.lsp.buf.format { auync = true } <CR>')
    else
        mapbuf('n', lsp.format, '<cmd>lua vim.lsp.buf.formatting()<CR>')
    end
    -- go series
    mapbuf('n', lsp.definition, function()
        require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
    end)
    mapbuf(
        'n',
        lsp.references,
        "<cmd>lua require'telescope.builtin'.lsp_references(require('telescope.themes').get_ivy())<CR>"
    )
    mapbuf('n', lsp.hover, '<cmd>lua vim.lsp.buf.hover()<CR>')

    mapbuf('n', lsp.open_flow, '<cmd>lua vim.diagnostic.open_float()<CR>')
    mapbuf('n', lsp.goto_next, '<cmd>lua vim.diagnostic.goto_next()<CR>')
    mapbuf('n', lsp.goto_prev, '<cmd>lua vim.diagnostic.goto_prev()<CR>')
end

-- DAP
-- nvim-dap
local dap = uConfig.dap
pluginKeys.mapDAP = function()
    -- 开始
    map('n', dap.toggle, ':lua require("dapui").toggle()<CR>', opt)
    map('n', dap.run, ":lua require('osv').run_this()<CR>", opt)
    -- 设置断点
    map('n', dap.breakpoint_toggle, ":lua require('dap').toggle_breakpoint()<CR>", opt)
    map('n', dap.breakpoint_clear, ":lua require('dap').clear_breakpoints()<CR>", opt)
    -- 继续
    map('n', dap.continue, ":lua require('dap').continue()<CR>", opt)
    --  stepOver, stepOut, stepInto
    map('n', dap.step_into, ":lua require'dap'.step_into()<CR>", opt)
    map('n', dap.step_over, ":lua require'dap'.step_over()<CR>", opt)
    map('n', dap.step_out, ":lua require'dap'.step_out()<CR>", opt)
    map('n', dap.restart, ":lua require'dap.restart()<CR>", opt)
    -- 弹窗
    map('n', dap.open_info, ":lua require'dapui'.eval()<CR>", opt)
    -- Stop
    map(
        'n',
        dap.stop,
        ":lua require'dap'.close()<CR>"
        .. ":lua require'dap'.terminate()<CR>"
        .. ":lua require'dap.repl'.close()<CR>"
        .. ":lua require'dapui'.close()<CR>"
        .. ":lua require('dap').clear_breakpoints()<CR>"
        .. '<C-w>o<CR>',
        opt
    )
end

-- gitsigns
pluginKeys.gitsigns_on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<leader>gj', function()
        if vim.wo.diff then
            return ']c'
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return '<Ignore>'
    end, {
        expr = true,
    })

    map('n', '<leader>gk', function()
        if vim.wo.diff then
            return '[c'
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return '<Ignore>'
    end, {
        expr = true,
    })

    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>')
    map('n', '<leader>gS', gs.stage_buffer)
    map('n', '<leader>gu', gs.undo_stage_hunk)
    map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>gR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk)
    map('n', '<leader>gb', function()
        gs.blame_line({
            full = true,
        })
    end)
    map('n', '<leader>gd', gs.diffthis)
    map('n', '<leader>gD', function()
        gs.diffthis('~')
    end)
    -- toggle
    map('n', '<leader>gtd', gs.toggle_deleted)
    map('n', '<leader>gtb', gs.toggle_current_line_blame)
    -- Text object
    map({ 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
end

-------------- Dashboard
map('n', '<leader>b', ':Dashboard<CR>', opt)

return pluginKeys
