-- 使用真实 Trouble、lualine 和 window-picker 验证窗口元数据的跨插件适配。
local root = vim.fn.getcwd()
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or (vim.fn.stdpath("data") .. "/lazy")
vim.opt.rtp:prepend(root)
for _, plugin in ipairs({
    "trouble.nvim",
    "nvim-window-picker",
    "lualine.nvim",
    "lazy.nvim",
    "snacks.nvim",
}) do
    vim.opt.rtp:append(plugins .. "/" .. plugin)
end
vim.o.columns = 160
vim.o.lines = 50
vim.o.termguicolors = true

local windows = require("config.ui.windows")
local display = require("config.ui.statusline")
local trouble = require("trouble")
trouble.setup({
    open_no_results = true,
    warn_no_results = false,
    auto_preview = false,
    auto_refresh = false,
})

local editor = vim.api.nvim_get_current_win()
local diagnostic = trouble.open({ mode = "diagnostics" })
local symbols = trouble.open({ mode = "symbols" })
assert(
    vim.wait(1000, function()
        return diagnostic.win.win ~= nil and symbols.win.win ~= nil
    end),
    "Trouble windows did not open"
)
assert(windows.name(diagnostic.win.win) == "诊断列表（Trouble）")
assert(windows.name(symbols.win.win) == "符号树（Trouble）")

local function split(ft, bt)
    vim.cmd("vnew")
    vim.bo.filetype = ft
    vim.bo.buftype = bt or "nofile"
    return vim.api.nvim_get_current_win()
end
local tree = split("neo-tree")
split("noice")
split("AvanteInput")
-- 搜索替换面板即使使用普通 buftype，也不能作为文件打开目标。
split("grug-far", "")
local preview =
    vim.api.nvim_open_win(vim.api.nvim_create_buf(false, true), false, {
        relative = "editor",
        row = 1,
        col = 1,
        width = 20,
        height = 3,
    })
assert(not windows.is_open_target(preview))
vim.api.nvim_set_current_win(tree)
local picker = require("window-picker")
picker.setup(dofile(root .. "/lua/plugins/ui/neotree.lua")[1].opts)
-- 只有一个编辑窗口时应自动选择它，不能因面板存在而等待输入字母。
assert(picker.pick_window() == editor)

local second_editor = split("", "")
vim.api.nvim_set_current_win(tree)
local eligible = windows.filter(vim.api.nvim_tabpage_list_wins(0), {
    include_current_win = false,
})
table.sort(eligible)
local expected = { editor, second_editor }
table.sort(expected)
assert(vim.deep_equal(eligible, expected), vim.inspect(eligible))
vim.api.nvim_set_current_win(editor)
assert(
    display.path() == "[未命名]",
    "new file must remain an editing buffer"
)
assert(not vim.tbl_contains(windows.filter({ editor }, {}), editor))

-- 不依赖主题的具体色值；用插件自带主题验证真实 winbar 渲染。
local opts = {
    options = { disabled_filetypes = {} },
    sections = { lualine_x = {} },
}
_G.Snacks = require("snacks")
dofile(root .. "/lua/plugins/ui/lualine.lua").opts(nil, opts)
opts.options.theme = "onedark"
require("lualine").setup(opts)
local function rendered(win, focused)
    return vim.api.nvim_win_call(win, function()
        return require("lualine").winbar(focused)
    end)
end
local active = rendered(diagnostic.win.win, true)
assert(active:find("诊断列表（Trouble）", 1, true), active)
assert(active:find("", 1, true), active)
local inactive = rendered(symbols.win.win, false)
assert(inactive:find("符号树（Trouble）", 1, true), inactive)
assert(inactive:find("", 1, true), inactive)
assert(not inactive:find("未命名", 1, true), inactive)
local function title_color(bar)
    return vim.api.nvim_get_hl(0, {
        name = assert(bar:match("^%%#(.-)#")),
        link = false,
    })
end
local active_color, inactive_color = title_color(active), title_color(inactive)
assert(active_color.fg == inactive_color.fg)
assert(active_color.bg == inactive_color.bg)
print(
    "PASS: Trouble titles, utility window filtering, automatic selection and winbar rendering"
)
vim.cmd("qa!")
