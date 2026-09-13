-- 通过完整配置运行，检查 Neo-tree 合并后的映射和真实 Enter 打开路径。
-- 见 tests/README.md；不发送真实按键，只替换选择器读取字母的入口。
vim.o.columns = 160
vim.o.lines = 50
local dir = vim.fn.tempname()
vim.fn.mkdir(dir, "p")
for _, name in ipairs({ "one.txt", "two.txt", "three.txt" }) do
    vim.fn.writefile({ "window picker test" }, dir .. "/" .. name)
end
vim.cmd.edit(dir .. "/one.txt")
local first = vim.api.nvim_get_current_win()
vim.cmd.vsplit(dir .. "/two.txt")
local second = vim.api.nvim_get_current_win()
local command = require("neo-tree.command")
local function focus_file()
    command.execute({
        action = "focus",
        source = "filesystem",
        dir = dir,
        reveal_file = dir .. "/three.txt",
    })
    assert(
        vim.wait(5000, function()
            local state =
                require("neo-tree.sources.manager").get_state("filesystem")
            return vim.bo.filetype == "neo-tree"
                and state.tree
                and state.tree.bufnr == vim.api.nvim_get_current_buf()
                and state.tree:get_node()
                and state.tree:get_node():get_id() == dir .. "/three.txt"
        end),
        "Neo-tree did not select the test file"
    )
end
focus_file()

-- Lua 的 <CR>/<cr> 是不同键，Neovim 却会把它们映射到同一个 Enter。
-- 两份配置共存时会依赖 pairs 的遍历顺序，不能只验证 opts 中自定义的那一项。
local mappings = require("neo-tree").ensure_config().filesystem.window.mappings
local enter_count = 0
for key in pairs(mappings) do
    if vim.keycode(key) == vim.keycode("<CR>") then
        enter_count = enter_count + 1
    end
end
assert(enter_count == 1, "duplicate Enter mappings after Neo-tree setup")

local hint = require("window-picker.hints.floating-big-letter-hint")
local original_draw = hint.draw
local candidates
hint.draw = function(self, wins)
    candidates = vim.deepcopy(wins)
    return original_draw(self, wins)
end
local util = require("window-picker.util")
local original_input = util.get_user_input_char
local prompted = false
util.get_user_input_char = function()
    prompted = true
    return "F" -- 默认候选字母的第一项。
end

local enter = vim.fn.maparg("<CR>", "n", false, true)
assert(type(enter.callback) == "function")
enter.callback()
assert(prompted, "Neo-tree Enter bypassed the window picker")
table.sort(candidates)
local expected = { first, second }
table.sort(expected)
assert(vim.deep_equal(candidates, expected), vim.inspect(candidates))
assert(vim.api.nvim_buf_get_name(0) == dir .. "/three.txt")

-- 没有编辑窗口时应创建一个；不能因过滤后为空而使 Enter 无效。
local windows = require("config.ui.windows")
for _, key in ipairs({ "<CR>", "s", "v" }) do
    focus_file()
    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        if windows.is_open_target(win) then
            vim.api.nvim_win_close(win, true)
        end
    end
    assert(#vim.api.nvim_tabpage_list_wins(0) == 1)
    prompted = false
    vim.fn.maparg(key, "n", false, true).callback()
    assert(not prompted, "empty candidate list must not prompt")
    assert(windows.is_open_target(vim.api.nvim_get_current_win()))
    assert(vim.api.nvim_buf_get_name(0) == dir .. "/three.txt")
    assert(
        #vim.api.nvim_tabpage_list_wins(0) == 1,
        "extra empty split left behind"
    )
end

-- Trouble 留在旁边时也应新建编辑窗口，不能把文件塞进诊断面板。
local trouble = require("trouble").open({
    mode = "diagnostics",
    open_no_results = true,
    warn_no_results = false,
})
assert(vim.wait(2000, function()
    return trouble.win.win ~= nil
end))
local trouble_win = trouble.win.win
local trouble_buf = vim.api.nvim_win_get_buf(trouble_win)
focus_file()
for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if windows.is_open_target(win) then
        vim.api.nvim_win_close(win, true)
    end
end
vim.fn.maparg("<CR>", "n", false, true).callback()
assert(vim.api.nvim_buf_get_name(0) == dir .. "/three.txt")
assert(vim.api.nvim_win_is_valid(trouble_win))
assert(vim.api.nvim_win_get_buf(trouble_win) == trouble_buf)

-- 启动页有功能名称，但可以让位给文件；使用真实 Snacks dashboard 验证复用。
local dashboard = require("snacks.dashboard").open({
    win = vim.api.nvim_get_current_win(),
    sections = { { text = "测试启动页" } },
})
local dashboard_win = dashboard.win
assert(vim.bo[dashboard.buf].filetype == "snacks_dashboard")
assert(
    windows.name(dashboard_win) ~= nil,
    "dashboard must have a utility title"
)
focus_file()
local count = #vim.api.nvim_tabpage_list_wins(0)
prompted = false
vim.fn.maparg("<CR>", "n", false, true).callback()
assert(
    not prompted,
    "the sole dashboard target should be selected automatically"
)
assert(
    vim.api.nvim_get_current_win() == dashboard_win,
    "dashboard window was not reused"
)
assert(vim.api.nvim_buf_get_name(0) == dir .. "/three.txt")
assert(
    #vim.api.nvim_tabpage_list_wins(0) == count - 1,
    "an extra split was created"
)
assert(vim.api.nvim_win_get_buf(trouble_win) == trouble_buf)

hint.draw = original_draw
util.get_user_input_char = original_input
print(
    "PASS: Neo-tree picker mapping, two targets, no-target fallback, dashboard reuse and Trouble preservation"
)
vim.cmd("qa!")
