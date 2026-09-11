-- Run with isolated XDG_STATE_HOME and XDG_CACHE_HOME.
vim.go.loadplugins = true
vim.opt.rtp:prepend(vim.fn.getcwd())
local root = vim.fn.expand("~/.local/share/nvim/lazy")
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

local schemes = {
    { "tokyonight-night", "dark" },
    { "catppuccin-mocha", "dark" },
    { "catppuccin-latte", "light" },
    { "kanagawa-wave", "dark" },
    { "nord", "dark" },
    { "gruvbox-material", "dark" },
    { "retro-82", "dark" },
    { "ethereal", "dark" },
    { "everforest", "dark" },
    { "flexoki-light", "light" },
    { "hackerman", "dark" },
    { "lumon", "dark" },
    { "matteblack", "dark" },
    { "miasma", "dark" },
    { "bamboo", "dark" },
    { "monokai-pro-ristretto", "dark" },
    { "rose-pine-dawn", "light" },
    { "ashen", "dark" },
    { "vantablack", "dark" },
    { "white", "light" },
}

-- Repeat in reverse to catch palette state leaking between switches.
for pass = 1, 2 do
    for index = 1, #schemes do
        local item = schemes[pass == 1 and index or #schemes - index + 1]
        vim.o.background = item[2]
        vim.cmd.colorscheme(item[1])
        assert(vim.o.background == item[2], item[1] .. ": wrong background")
        local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
        assert(normal.fg and normal.bg, item[1] .. ": missing Normal colors")
        assert(normal.fg ~= normal.bg, item[1] .. ": unreadable Normal colors")
    end
end
print("PASS: " .. #schemes .. " theme palettes, forward and reverse lazy loading")
