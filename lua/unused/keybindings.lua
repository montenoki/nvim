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

-- magic search
if uConfig.enable.magic_search then
    keymap(n_v_mode, '/', '/\\v', { remap = false, silent = false })
else
    keymap(n_v_mode, '/', '/', { remap = false, silent = false })
end




----- Neovim Keybindings -----
------------------------------
-- scroll
keymap(n_v_mode, keys.n_v_scroll_up_with_cursor, '4k')
keymap(n_v_mode, keys.n_v_scroll_down_with_cursor, '4j')

keymap(normal_mode, keys.n_v_scroll_up_without_cursor, '4<C-y>')
keymap(normal_mode, keys.n_v_scroll_down_without_cursor, '4<C-e>')

keymap(normal_mode, '<CR>', 'viw<C-1>', opt)

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
    -- mapbuf('n', keys.lsp.declaration, vim.lsp.buf.declaration)
    -- mapbuf('n', keys.lsp.definition, function()
    --     require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
    -- end)
    -- mapbuf('n', keys.lsp.references, function()
    --     require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown())
    -- end)
    -- mapbuf('n', keys.lsp.hover, '<CMD>Lspsaga hover_doc<CR>')
    mapbuf('n', keys.lsp.show_buf_diagnostics, '<CMD>Lspsaga show_buf_diagnostics<CR>')

    -- mapbuf('n', keys.lsp.code_action, '<CMD>Lspsaga code_action<CR>')
    -- mapbuf('n', keys.lsp.format, function()
    --     vim.lsp.buf.format({ async = true })
    -- end)
    -- mapbuf('n', keys.lsp.rename, '<CMD>Lspsaga rename<CR>')
    mapbuf('n', keys.lsp.type_definition, vim.lsp.buf.type_definition)

    mapbuf('n', keys.lsp.add_workspace_folder, vim.lsp.buf.add_workspace_folder)
    mapbuf('n', keys.lsp.remove_workspace_folder, vim.lsp.buf.remove_workspace_folder)
    mapbuf('n', keys.lsp.list_workspace_folders, function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
end

return pluginKeys
