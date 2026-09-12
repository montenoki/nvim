-- 用隔离的 XDG_STATE_HOME 运行，不读取或修改真实系统主题。
vim.opt.rtp:prepend(vim.fn.getcwd())
local root = vim.env.THEME_PLUGIN_ROOT
    or vim.fn.expand("~/.local/share/nvim-test/lazy")
for _, name in ipairs({
    "kanagawa.nvim",
    "catppuccin",
    "retro-82.nvim",
    "nord.nvim",
    "gruvbox-material",
    "tokyonight.nvim",
    "ethereal.nvim",
    "everforest-nvim",
    "flexoki-neovim",
    "hackerman.nvim",
    "aether.nvim",
    "lumon.nvim",
    "matteblack.nvim",
    "miasma.nvim",
    "bamboo.nvim",
    "monokai-pro.nvim",
    "rose-pine",
    "ashen.nvim",
    "vantablack.nvim",
    "white.nvim",
}) do
    vim.opt.rtp:append(root .. "/" .. name)
end
vim.o.termguicolors = true
local theme = require("config.theme")
local state = require("config.state")
state.set("theme", "nord") -- 旧偏好不再参与主题选择，也不应被主题同步改写。
state.set("toggle.spell", true)
theme.setup()
assert(vim.g.colors_name == "default" and vim.o.background == "dark")
vim.fn.mkdir(vim.fn.fnamemodify(theme.system_path, ":h"), "p")
local function select(name)
    vim.fn.writefile({ name }, theme.system_path)
    vim.api.nvim_exec_autocmds("FocusGained", {})
end
for name, config in pairs(theme.system_themes) do
    select(name)
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
        assert(vim.g.colors_name == config[1], name)
    end
    assert(vim.o.background == (config[2] or "dark"), name)
end
-- 真实文件监听：不触发 FocusGained，也应跟随系统切换。
select("tokyo-night")
vim.fn.writefile({ "tokyo-day" }, theme.system_path)
assert(vim.wait(1000, function()
    return vim.g.colors_name == "tokyonight-day"
end, 10))
assert(vim.o.background == "light")
-- 模拟插件缺失，分别验证黑底和白底兜底。
theme.system_themes.missing_dark = { "nonexistent-ten-theme" }
theme.system_themes.missing_light = { "nonexistent-ten-theme", "light" }
select("missing_dark")
assert(vim.g.colors_name == "default" and vim.o.background == "dark")
select("missing_light")
assert(vim.g.colors_name == "default" and vim.o.background == "light")
select("unknown")
assert(vim.g.colors_name == "default" and vim.o.background == "dark")
vim.fn.delete(theme.system_path)
vim.api.nvim_exec_autocmds("FocusGained", {})
assert(vim.g.colors_name == "default" and vim.o.background == "dark")
assert(state.get("theme") == "nord" and state.get("toggle.spell") == true)
vim.api.nvim_exec_autocmds("VimLeavePre", {})
print("system theme tests passed")
