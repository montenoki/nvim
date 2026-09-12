-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- 快捷键与底栏共用保存逻辑。
require("config.toggles").map_keys()

-- 格式化只保留全局 uf；主题及明暗统一在系统中修改。
del("n", "<leader>uF")
del("n", "<leader>ub")
-- 颜色选择器可能来自按需加载的插件，存在时才删除映射。
if vim.fn.maparg("<leader>uC", "n") ~= "" then
    del("n", "<leader>uC")
end

-- 保留大写 wM 作为窗口缩放别名；小写 wm 使用 LazyVim 默认绑定。
Snacks.toggle.zoom():map("<leader>wM")

-- j、k在[实际行]中移动
-- 方向键在[视觉行]中移动
del({ "n", "x" }, "j")
del({ "n", "x" }, "k")

-- 交换 g_ 和 $
-- 使用 $ 键时，光标停在最后一个非空白字符上，这通常是更有用的位置，特别是在编辑代码时。
-- 如果确实需要移动到包括尾随空白在内的行尾，可以使用 g_
map({ "n", "v" }, "$", "g_", { desc = "Goto last non-blank char" })
map({ "n", "v" }, "g_", "$", { desc = "Goto the end of line" })

-- 选中文字后使用原生 P 替换，保留原来复制的内容。
map("x", "p", "P")

-- 让删除文本的操作不会覆盖默认寄存器的内容，保持剪切板内容不变
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')

-- 取消默认的Resize window快捷键
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")
