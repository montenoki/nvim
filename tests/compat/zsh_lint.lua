-- 使用真实 Zsh 和 nvim-lint，验证 libuv stdin 接线及诊断清理。
local plugins = vim.env.NVIM_TEST_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
vim.opt.rtp:append(plugins .. "/nvim-lint")
assert(vim.fn.executable("zsh") == 1, "zsh is required")
local lint = require("lint")
local spec = dofile("lua/plugins/languages/bash.lua")[3]
lint.linters.zsh =
    vim.tbl_deep_extend("force", lint.linters.zsh, spec.opts.linters.zsh)
local namespace = lint.get_namespace("zsh")
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "if then", "" })
lint.try_lint("zsh")
assert(
    vim.wait(5000, function()
        return #vim.diagnostic.get(0, { namespace = namespace }) > 0
    end),
    "Zsh stdin syntax error was not reported"
)
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "print -r -- hello" })
lint.try_lint("zsh")
assert(
    vim.wait(5000, function()
        return #vim.diagnostic.get(0, { namespace = namespace }) == 0
    end),
    "Zsh diagnostics did not clear after correction"
)
print("PASS: real Zsh checks unsaved stdin and clears corrected diagnostics")
