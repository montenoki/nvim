-- 使用真实 Promise，验证折叠回退链；不连接服务器或下载插件。
vim.opt.rtp:prepend(vim.fn.getcwd())
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
vim.opt.rtp:append(plugins .. "/promise-async")
local spec = dofile("lua/plugins/editor/ufo.lua")[1]
local provider = spec.opts.provider_selector(0, "text", "")
-- 通过真实 UFO 检查 provider 和 Promise 接口及无解析器时的回退异常。
vim.opt.rtp:append(plugins .. "/nvim-ufo")
vim.cmd.enew()
vim.bo.filetype = "nvim_test_without_parser"
vim.api.nvim_buf_set_lines(
    0,
    0,
    -1,
    false,
    { "plain text", "    no indent fallback" }
)
local ufo = require("ufo")
ufo.setup(spec.opts)
ufo.attach(0)
local done, result, err = false
provider(vim.api.nvim_get_current_buf()):thenCall(function(value)
    result, done = value, true
end, function(reason)
    err, done = reason, true
end)
assert(
    vim.wait(5000, function()
        return done
    end),
    "real UFO provider timeout"
)
assert(err == nil, tostring(err))
assert(type(result) == "table" and vim.tbl_isempty(result), vim.inspect(result))
print("PASS: real UFO without LSP/parser returns no folds")
