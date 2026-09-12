-- 使用隔离 XDG_STATE_HOME：验证首次提示、快捷键、底栏共用读写入口。
vim.opt.rtp:prepend(vim.fn.getcwd())
vim.notify = function() end
local toggles = require("config.toggles")
local state = require("config.state")
vim.g.mapleader = " "
toggles.setup()
toggles.map_keys()
local function press(lhs)
    local mapping = vim.fn.maparg(lhs, "n", false, true)
    assert(type(mapping.callback) == "function", lhs)
    mapping.callback()
end

-- LSP 只启用了当前文件时，第一次点击必须能关闭。
vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
assert(toggles.enabled("inlay_hints"))
press("<leader>uh")
assert(not toggles.enabled("inlay_hints"))
assert(state.get("toggle.inlay_hints") == false)

-- 用最小默认配置创建底栏，八个按钮使用真实开关模块。
local opts =
    { options = { disabled_filetypes = {} }, sections = { lualine_x = {} } }
dofile("lua/plugins/lualine.lua").opts(nil, opts)
local components = opts.sections.lualine_z
for i, key in ipairs({
    "diagnostics",
    "inlay_hints",
    "codelens",
    "conceal",
    "spell",
    "list",
    "relativenumber",
    "autoformat",
}) do
    local before = toggles.enabled(key)
    components[i].on_click()
    assert(toggles.enabled(key) == not before, key)
    assert(state.get("toggle." .. key) == not before, key)
    assert(
        vim.deep_equal(
            components[i].color(),
            not before and {}
                or { fg = require("config.statusline").color("Comment") }
        ),
        key
    )
end
press("<leader>us")
local spell = toggles.enabled("spell")
vim.cmd("vnew")
vim.api.nvim_exec_autocmds("WinEnter", {})
vim.wait(50, function()
    return false
end)
assert(vim.wo.spell == spell)
assert(state.get("toggle.spell") == spell)

-- 全局格式化快捷键清除文件级旧覆盖，保存统一偏好。
vim.g.autoformat = true
vim.b.autoformat = false
press("<leader>uf")
assert(vim.g.autoformat == true and vim.b.autoformat == nil)
assert(state.get("toggle.autoformat") == true)
press("<leader>uf")
assert(not toggles.enabled("autoformat"))
assert(state.get("toggle.autoformat") == false)
print("toggle input tests passed")
