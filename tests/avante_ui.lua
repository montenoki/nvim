-- 在 nvim-test 中使用隔离状态和缓存目录运行；不发送模型请求。
require("lazy").load({ plugins = { "avante.nvim", "blink.cmp" } })
vim.wait(300, function()
    return false
end)
vim.o.columns, vim.o.lines = 140, 45
vim.cmd("enew")
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "local example = true" })
-- 只打开界面，禁止测试意外发送模型请求。
require("avante.llm").stream = function()
    error("UI test must not request a model")
end
require("avante").open_sidebar({ ask = true })
vim.wait(500, function()
    return false
end)
local sidebar = require("avante").get()
assert(sidebar.containers.input.bufnr)
assert(vim.bo[sidebar.containers.input.bufnr].filetype == "AvanteInput")
vim.api.nvim_set_current_win(sidebar.containers.input.winid)
local sources = require("blink.cmp.sources.lib")
assert(vim.tbl_contains(sources.get_enabled_provider_ids("default"), "avante"))
assert(not vim.tbl_contains(sources.get_enabled_provider_ids("default"), "lsp"))
sidebar:close()
local Input = require("avante.ui.input")
local input = Input:new({
    provider = "snacks",
    title = "Avante input test",
    on_submit = function() end,
})
input:open()
local found = false
for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].filetype == "snacks_input" then
        found = true
    end
end
assert(found, "Snacks input not opened")
local Selector = require("avante.ui.selector")
Selector:new({
    provider = "snacks",
    title = "Avante selector test",
    items = { { id = "test", title = "Example" } },
    on_select = function() end,
}):open()
assert(#Snacks.picker.get() > 0, "Snacks picker not opened")
for _, picker in ipairs(Snacks.picker.get()) do
    picker:close()
end
print("Avante sidebar, Blink routing, Snacks input and picker passed")
vim.cmd("qa!")
