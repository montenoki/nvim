local map = vim.keymap.set
local Lazyvim = require('lazyvim')
local Keys = require('keymaps')

-- better up/down for wrapped lines
map({ 'n', 'x' }, '<DOWN>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down ignore wrapped', expr = true, silent = true })
map({ 'n', 'x' }, '<UP>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up ignore wrapped', expr = true, silent = true })
-- swap g_ and $
map({ 'n', 'v' }, '$', 'g_', { desc = 'Goto last non-blank char' })
map({ 'n', 'v' }, 'g_', '$', { desc = 'Goto the end of line' })
-- better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')
-- do not copy after paste in visual mode
map('v', 'p', '"_dP')
-- turn off 'Ctrl+z'
map({ 'n', 'i', 'v' }, '<C-z>', '')
-- Clear search with <ESC>
map( { 'i', 'n' }, '<ESC>', '<CMD>noh<CR><ESC>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map( 'n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map( 'x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map( 'o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map( 'n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map( 'x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map( 'o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Add undo break-points
map('i', ',', ',<C-g>u')
map('i', '.', '.<C-g>u')
map('i', ';', ';<C-g>u')

-- Move to window using the <CTRL> hjkl keys
map('n', Keys.window.goto_left, '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', Keys.window.goto_lower, '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', Keys.window.goto_upper, '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', Keys.window.goto_right, '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize window using <CTRL> arrow keys
map('n', Keys.window.inc_height, '<CMD>resize +2<CR>', { desc = 'Increase window height' })
map('n', Keys.window.dec_height, '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
map('n', Keys.window.inc_width, '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', Keys.window.dec_width, '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })
--
-- Windows
map('n', Keys.window.close, '<C-W>c', { desc = 'Close window', remap = true })
map('n', Keys.window.close_other, '<C-W>o', { desc = 'Close all other windows', remap = true })
map('n', Keys.window.split_below, '<C-W>s', { desc = 'Split window below', remap = true })
map('n', Keys.window.split_right, '<C-W>v', { desc = 'Split window right', remap = true })
map('n', Keys.window.eq_size, '<C-w>=', { desc = 'Equally high and wide', remap = true })
map('n', Keys.window.init_inc_selection, 'viw<C-1>', { desc = 'Init Increment selection', remap = true })

-- Move Lines
map('n', Keys.line.move_down, '<CMD>m .+1<CR>==', { desc = 'Move Line down' })
map('n', Keys.line.move_up, '<CMD>m .-2<CR>==', { desc = 'Move Line up' })
map('i', Keys.line.move_down, '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move Line down' })
map('i', Keys.line.move_up, '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move Line up' })
map('v', Keys.line.move_down, ":m '>+1<CR>gv=gv", { desc = 'Move Line down' })
map('v', Keys.line.move_up, ":m '<-2<CR>gv=gv", { desc = 'Move Line up' })

-- Move Tab
map('n', '<LEADER>tn', '<CMD>tabnew<CR>', { desc = 'New Tab' })
map('n', '<LEADER>tc', '<CMD>tabclose<CR>', { desc = 'Close Tab' })
map('n', '<C-t>', '<CMD>tabnew<CR>', { desc = 'New Tab' })
map('n', '<C-]>', '<CMD>tabnext<CR>', { desc = 'Next Tab' })
map('n', '<C-[>', '<CMD>tabprev<CR>', { desc = 'Previous Tab' })
map('n', '<LEADER>t]', '<CMD>tabnext<CR>', { desc = 'Next Tab' })
map('n', '<LEADER>t[', '<CMD>tabprev<CR>', { desc = 'Previous Tab' })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map('n', '<LEADER>xd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })

-- stylua: ignore start
-- toggle options
map("n", "<LEADER>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<LEADER>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<LEADER>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<LEADER>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<LEADER>uS", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<LEADER>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<LEADER>uT", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
    Util.warn('Disabled Treesitter Highlight', { title = 'Option' })
  else
    vim.treesitter.start()
    Util.info('Enabled Treesitter Highlight', { title = 'Option' })
  end
end, { desc = "Toggle Treesitter Highlight" })

-- highlights under cursor
map("n", "<LEADER>ui", vim.show_pos, { desc = "Inspect Pos" })

local M = {}
-- TODO[2023/12/23] configure this later.
M.scroll_right = '<C-r>'
M.scroll_left = '<C-l>'
M.scroll_up = '<C-u>'
M.scroll_down = '<C-d>'
return M
