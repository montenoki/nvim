-- 在 nvim-test 中用隔离 XDG_STATE_HOME / XDG_CACHE_HOME 运行。
require("lazy").load({ plugins = { "lualine.nvim" } })
local display = require("config.statusline")
local opts = require("lualine").get_config()
assert(#opts.sections.lualine_z == 9)
assert(#opts.winbar.lualine_c == 1) -- Navic 仍由独立配置追加。
local function count(components, name)
    local n = 0
    for _, component in ipairs(components) do
        if component[1] == name then
            n = n + 1
        end
    end
    return n
end
assert(count(opts.sections.lualine_b, "venv-selector") == 1)
assert(count(opts.sections.lualine_c, "diff") == 0)
assert(count(opts.winbar.lualine_x, "diff") == 1)

assert(display.shorten("src/main.lua", 30) == "src/main.lua")
local long = "项目/很长的目录/另外一个目录/组件/main.lua"
local shortened = display.shorten(long, 26)
assert(shortened:find("…", 1, true) and vim.endswith(shortened, "main.lua"))
assert(vim.fn.strdisplaywidth(shortened) <= 26)
assert(display.shorten("long_filename.lua", 5) == "long_filename.lua")
vim.api.nvim_buf_set_name(0, vim.fn.getcwd() .. "/lua/100%文件.lua")
assert(display.path():find("100%%文件.lua", 1, true))
vim.bo.expandtab, vim.bo.shiftwidth = true, 4
assert(display.indent() == "空格 4")
vim.bo.expandtab, vim.bo.tabstop = false, 8
assert(display.indent() == "Tab 8")
vim.bo.fileencoding = "utf-8"
assert(display.encoding() == "")
vim.bo.fileencoding = "latin1"
assert(display.encoding() == "LATIN1")
vim.bo.fileformat = "unix"
assert(display.fileformat() == "")
vim.bo.fileformat = "dos"
assert(display.fileformat() == "CRLF")
vim.api.nvim_buf_set_lines(0, 0, -1, false, { "one", "two", "three" })
vim.cmd("normal! ggVj")
assert(display.selection() == "选中 2 行")
vim.cmd("normal! \27")
assert(display.selection() == "")

-- 两种明暗下所有生成颜色都必须是有效颜色。
for _, background in ipairs({ "dark", "light" }) do
    vim.o.background = background
    vim.cmd.colorscheme("default")
    assert(opts.options.theme == "auto")
    for _, sections in pairs(require("lualine.utils.loader").load_theme("auto")) do
        for _, color in pairs(sections) do
            vim.api.nvim_set_hl(
                0,
                "TenStatuslineTest",
                { fg = color.fg, bg = color.bg, bold = color.gui == "bold" }
            )
        end
    end
    for _, component in ipairs(opts.sections.lualine_z) do
        vim.api.nvim_set_hl(0, "TenStatuslineTest", component.color())
    end
end
assert(display.lsp() == " —")
assert(#opts.sections.lualine_c == 4) -- 不再显示 Noice 按键组合。
assert(
    opts.options.component_separators.left
        == opts.options.component_separators.right
)
-- 实际执行点击回调，确认没有 LspInfo 命令依赖。
vim.bo.modified = false
assert(opts.sections.lualine_x[1][1] == display.selection)
assert(opts.sections.lualine_x[4][1] == display.lsp)
assert(opts.sections.lualine_y[1][1] == "filetype")
assert(opts.sections.lualine_y[#opts.sections.lualine_y][1] == "location")
assert(pcall(opts.sections.lualine_x[4].on_click))
print("statusline layout, colors, fields and LSP click passed")
vim.cmd("qa!")
