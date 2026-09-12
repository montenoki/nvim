-- 在 LazyVim 默认选项之后、插件初始化之前加载，只保留个人偏好。
-- 默认选项：https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- 文件类型相关快捷键的前缀也使用空格。
vim.g.maplocalleader = " "

-- 关闭 Snacks 动画。
vim.g.snacks_animate = false

-- Windows 使用 PowerShell 7，并应用对应的终端参数。
if vim.fn.has("win32") == 1 then
    LazyVim.terminal.setup("pwsh")
end

local opt = vim.opt

-- 编辑：缩进、光标移动与补全。
-- 默认按 4 列显示 Tab，缩进宽度跟随 tabstop；允许文件类型和项目配置覆盖。
opt.tabstop = 4
opt.shiftwidth = 0

-- 普通模式和插入模式下，左右方向键可以跨越行首、行尾。
opt.whichwrap = "<,>,[,]"

-- 原生补全显示菜单和信息弹窗，不预选候选；Blink 的行为由插件配置管理。
opt.completeopt = { "menu", "menuone", "popup", "noselect" }

-- 排版与保存：这里的断行会修改文本，区别于下方的屏幕折行。
-- 自动断行和文本排版的宽度；是否自动断行还取决于 formatoptions。
opt.textwidth = 80

-- 注释自动断行、回车延续注释、允许 gq 排版并识别编号列表；
-- 支持中文断行，合并行时不在多字节字符前后添加空格，并清理注释前缀。
-- autocmds.lua 在文件类型配置之后应用此默认值，并为 Markdown、纯文本添加 t。
opt.formatoptions =
    { c = true, r = true, q = true, n = true, m = true, M = true, j = true }

-- 保存时保留文件原本是否有末尾换行。
opt.fixendofline = false

-- 显示：屏幕折行、宽度参考线与空白字符。
-- 长行在屏幕上折行显示，不因此向文件插入换行。
opt.wrap = true

-- 在文本宽度限制的下一列显示参考线。
opt.colorcolumn = "+1"

-- 开启空白字符显示时使用的符号。
opt.listchars = {
    eol = "↲",
    tab = "→ ",
    trail = "·",
    extends = "❯",
    precedes = "❮",
}

-- 没有已保存偏好时，默认关闭空白字符显示和拼写检查。
opt.list = false
opt.spell = false

-- 基础选项设置完成后，恢复通过快捷键或状态栏保存的开关偏好。
require("config.toggles").setup()
