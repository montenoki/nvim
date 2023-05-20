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
if uConfig.enable_magic_search then
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
if keys.s_tab ~= nil then
    local tkey = keys.s_tab
    keymap('n', tkey.split, '<CMD>tab split<CR>')
    keymap('n', tkey.close, '<CMD>tabclose<CR>')
    keymap('n', tkey.next, '<CMD>tabnext<CR>')
    keymap('n', tkey.prev, '<CMD>tabprev<CR>')
    keymap('n', tkey.first, '<CMD>tabfirst<CR>')
    keymap('n', tkey.last, '<CMD>tablast<CR>')
end

----- Plugin Keybindings -----
------------------------------

local lsp = uConfig.lsp
pluginKeys.mapLSP = function(mapbuf)
    mapbuf('n', lsp.declaration, vim.lsp.buf.declaration)
    mapbuf('n', lsp.definition, function()
        require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
    end)
    mapbuf('n', lsp.references, function()
        require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy())
    end)
    mapbuf('n', lsp.hover, vim.lsp.buf.hover)

    mapbuf('n', lsp.code_action, vim.lsp.buf.code_action)
    mapbuf('n', lsp.format, function()
        vim.lsp.buf.format({ async = true })
    end)
    mapbuf('n', lsp.rename, vim.lsp.buf.rename)
    mapbuf('n', lsp.type_definition, vim.lsp.buf.type_definition)

    mapbuf('n', lsp.add_workspace_folder, vim.lsp.buf.add_workspace_folder)
    mapbuf('n', lsp.remove_workspace_folder, vim.lsp.buf.remove_workspace_folder)
    mapbuf('n', lsp.list_workspace_folders, function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end)
end

-- TODO:
-- -- Terminal
-- -- Open Terminal: float
-- keymap('n', '<leader>tt', '<Cmd>lua floatterm_toggle()<CR>')
-- -- Open Terminal: botton
-- keymap({ 'n', 'i' }, '<A-\\>', '<Cmd>lua bottonterm_toggle()<CR>')
-- -- Open Terminal: lazygit
-- keymap('n', '<leader>tg', '<Cmd>lua lazygit_toggle()<CR>')
-- -- Exit
-- keymap('t', '<Esc>', '<C-\\><C-n>')
--
-- -- LSP
--
-- -- DAP
-- -- nvim-dap
-- local dap = uConfig.dap
-- pluginKeys.mapDAP = function()
--     -- start
--     map('n', dap.toggle, ':lua require("dapui").toggle()<CR>', opt)
--     map('n', dap.run, ":lua require('osv').run_this()<CR>", opt)
--     -- set breakpoint
--     map('n', dap.breakpoint_toggle, ":lua require('dap').toggle_breakpoint()<CR>", opt)
--     map('n', dap.breakpoint_clear, ":lua require('dap').clear_breakpoints()<CR>", opt)
--     -- continue
--     map('n', dap.continue, ":lua require('dap').continue()<CR>", opt)
--     --  stepOver, stepOut, stepInto
--     map('n', dap.step_into, ":lua require'dap'.step_into()<CR>", opt)
--     map('n', dap.step_over, ":lua require'dap'.step_over()<CR>", opt)
--     map('n', dap.step_out, ":lua require'dap'.step_out()<CR>", opt)
--     map('n', dap.restart, ":lua require'dap.restart()<CR>", opt)
--
--     map('n', dap.open_info, ":lua require'dapui'.eval()<CR>", opt)
--     -- Stop
--     map(
--         'n',
--         dap.stop,
--         ":lua require'dap'.close()<CR>"
--             .. ":lua require'dap'.terminate()<CR>"
--             .. ":lua require'dap.repl'.close()<CR>"
--             .. ":lua require'dapui'.close()<CR>"
--             .. ":lua require('dap').clear_breakpoints()<CR>"
--             .. '<C-w>o<CR>',
--         opt
--     )
-- end

-- -- gitsigns
-- pluginKeys.gitsigns_on_attach = function(bufnr)
--     local gs = package.loaded.gitsigns
--
--     local function map(mode, l, r, opts)
--         opts = opts or {}
--         opts.buffer = bufnr
--         vim.keymap.set(mode, l, r, opts)
--     end
--
--     -- Navigation
--     map('n', '<leader>gj', function()
--         if vim.wo.diff then
--             return ']c'
--         end
--         vim.schedule(function()
--             gs.next_hunk()
--         end)
--         return '<Ignore>'
--     end, {
--         expr = true,
--     })
--
--     map('n', '<leader>gk', function()
--         if vim.wo.diff then
--             return '[c'
--         end
--         vim.schedule(function()
--             gs.prev_hunk()
--         end)
--         return '<Ignore>'
--     end, {
--         expr = true,
--     })
--
--     map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>')
--     map('n', '<leader>gS', gs.stage_buffer)
--     map('n', '<leader>gu', gs.undo_stage_hunk)
--     map({ 'n', 'v' }, '<leader>gr', ':Gitsigns reset_hunk<CR>')
--     map('n', '<leader>gR', gs.reset_buffer)
--     map('n', '<leader>gp', gs.preview_hunk)
--     map('n', '<leader>gb', function()
--         gs.blame_line({
--             full = true,
--         })
--     end)
--     map('n', '<leader>gd', gs.diffthis)
--     map('n', '<leader>gD', function()
--         gs.diffthis('~')
--     end)
--     -- toggle
--     map('n', '<leader>gtd', gs.toggle_deleted)
--     map('n', '<leader>gtb', gs.toggle_current_line_blame)
--     -- Text object
--     map({ 'o', 'x' }, 'ig', ':<C-U>Gitsigns select_hunk<CR>')
-- end

return pluginKeys
