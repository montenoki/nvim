-- 使用真实 Promise，验证折叠回退链；不连接服务器或下载插件。
vim.opt.rtp:prepend(vim.fn.getcwd())
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
vim.opt.rtp:append(plugins .. "/promise-async")
local promise = require("promise")
local spec = dofile("lua/plugins/editor/ufo.lua")[1]
local select = spec.opts.provider_selector
assert(select(0, "text", "nofile") == "")
assert(select(0, "git", "") == "")
local provider = select(0, "text", "")
local function check(lsp, ts, expected, failure, calls_expected)
    local calls = {}
    package.loaded.ufo = {
        getFolds = function(buf, name)
            assert(buf == 7)
            calls[#calls + 1] = name
            return (name == "lsp" and lsp or ts)()
        end,
    }
    local done, result, err = false
    provider(7):thenCall(function(value)
        result = value
        done = true
    end, function(reason)
        err = reason
        done = true
    end)
    assert(vim.wait(2000, function()
        return done
    end))
    if failure then
        assert(tostring(err):find(failure, 1, true), tostring(err))
    else
        assert(
            err == nil and vim.deep_equal(result, expected),
            vim.inspect({ result, err })
        )
    end
    assert(vim.deep_equal(calls, calls_expected), vim.inspect(calls))
end
local ranges = { { startLine = 0, endLine = 3 } }
local function success()
    return promise.resolve(ranges)
end
local function missing()
    return promise.reject("UfoFallbackException")
end
local function sync_missing()
    error("UfoFallbackException")
end
local function broken()
    error("real parser error")
end
check(success, broken, ranges, nil, { "lsp" })
check(function()
    return {}
end, broken, {}, nil, { "lsp" })
check(missing, success, ranges, nil, { "lsp", "treesitter" })
check(sync_missing, sync_missing, {}, nil, { "lsp", "treesitter" })
check(missing, missing, {}, nil, { "lsp", "treesitter" })
check(missing, broken, nil, "real parser error", { "lsp", "treesitter" })
check(broken, success, nil, "real parser error", { "lsp" })
package.loaded.ufo = nil
print(
    "PASS: LSP success/empty, synchronous/asynchronous fallback, both unavailable, real errors propagated"
)

-- 再使用真实 UFO，避免模拟异常掩盖上游接口或异常名称的变化。
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
