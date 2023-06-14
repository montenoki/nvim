local uConfig = require('uConfig')
local keys = uConfig.keys

local map = vim.api.nvim_set_keymap
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

----- Neovim Keybindings -----
------------------------------

-- Leader Key
vim.g.mapleader = keys.leader_key
vim.g.maplocalleader = keys.leader_key

-- scoll
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

    -- Move Focus
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
    mapbuf('n', keys.lsp.hover, vim.lsp.buf.hover)

    mapbuf('n', keys.lsp.code_action, vim.lsp.buf.code_action)
    mapbuf('n', keys.lsp.format, function()
        vim.lsp.buf.format({ async = true })
    end)
    mapbuf('n', keys.lsp.rename, vim.lsp.buf.rename)
    mapbuf('n', keys.lsp.type_definition, vim.lsp.buf.type_definition)

    mapbuf('n', keys.lsp.add_workspace_folder, vim.lsp.buf.add_workspace_folder)
    mapbuf('n', keys.lsp.remove_workspace_folder, vim.lsp.buf.remove_workspace_folder)
    mapbuf('n', keys.lsp.list_workspace_folders, function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
end

-- which-key
keymap(normal_mode, keys.which_key.toggle, '<cmd>WhichKey<CR>')

-- hop
keymap('', keys.hop.toggle, '<cmd>HopAnywhere<CR>')

-- -- DAP
-- -- nvim-dap
local dap = uConfig.keys.dap
pluginKeys.mapDAP = function()
    -- start
    keymap('n', dap.toggle, '<Cmd>lua require("dapui").toggle()<CR>')
    keymap('n', dap.run, ":lua require('osv').run_this()<CR>")
    -- set breakpoint
    keymap('n', dap.breakpoint_toggle, ":lua require('dap').toggle_breakpoint()<CR>")
    keymap('n', dap.breakpoint_clear, ":lua require('dap').clear_breakpoints()<CR>")
    -- continue
    keymap('n', dap.continue, ":lua require('dap').continue()<CR>")
    --  stepOver, stepOut, stepInto
    keymap('n', dap.step_into, ":lua require'dap'.step_into()<CR>")
    keymap('n', dap.step_over, ":lua require'dap'.step_over()<CR>")
    keymap('n', dap.step_out, ":lua require'dap'.step_out()<CR>")
    keymap('n', dap.restart, ":lua require'dap.restart()<CR>")

    keymap('n', dap.open_info, ":lua require'dapui'.eval()<cr>")
    -- Stop
    keymap(
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

    map('n', uConfig.keys.gitsigns.diffthis, function()
        gs.diffthis('~')
    end)
end

return pluginKeys
