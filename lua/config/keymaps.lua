-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- j、k在[实际行]中移动
-- 方向键在[视觉行]中移动
del({ "n", "x" }, "j")
del({ "n", "x" }, "k")

-- 交换 g_ 和 $
-- 使用 $ 键时，光标停在最后一个非空白字符上，这通常是更有用的位置，特别是在编辑代码时。
-- 如果确实需要移动到包括尾随空白在内的行尾，可以使用 g_
map({ "n", "v" }, "$", "g_", { desc = "Goto last non-blank char" })
map({ "n", "v" }, "g_", "$", { desc = "Goto the end of line" })

-- 在可视模式下, 允许你多次粘贴同一内容，保持剪贴板内容不变
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- 让删除文本的操作不会覆盖默认寄存器的内容，保持剪切板内容不变
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')

-- 取消默认的Resize window快捷键
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")
