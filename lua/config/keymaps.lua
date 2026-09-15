-- 在 LazyVim 默认快捷键之后加载，只保留个人补充和覆盖。
-- 默认映射：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- 可视选择使用 x，不使用同时包含 Select 模式的 v，避免干扰片段占位符填写。

local map = vim.keymap.set
local del = vim.keymap.del

-- 取消通过 keywordprg 查询光标单词手册的入口。
del("n", "<leader>K")

-- 取消 Snacks 性能分析及源码耗时高亮；这两项由 LazyVim 全局映射注册。
del("n", "<leader>dpp")
del("n", "<leader>dph")

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
map("n", "<leader>fl", function()
    copy_file_location("line")
end, { desc = "复制绝对路径及行号" })

-- 清理默认全局入口；插件自己的按需映射在对应插件声明中禁用。
for _, key in ipairs({
    "[b", -- 上一个缓冲区；改用 Shift-h。
    "]b", -- 下一个缓冲区；改用 Shift-l。
    "[B", -- Bufferline 向前移动标签；取消后会露出原生首个缓冲区映射。
    "]B", -- Bufferline 向后移动标签；取消后会露出原生末个缓冲区映射。
    "[t", -- 上一个 TODO；取消后会露出原生上一个 tag 匹配映射。
    "]t", -- 下一个 TODO；取消后会露出原生下一个 tag 匹配映射。
    "<leader>bb", -- 切回上一次编辑的缓冲区（alternate buffer）。
    "<leader>`", -- 同 bb，切回上一次编辑的缓冲区。
    "<leader>bi", -- 关闭未显示在窗口中的缓冲区。
    "<leader>bD", -- 原生 :bdelete，关闭缓冲区时可能同时关闭窗口。
    "<leader>-", -- 上下分屏；迁到 leader ws。
    "<leader>|", -- 左右分屏；迁到 leader wv。
    "<leader>wm", -- 切换当前窗口最大化（Snacks zoom）。
    "<leader>uZ", -- 同 wm，切换当前窗口最大化。
    "<leader>uz", -- 切换专注模式（Snacks Zen）。
    "<leader>uD", -- 切换非当前代码区域调暗（Snacks dim）。
    "<leader>ft", -- 在推断的项目根目录打开终端。
    "<leader>fT", -- 在 cwd 打开终端；统一使用 Ctrl-/。
    "<leader>gG", -- 在 cwd 打开 Lazygit；保留 gg 项目根目录入口。
    "<leader>gL", -- 查看 cwd 仓库提交历史（Snacks picker）。
    "<leader>gl", -- 查看仓库提交历史；另在 FzfLua 声明中禁用同名入口。
    "<leader>xl", -- 打开／关闭当前窗口的原生位置列表。
    "<leader>cd", -- 当前行诊断详情；迁到 leader xd。
    "[d", -- 上一个诊断，不限严重性。
    "]d", -- 下一个诊断，不限严重性。
    "[D", -- 第一个诊断（Neovim 原生映射）。
    "]D", -- 最后一个诊断（Neovim 原生映射）。
    "[e", -- 上一个错误级别诊断。
    "]e", -- 下一个错误级别诊断。
    "[w", -- 上一个警告级别诊断。
    "]w", -- 下一个警告级别诊断。
    "<C-w>d", -- 光标处诊断浮窗（Neovim 原生映射）。
    "<C-w><C-d>", -- 同 Ctrl-w d，光标处诊断浮窗。
    "grr", -- LSP 引用；统一使用 gr。
    "gri", -- LSP 实现；统一使用 gI。
    "grt", -- LSP 类型定义；统一使用 gy。
    "grn", -- LSP 符号重命名；统一使用 leader cr。
    "grx", -- 执行 CodeLens；统一使用 leader cc。
    "gO", -- LSP 文档符号列表；取消独立符号搜索入口。
}) do
    pcall(del, "n", key)
end
for _, suffix in ipairs({
    "l", -- leader Tab l：最后一个标签页。
    "o", -- leader Tab o：只保留当前标签页。
    "f", -- leader Tab f：第一个标签页。
    "<Tab>", -- leader Tab Tab：新建标签页。
    "]", -- leader Tab ]：下一个标签页。
    "d", -- leader Tab d：关闭当前标签页。
    "[", -- leader Tab [：上一个标签页。
}) do
    pcall(del, "n", "<leader><Tab>" .. suffix)
end
for _, mode in ipairs({ "n", "i", "x", "s" }) do
    -- LazyVim 的保存并返回普通模式；也不保留原生插入 Ctrl-s 签名入口。
    pcall(del, mode, "<C-s>")
end
for _, mode in ipairs({ "n", "x" }) do
    pcall(del, mode, "gra") -- LSP 代码操作；统一使用 leader ca。
    pcall(del, mode, "<leader>gB") -- 打开远程代码链接；迁到 leader go。
    pcall(del, mode, "<leader>gY") -- 复制远程代码链接；迁到 leader gy。
end

map("n", "<leader>ws", "<C-w>s", { desc = "上下分屏" })
map("n", "<leader>wv", "<C-w>v", { desc = "左右分屏" })
map("n", "<leader>xd", function()
    local _, win = vim.diagnostic.open_float({ scope = "line" })
    if win then
        vim.wo[win].wrap = true
    end
end, { desc = "当前行诊断详情" })
-- 覆盖 LazyVim 的原生 Quickfix 开关，避免全局默认覆盖 lazy keys。
map("n", "<leader>xq", function()
    require("trouble").toggle("qflist")
end, { desc = "Quickfix 列表（Trouble）" })
for _, key in ipairs({ "<C-/>", "<C-_>" }) do
    map({ "n", "t" }, key, function()
        Snacks.terminal.toggle(nil, { cwd = vim.fn.getcwd() })
    end, {
        desc = key == "<C-_>" and "which_key_ignore"
            or "终端（当前目录）",
    })
end
map({ "n", "x" }, "<leader>go", function()
    Snacks.gitbrowse()
end, { desc = "打开远程代码链接" })
map({ "n", "x" }, "<leader>gy", function()
    Snacks.gitbrowse({
        open = function(url)
            vim.fn.setreg("+", url)
        end,
        notify = false,
    })
end, { desc = "复制远程代码链接" })

-- 取消 Ctrl + 方向键调整窗口尺寸的默认绑定。
del("n", "<C-Up>")
del("n", "<C-Down>")
del("n", "<C-Left>")
del("n", "<C-Right>")

-- 开关：删除 LazyVim 默认的开关快捷键，让 toggles 模块能完全控制描述。
for _, key in ipairs({ "ud", "uh", "uc", "us", "uL", "uf" }) do
    pcall(del, "n", "<leader>" .. key)
end
-- 快捷键与底栏共用状态保存逻辑。
require("config.toggles").map_keys()

-- 格式化只保留全局 uf；主题及明暗统一在系统中修改。
del("n", "<leader>uF")
del("n", "<leader>ub")
-- 颜色选择器可能来自按需加载的插件，存在时才删除映射。
if vim.fn.maparg("<leader>uC", "n") ~= "" then
    del("n", "<leader>uC")
end
