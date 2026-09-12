-- 在仓库根目录运行：nvim --headless -u NONE -i NONE -l tests/jieba_surround.lua
-- 使用已安装的插件；不安装、更新插件，也不读取或保存个人 ShaDa。
local root = vim.fn.getcwd()
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or (vim.fn.stdpath("data") .. "/lazy")
vim.opt.rtp:prepend(root)
vim.opt.rtp:prepend(plugins .. "/lazy.nvim")
require("config.jieba")
vim.go.loadplugins = true
_G.LazyVim = {
    opts = function(name)
        return require("lazy.core.plugin").values(
            require("lazy.core.config").plugins[name],
            "opts",
            false
        )
    end,
}
local extras = plugins .. "/LazyVim/lua/lazyvim/plugins/extras/"
require("lazy").setup({
    dofile(extras .. "coding/mini-surround.lua"),
    dofile(extras .. "editor/leap.lua"),
    dofile(root .. "/lua/plugins/leap.lua"),
    dofile(root .. "/lua/plugins/jieba.lua"),
    dofile(root .. "/lua/plugins/surround.lua"),
}, {
    root = plugins,
    lockfile = vim.fn.tempname(),
    install = { missing = false },
    checker = { enabled = false },
    change_detection = { enabled = false },
    rocks = { enabled = false },
    pkg = { enabled = false },
    readme = { enabled = false },
    performance = { cache = { enabled = false } },
})

local function feed(keys)
    vim.api.nvim_feedkeys(vim.keycode(keys), "xt", false)
end

local function check(lines, keys, expected, cursor)
    feed("<Esc>")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
    vim.api.nvim_win_set_cursor(0, cursor or { 1, 0 })
    feed(keys)
    local actual = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    assert(
        vim.deep_equal(actual, expected),
        keys .. ": " .. vim.inspect(actual)
    )
end

vim.bo.filetype = vim.env.JIEBA_TEST_FIRST_FT or "markdown"
-- 首次调用同时触发 Surround 和 Jieba 的懒加载。
check({ "中国人民欢迎你" }, 'gzaiw"', { '"中国"人民欢迎你' })
check({ "中国人民欢迎你" }, 'gza2iw"', { '"中国人民"欢迎你' })
check({ "中国人民欢迎你" }, '2gzaiw"', { '""中国""人民欢迎你' })
check({ "中国人民欢迎你" }, "gzaiw)", { "(中国)人民欢迎你" })
check({ "中国 人民" }, 'gzaaw"', { '"中国 "人民' })
check({ "hello world" }, 'gzaiw"', { '"hello" world' })
check({ "中国人民欢迎你" }, "gzaiw<Esc>", { "中国人民欢迎你" })
check({ "中国人民欢迎你" }, 'viwgza"', { '"中国"人民欢迎你' })
check({ "中国", "人民" }, 'gza2iw"', { '"中国', '人民"' })
check({ "" }, "gzaiw<Esc>", { "" })
check({ "" }, 'gzaiw"<Esc>', { '""' })

check({ "中国人民欢迎你" }, 'gzaiw"', { '"中国"人民欢迎你' })
vim.api.nvim_win_set_cursor(0, { 1, 8 })
feed(".")
assert(vim.api.nvim_get_current_line() == '"中国""人民"欢迎你')

vim.o.selection = "exclusive"
check({ "中国人民欢迎你" }, 'gzaiw"', { '"中国"人民欢迎你' })
check({ "中国" }, 'gzaiw"', { '"中国"' })
check({ "中国", "人民" }, 'gza2iw"', { '"中国', '人民"' })
vim.o.selection = "inclusive"

-- 普通 Jieba 操作仍使用原来的实现及 repeat.vim 支持。
check({ "中国人民欢迎你" }, "dw.", { "欢迎你" })
check({ "中国人民欢迎你" }, "diw.", { "欢迎你" })
check({ "中国人民欢迎你" }, "yiw", { "中国人民欢迎你" })
assert(vim.fn.getreg('"') == "中国")
check(
    { "中国人民欢迎你" },
    "ciw你好<Esc>",
    { "你好人民欢迎你" }
)
assert(vim.fn.maparg("iw", "o", false, true).buffer == 1)

-- 每种支持的文件类型都有局部映射，并能完成中文包围和英文编辑。
for _, ft in ipairs(require("config.jieba").filetypes) do
    vim.cmd("enew!")
    vim.bo.filetype = ft
    assert(vim.fn.maparg("iw", "o", false, true).buffer == 1, ft)
    assert(vim.fn.maparg("w", "n", false, true).buffer == 1, ft)
    assert(vim.fn.maparg("W", "n") == "", ft)
    check({ "中国人民欢迎你" }, 'gzaiw"', { '"中国"人民欢迎你' })
    check({ "hello world" }, 'gzaiw"', { '"hello" world' })
end

-- 代码里的中文注释也能直接选词；前面的注释符号不受影响。
vim.cmd("enew!")
vim.bo.filetype = "lua"
check(
    { "-- 中国人民欢迎你" },
    'gzaiw"',
    { '-- "中国"人民欢迎你' },
    { 1, 3 }
)

-- 未列入白名单的插件窗口不应出现 Jieba 的局部映射。
for _, ft in ipairs({
    "neo-tree",
    "lazy",
    "help",
    "qf",
    "terminal",
    "snacks_dashboard",
}) do
    vim.cmd("enew!")
    vim.bo.buftype = "nofile"
    vim.bo.filetype = ft
    for _, motion in ipairs({ "w", "b", "e", "ge", "iw", "aw" }) do
        for _, mode in ipairs({ "n", "x", "o" }) do
            assert(vim.fn.maparg(motion, mode) == "", ft .. ": " .. motion)
        end
    end
end
print(
    "PASS: Jieba/Surround compatibility, code comments, supported filetypes and special-window isolation"
)
