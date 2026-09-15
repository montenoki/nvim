-- 使用真实 csvview 插件验证渲染及导航不会改写带引号、多行和 TSV 数据。
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
vim.opt.rtp:append(plugins .. "/csvview.nvim")
local spec = dofile("lua/plugins/languages/csv.lua")
spec.config(nil, spec.opts)
local csv = require("csvview")

local function verify(ft, lines)
    vim.cmd.enew()
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo.modified = false
    vim.bo.filetype = ft
    assert(
        vim.wait(3000, function()
            return csv.is_enabled(buf)
        end),
        "CSV view did not attach"
    )
    vim.wait(100)
    assert(vim.deep_equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), lines))
    assert(not vim.bo.modified, "rendering modified the buffer")

    vim.api.nvim_win_set_cursor(0, { 2, 0 })
    local next_field = vim.fn.maparg("]v", "n", false, true)
    assert(type(next_field.callback) == "function", "field navigation missing")
    next_field.callback()
    assert(
        vim.api.nvim_win_get_cursor(0)[2] > 0,
        "field navigation did not move"
    )
    csv.disable(buf)
    assert(not csv.is_enabled(buf))
    assert(vim.deep_equal(vim.api.nvim_buf_get_lines(buf, 0, -1, false), lines))
    assert(not vim.bo.modified, "navigation or detach modified the buffer")
    vim.api.nvim_buf_delete(buf, { force = true })
end

verify("csv", {
    "name,value",
    '"hello, world",42',
    '"multi',
    'line",7',
    "#data,0",
    "//data,1",
})
verify("tsv", { "name\tvalue", "hello\t42", "#data\t0" })
print("PASS: real CSV/TSV view and navigation preserve original data")
