-- 主题只跟随系统，不读取或保存 Neovim 自己的主题偏好。
local M = {}

-- 系统文件记录实际生效的明暗变体；未指定明暗的条目均为深色。
M.system_themes = {
    ["tokyo-night"] = { "tokyonight-night" },
    kanagawa = { "kanagawa-wave" },
    ["retro-82"] = { "retro-82" },
    nord = { "nord" },
    gruvbox = { "gruvbox-material" },
    ["gruvbox-light"] = { "gruvbox-material", "light" },
    ["tokyo-day"] = { "tokyonight-day", "light" },
    ["kanagawa-lotus"] = { "kanagawa-lotus", "light" },
    ["catppuccin-mocha"] = { "catppuccin-mocha" },
    ["catppuccin-latte"] = { "catppuccin-latte", "light" },
    -- 预留系统主题名称；系统侧添加这些名称后即可直接同步。
    ethereal = { "ethereal" },
    everforest = { "everforest" },
    ["flexoki-light"] = { "flexoki-light", "light" },
    hackerman = { "hackerman" },
    lumon = { "lumon" },
    ["matte-black"] = { "matteblack" },
    miasma = { "miasma" },
    ["osaka-jade"] = { "bamboo" },
    ristretto = { "monokai-pro-ristretto" },
    ["rose-pine"] = { "rose-pine-dawn", "light" },
    solitude = { "ashen" },
    vantablack = { "vantablack" },
    white = { "white", "light" },
}
local state_home = vim.env.XDG_STATE_HOME
if not state_home or state_home == "" then
    state_home = vim.fn.expand("~/.local/state")
end
M.system_path = state_home .. "/ten-theme/name"
local started, watcher

local function sync()
    local ok, lines = pcall(vim.fn.readfile, M.system_path)
    local name = ok and vim.trim(table.concat(lines, "")) or ""
    local theme = M.system_themes[name]
    local background = theme and theme[2] or "dark"
    vim.o.background = background
    if theme and pcall(vim.cmd.colorscheme, theme[1]) then
        return
    end
    -- 插件不可用时使用内置配色的黑底/白底版本，不再依赖额外插件。
    -- 系统信息缺失或无法识别时固定退回深色。
    vim.o.background = background
    vim.cmd.colorscheme("default")
end

function M.setup()
    if started or vim.g.vscode then
        return
    end
    started = true
    sync()
    local group = vim.api.nvim_create_augroup("TEN_theme", { clear = true })
    local function watch()
        if watcher then
            return
        end
        local handle = vim.uv.new_fs_event()
        if not handle then
            return
        end
        -- 监听父目录，兼容系统通过重命名替换主题文件。
        local ok = handle:start(
            vim.fn.fnamemodify(M.system_path, ":h"),
            {},
            function(err)
                if not err then
                    vim.schedule(sync)
                end
            end
        )
        if ok then
            watcher = handle
        else
            handle:close()
        end
    end
    watch()
    vim.api.nvim_create_autocmd("FocusGained", {
        group = group,
        -- 允许 colorscheme 触发 lazy.nvim 的 ColorSchemePre 按需加载。
        nested = true,
        callback = function()
            -- 目录可能在启动后才创建；恢复焦点时也重新确认系统配色。
            watch()
            sync()
        end,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
            if watcher then
                watcher:stop()
                watcher:close()
                watcher = nil
            end
        end,
    })
end

return M
