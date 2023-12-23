local map = vim.keymap.set
local Util = require('util')

-- better up/down for wrapped lines
map({ 'n', 'x' }, '<DOWN>', "v:count == 0 ? 'gj' : 'j'", { desc = "Down ignore wrapped", expr = true, silent = true })
map({ 'n', 'x' }, '<UP>', "v:count == 0 ? 'gk' : 'k'", { desc = "Up ignore wrapped", expr = true, silent = true })
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
map({ 'i', 'n' }, '<ESC>', '<CMD>noh<CR><ESC>', { desc = 'Escape and clear hlsearch' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<C-g>u")
map("i", ".", ".<C-g>u")
map("i", ";", ";<C-g>u")

-- Move to window using the <CTRL> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize window using <CTRL> arrow keys
map('n', '<C-UP>', '<CMD>resize +2<CR>', { desc = 'Increase window height' })
map('n', '<C-DOWN>', '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
map('n', '<C-LEFT>', '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
map('n', '<C-RIGHT>', '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })

-- Move Lines
map('n', '<A-j>', '<CMD>m .+1<CR>==', { desc = 'Move down' })
map('n', '<A-k>', '<CMD>m .-2<CR>==', { desc = 'Move up' })
map('i', '<A-j>', '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move up' })

-- Move Tab
map('n', '<LEADER>tn', '<CMD>tabnew<CR>', { desc = "New Tab" })
map('n', '<C-t>', '<CMD>tabnew<CR>', { desc = "New Tab" })
map("n", "<C-]>", "<CMD>tabnext<CR>", { desc = "Next Tab" })
map("n", "<C-[>", "<CMD>tabprev<CR>", { desc = "Previous Tab" })

-- Windows
map('n', '<LEADER>wc', '<C-W>c', { desc = 'Close window', remap = true })
map('n', '<LEADER>wo', '<C-W>o', { desc = 'Close all other windows', remap = true })
map('n', '<LEADER>-', '<C-W>s', { desc = 'Split window below', remap = true })
map('n', '<LEADER>|', '<C-W>v', { desc = 'Split window right', remap = true })

map('n', '<CR>', 'viw<C-1>', { desc = 'Init Increment selection', remap = true })

-- Diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<LEADER>xd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

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
