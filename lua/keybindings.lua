local uConfig = require('uConfig')
local lite_mode = uConfig.lite_mode
local keys = uConfig.keys

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

local opts_remap = { remap = true, silent = true }
local opts_expr = { expr = true, silent = true }

local normal_mode = 'n'
local insert_mode = 'i'
local visual_mode = 'v'
local visual_block_mode = 'x'
local term_mode = 't'
local command_mode = 'c'
local n_v_mode = { 'n', 'v' }
local c_mode = { 'c' }


----- Neovim Keybindings -----
------------------------------

-- Leader Key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- scoll
keymap(n_v_mode, keys.n_v_scroll_up_small, '4k')
keymap(n_v_mode, keys.n_v_scroll_down_small, '4j')

keymap(n_v_mode, keys.n_v_scroll_up_large, '8<C-y>')
keymap(n_v_mode, keys.n_v_scroll_down_large, '8<C-e>')

keymap(c_mode, keys.c_next_item, '<C-n>', opts_remap)
keymap(c_mode, keys.c_prev_item, '<C-n>', opts_remap)


-- windows
if keys.s_windows ~= nil and keys.s_windows.enable then
    local skey = keys.s_windows
    keymap('n', 's', '') -- Turn off 's'

    keymap('n', skey.split_vertically, ':vsp<CR>')
    keymap('n', skey.split_horizontally, ':sp<CR>')
    keymap('n', skey.close, '<C-w>c')
    keymap('n', skey.close_others, '<C-w>o')

    -- Move Focus
    keymap('n', skey.jump_left, '<C-w>h')
    keymap('n', skey.jump_down, '<C-w>j')
    keymap('n', skey.jump_up, '<C-w>k')
    keymap('n', skey.jump_right, '<C-w>l')

    -- Window Size
    keymap('n', skey.width_decrease, ':vertical resize -10<CR>')
    keymap('n', skey.width_increase, ':vertical resize +10<CR>')
    keymap('n', skey.height_decrease, ':vertical resize -10<CR>')
    keymap('n', skey.height_increase, ':vertical resize +10<CR>')
    keymap('n', skey.size_equal, '<C-w>=')
end

-- Tabs
if keys.s_tab ~= nil then
    local tkey = keys.s_tab
    keymap('n', tkey.split, '<CMD>tab split<CR>')
    keymap('n', tkey.close, '<CMD>tabclose<CR>')
    keymap('n', tkey.next, '<CMD>tabnext<CR>')
    keymap('n', tkey.prev, '<CMD>tabprev<CR>')
    keymap('n', tkey.first, '<CMD>tabfirst<CR>')
    keymap('n', tkey.last, '<CMD>tablast<CR>')
end


----- Neovim Keybinds Settings -----
------------------------------------

-- swap g_ and $
keymap(n_v_mode, '$', 'g_')
keymap(n_v_mode, 'g_', '$')

-- magic search
if uConfig.enable_magic_search then
    keymap(n_v_mode, '/', '/\\v', { remap = false, silent =false })
else
    keymap(n_v_mode, '/', '/', { remap = false, silent =false })
end

-- wrap line movement
keymap(normal_mode, 'j', "v:count == 0 ? 'gj' : 'j'", opts_expr)
keymap(normal_mode, 'k', "v:count == 0 ? 'gk' : 'k'", opts_expr)

-- visual mode indent
keymap(visual_mode, '<', '<gv')
keymap(visual_mode, '>', '>gv')

-- move select line
keymap(visual_block_mode, 'K', ":move '<-2<CR>gv-gv", opt)
keymap(visual_block_mode, 'J', ":move '>+1<CR>gv-gv", opt)

-- turn off 'Ctrl+z'
keymap({ 'n', 'i', 'v' }, '<C-z>', '')

-- do not copy after paste in visual mode
keymap(visual_mode, 'p', '"_dP')


----- Plugin Keybindings -----
------------------------------

-- Terminal
-- Open Terminal: float
keymap('n', '<leader>tt', '<Cmd>lua floatterm_toggle()<CR>')
-- Open Terminal: botton
keymap({ 'n', 'i' }, '<A-\\>', '<Cmd>lua bottonterm_toggle()<CR>')
-- Open Terminal: lazygit
keymap('n', '<leader>tg', '<Cmd>lua lazygit_toggle()<CR>')
-- Exit
keymap('t', '<Esc>', '<C-\\><C-n>')
