local map = vim.keymap.set
local keymaps = require('keymaps')
-- =============================================================================
-- 添加新的按键映射
-- =============================================================================
vim.g.mapleader = keymaps.leader

-- 移动光标到窗口
map('n', keymaps.window.gotoLeft, '<C-w>h', { desc = 'Go to left window' })
map('n', keymaps.window.gotoLower, '<C-w>j', { desc = 'Go to lower window' })
map('n', keymaps.window.gotoUpper, '<C-w>k', { desc = 'Go to upper window' })
map('n', keymaps.window.gotoRight, '<C-w>l', { desc = 'Go to right window' })
map({ 'n', 'i' }, keymaps.window.gotoLeftCtrl, '<C-w>h', { desc = 'Go to left window' })
map({ 'n', 'i' }, keymaps.window.gotoLowerCtrl, '<C-w>j', { desc = 'Go to lower window' })
map({ 'n', 'i' }, keymaps.window.gotoUpperCtrl, '<C-w>k', { desc = 'Go to upper window' })
map({ 'n', 'i' }, keymaps.window.gotoRightCtrl, '<C-w>l', { desc = 'Go to right window' })

-- 窗口操作
map('n', keymaps.window.close, '<C-W>c', { desc = 'Close window' })
map('n', keymaps.window.closeOther, '<C-W>o', { desc = 'Close all other windows' })
map('n', keymaps.window.splitBelow, '<C-W>s', { desc = 'Split window below' })
map('n', keymaps.window.splitRight, '<C-W>v', { desc = 'Split window right' })
map('n', keymaps.window.resize, '<C-w>=', { desc = 'Resize windows Equally' })

-- 移动行
map('n', keymaps.moveLineDown, '<CMD>m .+1<CR>==', { desc = 'Move Line down' })
map('n', keymaps.moveLineUp, '<CMD>m .-2<CR>==', { desc = 'Move Line up' })
map('i', keymaps.moveLineDown, '<ESC><CMD>m .+1<CR>==gi', { desc = 'Move Line down' })
map('i', keymaps.moveLineUp, '<ESC><CMD>m .-2<CR>==gi', { desc = 'Move Line up' })
map('v', keymaps.moveLineDown, ":m '>+1<CR>gv=gv", { desc = 'Move Line down' })
map('v', keymaps.moveLineUp, ":m '<-2<CR>gv=gv", { desc = 'Move Line up' })

-- Tab
map('n', keymaps.tab.new, '<CMD>tabnew<CR>', { desc = 'New Tab' })
map('n', keymaps.tab.close, '<CMD>tabclose<CR>', { desc = 'Close Tab' })
map('n', keymaps.tab.prev, '<CMD>tabprev<CR>', { desc = 'Previous Tab' })
map('n', keymaps.tab.next, '<CMD>tabnext<CR>', { desc = 'Next Tab' })

-- =============================================================================
-- 修改默认的按键映射
-- =============================================================================

-- 改变上下箭头键的行为
-- 当没有数字前缀时， 向下箭头键会使用 gj，向上箭头键会使用 gk
-- 这会移动到视觉上的上下行，即使这是一个被折叠的长行。
-- 当有数字前缀时，向下箭头键会使用 j，向上箭头键会使用 k
-- 这会移动到文本上的上下行
map({ 'n', 'x' }, '<DOWN>', "v:count == 0 ? 'gj' : 'j'", { desc = 'Down ignore wrapped', expr = true })
map({ 'n', 'x' }, '<UP>', "v:count == 0 ? 'gk' : 'k'", { desc = 'Up ignore wrapped', expr = true })

-- 交换 g_ 和 $
-- 使用 $ 键时，光标停在最后一个非空白字符上，这通常是更有用的位置，特别是在编辑代码时。
-- 如果确实需要移动到包括尾随空白在内的行尾，可以使用 g_
map({ 'n', 'v' }, '$', 'g_', { desc = 'Goto last non-blank char' })
map({ 'n', 'v' }, 'g_', '$', { desc = 'Goto the end of line' })

-- 允许用户多次缩进同一块文本，而不需要在每次缩进后手动重新选择文本
-- 在缩进后保持文本的选中状态，以便进行进一步的操作
map('v', '<', '<gv', { desc = 'Increase indent' })
map('v', '>', '>gv', { desc = 'Decrease indent' })

-- 在可视模式下, 允许你多次粘贴同一内容，保持了原始剪贴板的内容不变
map('v', 'p', '"_dP')

-- 按 ESC 键时自动清除搜索高亮
map({ 'i', 'n' }, '<ESC>', '<CMD>noh<CR><ESC>', { desc = 'Escape(clear hlsearch)' })

-- 插入模式下创建新的撤销点：逗号，句号，分号
map('i', ',', ',<C-g>u', { desc = 'Insert , with undo point' })
map('i', '.', '.<C-g>u', { desc = 'Insert . with undo point' })
map('i', ';', ';<C-g>u', { desc = 'Insert ; with undo point' })

-- 无论搜索方向如何，n 总是移动到下一个匹配项，N 总是移动到上一个匹配项。
-- 在普通模式下，如果搜索结果位于折叠的文本中，会自动展开折叠。
-- 在可视模式和操作符待决模式下，保持一致的导航行为，但不自动展开折叠。
-- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map('n', 'n', "'Nn'[v:searchforward].'zv'", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward].'zv'", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- On/Off 功能

-- =============================================================================
-- 禁用不使用的按键映射
-- =============================================================================

-- =============================================================================
-- TODO
-- =============================================================================

-- TODO: 是否必要?
-- -- Resize window using <CTRL> arrow keys
-- map('n', keymaps.window.inc_height, '<CMD>resize +2<CR>', { desc = 'Increase window height' })
-- map('n', keymaps.window.dec_height, '<CMD>resize -2<CR>', { desc = 'Decrease window height' })
-- map('n', keymaps.window.inc_width, '<CMD>vertical resize -2<CR>', { desc = 'Decrease window width' })
-- map('n', keymaps.window.dec_width, '<CMD>vertical resize +2<CR>', { desc = 'Increase window width' })

-- -- Diagnostic
-- ---@param next boolean
-- ---@param severity string | integer | nil
-- ---@return function
-- local function diagnosticGoto(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end

-- TODO: Add a toggle to enable/disable autopairs
-- LazyVim.toggle.map('<leader>up', {
--   name = 'Mini Pairs',
--   get = function()
--     return not vim.g.minipairs_disable
--   end,
--   set = function(state)
--     vim.g.minipairs_disable = not state
--   end,
-- })

-- map('n', keymaps.diagnostic.show_line_diag, vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
-- map('n', keymaps.diagnostic.next_diag, diagnosticGoto(true), { desc = 'Next Diagnostic' })
-- map('n', keymaps.diagnostic.prev_diag, diagnosticGoto(false), { desc = 'Prev Diagnostic' })
-- map('n', keymaps.diagnostic.next_error, diagnosticGoto(true, 'ERROR'), { desc = 'Next Error' })
-- map('n', keymaps.diagnostic.prev_error, diagnosticGoto(false, 'ERROR'), { desc = 'Prev Error' })
-- map('n', keymaps.diagnostic.next_warn, diagnosticGoto(true, 'WARN'), { desc = 'Next Warning' })
-- map('n', keymaps.diagnostic.prev_warn, diagnosticGoto(false, 'WARN'), { desc = 'Prev Warning' })

-- -- toggle options
-- map('n', keymaps.toggle.spelling, function()
--   lazyvim.toggle('spell')
-- end, { desc = 'Toggle Spelling' })
-- map('n', keymaps.toggle.line_numbers, function()
--   lazyvim.toggle.number()
-- end, { desc = 'Toggle Line Numbers' })
-- map('n', keymaps.toggle.relative_numbers, function()
--   lazyvim.toggle('relativenumber')
-- end, { desc = 'Toggle Relative Line Numbers' })
-- map('n', keymaps.toggle.diagnostic, function()
--   lazyvim.toggle.diagnostics()
-- end, { desc = 'Toggle Diagnostics' })
-- map('n', keymaps.toggle.wrap, function()
--   toggle.wrap()
-- end, { desc = 'Toggle wrap' })

-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map('n', keymaps.toggle.conceal, function()
--   lazyvim.toggle('conceallevel', false, { 0, conceallevel })
-- end, { desc = 'Toggle Conceal' })

-- if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
--   map('n', keymaps.toggle.inlay_hints, function()
--     lazyvim.toggle.inlay_hints()
--   end, { desc = 'Toggle Inlay Hints' })
-- end

-- map('n', keymaps.toggle.treesitter, function()
--   toggle.treesitter()
-- end, { desc = 'Toggle Treesitter Highlight' })

-- -- highlights info under cursor
-- map('n', keymaps.toggle.show_hl_info, vim.show_pos, { desc = 'Show highlights info' })
