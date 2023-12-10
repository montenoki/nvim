local uConfig = require('uConfig')
local keys = uConfig.keys

local opt = { noremap = true, silent = true }
-- local opts_remap = { remap = true, silent = true }
local opts_expr = { expr = true, silent = true }

local normal_mode = 'n'
-- local insert_mode = 'i'
local visual_mode = 'v'
local visual_block_mode = 'x'
-- local term_mode = 't'
-- local command_mode = 'c'
local n_v_mode = { 'n', 'v' }
-- local c_mode = { 'c' }

local pluginKeys = {}

----- Neovim Keybinds Settings -----
------------------------------------

-- swap g_ and $
keymap(n_v_mode, '$', 'g_')
keymap(n_v_mode, 'g_', '$')

-- magic search
if uConfig.enable.magic_search then
    keymap(n_v_mode, '/', '/\\v', { remap = false, silent = false })
else
    keymap(n_v_mode, '/', '/', { remap = false, silent = false })
end

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

----- Neovim Keybindings -----
------------------------------

-- Leader Key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- scroll
keymap(n_v_mode, keys.n_v_scroll_up_with_cursor, '4k')
keymap(n_v_mode, keys.n_v_scroll_down_with_cursor, '4j')

keymap(normal_mode, keys.n_v_scroll_up_without_cursor, '4<C-y>')
keymap(normal_mode, keys.n_v_scroll_down_without_cursor, '4<C-e>')

keymap(normal_mode, '<CR>', 'viw<C-1>', opt)

-- windows
if keys.s_windows ~= nil and keys.s_windows.enable then
    local skey = keys.s_windows
    keymap('n', 's', '') -- Turn off 's'

    keymap('n', skey.split_vertically, ':vsp<CR>')
    keymap('n', skey.split_horizontally, ':sp<CR>')
    keymap('n', skey.close, '<C-w>c')
    keymap('n', skey.close_others, '<C-w>o')

    -- Jump Focus
    keymap('n', skey.jump_left, '<C-w>h')
    keymap('n', skey.jump_down, '<C-w>j')
    keymap('n', skey.jump_up, '<C-w>k')
    keymap('n', skey.jump_right, '<C-w>l')

    -- Window Size
    keymap('n', skey.width_decrease, ':vertical resize -10<CR>')
    keymap('n', skey.width_increase, ':vertical resize +10<CR>')
    keymap('n', skey.height_decrease, ':horizontal resize -10<CR>')
    keymap('n', skey.height_increase, ':horizontal resize +10<CR>')
    keymap('n', skey.size_equal, '<C-w>=')
end

-- Tabs
keymap(normal_mode, keys.new_tab, '<CMD>tabnew<CR>')

-- if keys.s_tab ~= nil then
--     local tkey = keys.s_tab
--     keymap('n', tkey.split, '<CMD>tab split<CR>')
--     keymap('n', tkey.close, '<CMD>tabclose<CR>')
--     keymap('n', tkey.next, '<CMD>tabnext<CR>')
--     keymap('n', tkey.prev, '<CMD>tabprev<CR>')
--     keymap('n', tkey.first, '<CMD>tabfirst<CR>')
--     keymap('n', tkey.last, '<CMD>tablast<CR>')
-- end

----- Plugin Keybindings -----
------------------------------

pluginKeys.mapLSP = function(mapbuf)
    mapbuf('n', keys.lsp.declaration, vim.lsp.buf.declaration)
    mapbuf('n', keys.lsp.definition, function()
        require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
    end)
    mapbuf('n', keys.lsp.references, function()
        require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())
    end)
    mapbuf('n', keys.lsp.hover, '<CMD>Lspsaga hover_doc<CR>')
    mapbuf('n', keys.lsp.show_buf_diagnostics, '<CMD>Lspsaga show_buf_diagnostics<CR>')

    mapbuf('n', keys.lsp.code_action, '<CMD>Lspsaga code_action<CR>')
    mapbuf('n', keys.lsp.format, function()
        vim.lsp.buf.format({ async = true })
    end)
    mapbuf('n', keys.lsp.rename, '<CMD>Lspsaga rename<CR>')
    mapbuf('n', keys.lsp.type_definition, vim.lsp.buf.type_definition)

    mapbuf('n', keys.lsp.add_workspace_folder, vim.lsp.buf.add_workspace_folder)
    mapbuf('n', keys.lsp.remove_workspace_folder, vim.lsp.buf.remove_workspace_folder)
    mapbuf('n', keys.lsp.list_workspace_folders, function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
end

return pluginKeys
