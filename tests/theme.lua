-- Run with an isolated XDG_STATE_HOME; THEME_PLUGIN_ROOT may point to test clones.
vim.opt.rtp:prepend(vim.fn.getcwd())
local root = vim.env.THEME_PLUGIN_ROOT or vim.fn.stdpath("data") .. "/lazy"
for _, name in ipairs({
    "kanagawa.nvim",
    "catppuccin",
    "retro-82.nvim",
    "nord.nvim",
    "gruvbox-material",
}) do
    vim.opt.rtp:append(root .. "/" .. name)
end
vim.opt.rtp:append(vim.fn.expand("~/.local/share/nvim/lazy/tokyonight.nvim"))
vim.o.termguicolors = true
vim.o.background = "dark"
vim.g.gruvbox_material_foreground = "material"
vim.g.gruvbox_material_background = "medium"

local state = require("config.state")
local theme = require("config.theme")
local function equal(actual, expected)
    if actual == "kanagawa" and expected:match("^kanagawa%-%w+$") then
        equal(
            require("kanagawa")._CURRENT_THEME,
            expected:match("^kanagawa%-(%w+)$")
        )
        return
    end
    assert(
        vim.deep_equal(actual, expected),
        vim.inspect({ actual = actual, expected = expected })
    )
end
local function settle()
    vim.wait(300, function()
        return false
    end, 10)
end
local function select(name)
    vim.fn.writefile({ name }, theme.system_path)
    settle()
end

equal(state.get("theme"), nil)
state.set("future_toggle", true)
state.set("theme", "nord")
equal(state.get("future_toggle"), true)
theme.setup()
equal(vim.g.colors_name, "nord") -- Local preference, absent system state.

vim.fn.mkdir(vim.fn.fnamemodify(theme.system_path, ":h"), "p")
select("kanagawa")
vim.api.nvim_exec_autocmds("FocusGained", {}) -- Discover a newly created directory.
equal(vim.g.colors_name, "kanagawa-wave")
equal(state.get("theme"), "nord") -- System sync never overwrites local preference.

for name, scheme in pairs(theme.system_themes) do
    select(name)
    equal(vim.g.colors_name, scheme) -- Actual filesystem notifications + plugin loading.
    local light = name == "tokyo-day"
        or name == "kanagawa-lotus"
        or name == "catppuccin-latte"
        or name == "gruvbox-light"
    equal(vim.o.background, light and "light" or "dark")
end
select("unknown")
equal(vim.g.colors_name, "nord")

vim.o.background = "light"
select("gruvbox")
equal(vim.o.background, "dark")
equal(vim.g.colors_name, "gruvbox-material")

vim.cmd.colorscheme("tokyonight-night")
settle()
equal(state.get("theme"), { name = "tokyonight-night", background = "dark" })
equal(state.get("future_toggle"), true)

-- A picker preview must not save; cancel restores the original theme.
_G.Snacks = { picker = {
    get = function()
        return { {} }
    end,
} }
vim.cmd.colorscheme("nord")
settle()
equal(state.get("theme"), { name = "tokyonight-night", background = "dark" })
vim.cmd.colorscheme("tokyonight-night")
_G.Snacks = nil

select("kanagawa")
equal(vim.g.colors_name, "kanagawa-wave")
vim.fn.delete(theme.system_path)
settle()
equal(vim.g.colors_name, "tokyonight-night")

vim.fn.writefile({ "broken json" }, state.path)
select("nord")
vim.fn.delete(theme.system_path)
settle()
equal(vim.g.colors_name, theme.default)

state.set("theme", "missing-theme")
select("kanagawa")
vim.fn.delete(theme.system_path)
settle()
equal(vim.g.colors_name, theme.default)

-- A same-name light scheme must survive system overrides and restoration.
vim.o.background = "light"
vim.cmd.colorscheme("gruvbox-material")
settle()
equal(state.get("theme"), { name = "gruvbox-material", background = "light" })
select("gruvbox")
equal(vim.o.background, "dark")
equal(state.get("theme"), { name = "gruvbox-material", background = "light" })
vim.fn.delete(theme.system_path)
settle()
equal(vim.g.colors_name, "gruvbox-material")
equal(vim.o.background, "light")

-- Invalid background values use the named variant's default.
state.set("theme", { name = "tokyonight-day", background = "invalid" })
select("nord")
vim.fn.delete(theme.system_path)
settle()
equal(vim.g.colors_name, "tokyonight-day")
equal(vim.o.background, "light")

-- Flush a selection even when exiting before the debounce expires.
vim.cmd.colorscheme("nord")
vim.api.nvim_exec_autocmds("VimLeavePre", {})
equal(state.get("theme"), { name = "nord", background = vim.o.background })
print("theme tests passed")
