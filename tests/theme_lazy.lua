-- 验证系统主题可以触发 lazy.nvim 按需加载，不安装或更新插件。
vim.go.loadplugins = true
vim.opt.rtp:prepend(vim.fn.getcwd())
local root = vim.env.THEME_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
vim.opt.rtp:prepend(root .. "/lazy.nvim")
local spec = require("plugins.themes")
spec[#spec + 1] = { "catppuccin/nvim", name = "catppuccin", lazy = true }
require("lazy").setup({
    spec = spec,
    root = root,
    lockfile = vim.fn.getcwd() .. "/lazy-lock.json",
    install = { missing = false },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = { rtp = { reset = false } },
})
vim.wait(200, function()
    return false
end)
local theme = require("config.theme")
vim.fn.mkdir(vim.fn.fnamemodify(theme.system_path, ":h"), "p")
vim.fn.writefile({ "kanagawa" }, theme.system_path)
theme.setup()
assert(require("kanagawa")._CURRENT_THEME == "wave")
for name, config in pairs(theme.system_themes) do
    vim.fn.writefile({ name }, theme.system_path)
    vim.api.nvim_exec_autocmds("FocusGained", {})
    assert(vim.o.background == (config[2] or "dark"), name)
    if config[1]:match("^kanagawa") then
        assert(
            require("kanagawa")._CURRENT_THEME
                == config[1]:match("kanagawa%-(.*)")
        )
    elseif config[1] == "flexoki-light" then
        assert(vim.g.colors_name == "flexoki" and vim.o.background == "light")
    elseif config[1] == "rose-pine-dawn" then
        assert(vim.g.colors_name == "rose-pine" and vim.o.background == "light")
    elseif config[1] == "monokai-pro-ristretto" then
        assert(vim.g.colors_name == "monokai-pro")
        assert(require("monokai-pro.config").get().filter == "ristretto")
    else
        assert(
            vim.g.colors_name == config[1],
            name .. " actual=" .. tostring(vim.g.colors_name)
        )
    end
end
assert(vim.fn.filereadable(require("config.state").path) == 0)
vim.api.nvim_exec_autocmds("VimLeavePre", {})
print("system theme lazy loading tests passed")
