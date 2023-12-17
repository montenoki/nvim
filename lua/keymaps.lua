local map = vim.keymap.set
local Util = require('util')

-- better up/down for wrapped lines
map({ 'n', 'x' }, '<down>', "v:count == 0 ? 'gj' : 'j'", { desc = "Down ignore wrapped", expr = true, silent = true })
map({ 'n', 'x' }, '<up>', "v:count == 0 ? 'gk' : 'k'", { desc = "Up ignore wrapped", expr = true, silent = true })
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
-- Clear search with <esc>
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Move to window using the <ctrl> hjkl keys
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window', remap = true })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window', remap = true })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window', remap = true })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window', remap = true })

-- Resize window using <ctrl> arrow keys
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines
map('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move down' })
map('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move up' })
map('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move down' })
map('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move up' })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move down' })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move up' })

-- Move buffer
map("n", "[b", "<cmd>bnext<cr>", { desc = "Next Tab" })
map("n", "]b", "<cmd>bprevious<cr>", { desc = "Previous Tab" })


-- windows
map('n', '<leader>wc', '<C-W>c', { desc = 'Close window', remap = true })
map('n', '<leader>-', '<C-W>s', { desc = 'Split window below', remap = true })
map('n', '<leader>|', '<C-W>v', { desc = 'Split window right', remap = true })

map('n', '<cr>', 'viw<c-1>', { desc = 'Init Increment selection', remap = true })


-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start
-- toggle options
map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
map("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
map("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uS", function() Util.toggle("conceallevel", false, { 0, conceallevel }) end,
  { desc = "Toggle Conceal" })
if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
  map("n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
end
map("n", "<leader>uT", function()
  if vim.b.ts_highlight then
    vim.treesitter.stop()
            Util.warn('Disabled Treesitter Highlight', { title = 'Option' })
  else
    vim.treesitter.start()
            Util.info('Enabled Treesitter Highlight', { title = 'Option' })
  end
end, { desc = "Toggle Treesitter Highlight" })

-- -- lazygit
-- map("n", "<leader>gg",
--   function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end,
--   { desc = "Lazygit (root dir)" })
-- map("n", "<leader>gG", function() Util.terminal({ "lazygit" }, { esc_esc = false, ctrl_hjkl = false }) end,
--   { desc = "Lazygit (cwd)" })

-- -- highlights under cursor
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- -- floating terminal
-- local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
-- map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- -- Terminal Mappings
-- map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

