local map = vim.keymap.set
local lazyvim = require('lazyvim')
local keymaps = require('keymaps')
local toggle = require('util.toggle')
-- =============================================================================
-- Set leader key
-- =============================================================================
vim.g.mapleader = keymaps.leader_key

-- =============================================================================
-- Better keybindings
-- =============================================================================
-- better up/down for wrapped lines
map({ 'n', 'x' }, '<DOWN>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down ignore wrapped', expr = true})
map({ 'n', 'x' }, '<UP>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up ignore wrapped', expr = true})
-- swap g_ and $
map({ 'n', 'v' }, '$', 'g_', { desc = 'Goto last non-blank char' })
map({ 'n', 'v' }, 'g_', '$', { desc = 'Goto the end of line' })
-- better indenting
map('v', '<', '<gv', { desc = 'Increase indent', remap = true })
map('v', '>', '>gv', { desc = 'Decrease indent', remap = true })
-- do not copy after paste in visual mode
map('v', 'p', '"_dP')

-- =============================================================================
-- Disable unuse keybindings
-- =============================================================================
-- turn off 'Ctrl+z'
map({ 'n', 'i', 'v' }, '<C-z>', '<NOP>')

-- turn off 's' for surround
map({ 'n', 'v' }, 's', '<NOP>')
map({ 'n', 'v' }, 'ss', '<NOP>')

-- =============================================================================
-- Other useful keybindings
-- =============================================================================
-- Clear search with <ESC>
map({ 'i', 'n' }, '<ESC>', '<CMD>noh<CR><ESC>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- =============================================================================
-- My keybindings
-- =============================================================================
-- Move to window using the <CTRL> hjkl keys
map('n', keymaps.window.goto_left, '<C-w>h', { desc = 'Go to left window' })
map('n', keymaps.window.goto_lower, '<C-w>j', { desc = 'Go to lower window' })
map('n', keymaps.window.goto_upper, '<C-w>k', { desc = 'Go to upper window' })
map('n', keymaps.window.goto_right, '<C-w>l', { desc = 'Go to right window' })

-- Resize window using <CTRL> arrow keys
map('n', keymaps.window.inc_height, '<CMD>resize +2<CR>', { desc = 'Increase window height' })
map('n', keymaps.window.dec_height, '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
map('n', keymaps.window.inc_width, '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', keymaps.window.dec_width, '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })
--
-- Windows
map('n', keymaps.window.close, '<C-W>c', { desc = 'Close window', remap = true })
map('n', keymaps.window.close_other, '<C-W>o', { desc = 'Close all other windows', remap = true })
map('n', keymaps.window.split_below, '<C-W>s', { desc = 'Split window below', remap = true })
map('n', keymaps.window.split_right, '<C-W>v', { desc = 'Split window right', remap = true })
map('n', keymaps.window.eq_size, '<C-w>=', { desc = 'Equally high and wide', remap = true })
map('n', keymaps.window.init_inc_selection, 'viw<C-1>', { desc = 'Init Increment selection', remap = true })

-- Move Lines
map('n', keymaps.line.move_down, '<CMD>m .+1<CR>==', { desc = 'Move Line down'})
map('n', keymaps.line.move_up, '<CMD>m .-2<CR>==', { desc = 'Move Line up'})
map('i', keymaps.line.move_down, '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move Line down'})
map('i', keymaps.line.move_up, '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move Line up'})
map('v', keymaps.line.move_down, ":m '>+1<CR>gv=gv", { desc = 'Move Line down'})
map('v', keymaps.line.move_up, ":m '<-2<CR>gv=gv", { desc = 'Move Line up'})

-- Tab
map('n', keymaps.tab.new, '<CMD>tabnew<CR>', { desc = 'New Tab' })
map('n', keymaps.tab.close, '<CMD>tabclose<CR>', { desc = 'Close Tab' })
map('n', keymaps.tab.prev, '<CMD>tabprev<CR>', { desc = 'Previous Tab' })
map('n', keymaps.tab.next, '<CMD>tabnext<CR>', { desc = 'Next Tab' })

-- Diagnostic
---@param next boolean
---@param severity string | integer | nil
---@return function
local function diagnosticGoto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

map('n', keymaps.diagnostic.show_line_diag, vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', keymaps.diagnostic.next_diag, diagnosticGoto(true), { desc = 'Next Diagnostic' })
map('n', keymaps.diagnostic.prev_diag, diagnosticGoto(false), { desc = 'Prev Diagnostic' })
map('n', keymaps.diagnostic.next_error, diagnosticGoto(true, 'ERROR'), { desc = 'Next Error' })
map('n', keymaps.diagnostic.prev_error, diagnosticGoto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', keymaps.diagnostic.next_warn, diagnosticGoto(true, 'WARN'), { desc = 'Next Warning' })
map('n', keymaps.diagnostic.prev_warn, diagnosticGoto(false, 'WARN'), { desc = 'Prev Warning' })

-- toggle options
map('n', keymaps.toggle.spelling, function() lazyvim.toggle('spell') end, { desc = 'Toggle Spelling' })
map('n', keymaps.toggle.line_numbers, function()
  lazyvim.toggle.number()
end, { desc = 'Toggle Line Numbers' })
map('n', keymaps.toggle.relative_numbers, function()
  lazyvim.toggle('relativenumber')
end, { desc = 'Toggle Relative Line Numbers' })
map('n', keymaps.toggle.diagnostic, function()
  lazyvim.toggle.diagnostics()
end, { desc = 'Toggle Diagnostics' })
map('n', keymaps.toggle.wrap, function()
  toggle.wrap()
end, { desc = 'Toggle wrap' })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map('n', keymaps.toggle.conceal, function()
  lazyvim.toggle('conceallevel', false, { 0, conceallevel })
end, { desc = 'Toggle Conceal' })

if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map('n', keymaps.toggle.inlay_hints, function()
    lazyvim.toggle.inlay_hints()
  end, { desc = 'Toggle Inlay Hints' })
end

map('n', keymaps.toggle.treesitter, function()
  toggle.treesitter()
end, { desc = 'Toggle Treesitter Highlight' })

-- highlights info under cursor
map('n', keymaps.toggle.show_hl_info, vim.show_pos, { desc = 'Show highlights info' })
