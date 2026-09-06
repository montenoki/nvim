vim.go.loadplugins = true
vim.opt.rtp:prepend(vim.fn.getcwd())
vim.opt.rtp:prepend(vim.fn.expand("~/.local/share/nvim/lazy/lazy.nvim"))
local spec = require("plugins.themes")
spec[#spec + 1] = { "catppuccin/nvim", name = "catppuccin", lazy = true }
require("lazy").setup({
    spec = spec,
    root = vim.fn.expand("~/.local/share/nvim/lazy"),
    lockfile = vim.fn.getcwd() .. "/lazy-lock.json",
    install = { missing = false },
    checker = { enabled = false },
    change_detection = { enabled = false },
    performance = { rtp = { reset = false } },
})
local theme = require("config.theme")
theme.setup()
if vim.env.THEME_TEST_MODE == "write" then
    assert(vim.g.colors_name == "tokyonight-night")
    vim.cmd.colorscheme("kanagawa-dragon")
    vim.api.nvim_exec_autocmds("VimLeavePre", {})
    assert(
        vim.deep_equal(
            require("config.state").get("theme"),
            { name = "kanagawa-dragon", background = "dark" }
        )
    )
elseif vim.env.THEME_TEST_MODE == "system" then
    assert(require("kanagawa")._CURRENT_THEME == "wave")
    assert(
        vim.deep_equal(
            require("config.state").get("theme"),
            { name = "kanagawa-dragon", background = "dark" }
        )
    )
elseif vim.env.THEME_TEST_MODE == "light-write" then
    vim.o.background = "light"
    vim.cmd.colorscheme("gruvbox-material")
    vim.api.nvim_exec_autocmds("VimLeavePre", {})
    assert(
        vim.deep_equal(
            require("config.state").get("theme"),
            { name = "gruvbox-material", background = "light" }
        )
    )
elseif vim.env.THEME_TEST_MODE == "light-read" then
    assert(vim.g.colors_name == "gruvbox-material")
    assert(vim.o.background == "light")
else
    assert(require("kanagawa")._CURRENT_THEME == "dragon")
    for _, scheme in pairs(theme.system_themes) do
        vim.cmd.colorscheme(scheme)
    end
    local plugins = require("lazy.core.config").plugins
    for _, name in ipairs({
        "kanagawa.nvim",
        "retro-82.nvim",
        "nord.nvim",
        "gruvbox-material",
        "tokyonight.nvim",
    }) do
        assert(plugins[name]._.loaded, name .. " was not lazy-loaded")
    end
end
print("lazy integration passed: " .. vim.env.THEME_TEST_MODE)
