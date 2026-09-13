-- 在 LazyVim 默认快捷键之后加载，只保留个人补充和覆盖。
-- 默认映射：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 可视选择使用 x，不使用同时包含 Select 模式的 v，避免干扰片段占位符填写。

local map = vim.keymap.set
local del = vim.keymap.del

-- 移动：普通和可视模式下，j/k 始终按实际行移动。
-- 保留默认方向键映射：无次数时按屏幕显示行移动，带次数时按实际行移动。
del({ "n", "x" }, "j")
del({ "n", "x" }, "k")

-- 交换行尾动作：$ 到最后一个非空白字符，g_ 到包含尾随空白的行尾。
-- 不修改操作等待模式，因此 d$、c$ 等组合中的 $ 仍表示原生行尾。
map({ "n", "x" }, "$", "g_", { desc = "最后一个非空白字符" })
map({ "n", "x" }, "g_", "$", { desc = "行尾（含尾随空白）" })

-- 修改与粘贴：c/C 删除的内容写入黑洞寄存器，不覆盖原有复制内容。
-- 仅影响这两个修改操作，不改变 d 等其他删除命令。
map({ "n", "x" }, "c", '"_c', { desc = "修改文本（保留复制内容）" })
map("n", "C", '"_C', { desc = "修改到行尾（保留复制内容）" })
map("x", "C", '"_C', { desc = "修改选中行（保留复制内容）" })

-- 选中文字后使用原生 P 替换，保留原来复制的内容。
map("x", "p", "P", { desc = "替换选区（保留复制内容）" })

-- 文件位置：复制到系统剪贴板，不使用状态栏中为显示而缩短的路径。
local function copy_file_location(kind)
    local name = vim.api.nvim_buf_get_name(0)
    if name == "" or vim.bo.buftype ~= "" or name:match("^%a[%w+.-]*://") then
        vim.notify(
            "当前缓冲区没有可复制的文件路径",
            vim.log.levels.INFO
        )
        return
    end
    local path = vim.fs.normalize(name)
    if kind == "relative" then
        local root = vim.fs.normalize(LazyVim.root.get()):gsub("/+$", "") .. "/"
        -- 检查完整目录前缀，项目外的文件保留绝对路径。
        if vim.startswith(path, root) then
            path = path:sub(#root + 1)
        end
    elseif kind == "line" then
        path = path .. ":" .. vim.api.nvim_win_get_cursor(0)[1]
    end
    vim.fn.setreg("+", path, "v")
    vim.notify(path, vim.log.levels.INFO, { title = "已复制文件位置" })
end

map("n", "<leader>fy", function()
    copy_file_location("relative")
end, { desc = "复制项目相对路径" })
map("n", "<leader>fY", function()
    copy_file_location("absolute")
end, { desc = "复制绝对路径" })
map("n", "<leader>fL", function()
    copy_file_location("line")
end, { desc = "复制绝对路径及行号" })

-- 窗口：保留大写 wM 作为缩放别名；小写 wm 使用 LazyVim 默认绑定。
Snacks.toggle.zoom():map("<leader>wM")

-- 取消 Ctrl + 方向键调整窗口尺寸的默认绑定。
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")

-- 开关：快捷键与底栏共用状态保存逻辑。
require("config.toggles").map_keys()

-- 格式化只保留全局 uf；主题及明暗统一在系统中修改。
del("n", "<leader>uF")
del("n", "<leader>ub")
-- 颜色选择器可能来自按需加载的插件，存在时才删除映射。
if vim.fn.maparg("<leader>uC", "n") ~= "" then
    del("n", "<leader>uC")
end
