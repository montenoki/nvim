-- 主题只跟随系统，不读取或保存 Neovim 自己的主题偏好。
local M = {}

-- 系统名称、Neovim 配色、明暗模式逐列对齐；同一家族的深浅变体相邻。
---@type table<string, { colorscheme: string, background: "dark"|"light" }>
-- stylua: ignore
M.system_themes = {
    -- 已接入系统的主题。
    ["tokyo-night"]      = { colorscheme = "tokyonight-night"     , background = "dark"  },
    ["tokyo-day"]        = { colorscheme = "tokyonight-day"       , background = "light" },

    ["kanagawa"]         = { colorscheme = "kanagawa-wave"        , background = "dark"  },
    ["kanagawa-lotus"]   = { colorscheme = "kanagawa-lotus"       , background = "light" },

    ["catppuccin-mocha"] = { colorscheme = "catppuccin-mocha"     , background = "dark"  },
    ["catppuccin-latte"] = { colorscheme = "catppuccin-latte"     , background = "light" },

    ["gruvbox"]          = { colorscheme = "gruvbox-material"     , background = "dark"  },
    ["gruvbox-light"]    = { colorscheme = "gruvbox-material"     , background = "light" },

    ["nord"]             = { colorscheme = "nord"                 , background = "dark"  },
    ["retro-82"]         = { colorscheme = "retro-82"             , background = "dark"  },

    -- 预留映射：Neovim 已有配色，系统侧尚未接入这些名称。
    ["ethereal"]         = { colorscheme = "ethereal"             , background = "dark"  },
    ["everforest"]       = { colorscheme = "everforest"           , background = "dark"  },
    ["flexoki-light"]    = { colorscheme = "flexoki-light"        , background = "light" },
    ["hackerman"]        = { colorscheme = "hackerman"            , background = "dark"  },
    ["lumon"]            = { colorscheme = "lumon"                , background = "dark"  },
    ["matte-black"]      = { colorscheme = "matteblack"           , background = "dark"  },
    ["miasma"]           = { colorscheme = "miasma"               , background = "dark"  },
    ["osaka-jade"]       = { colorscheme = "bamboo"               , background = "dark"  },
    ["ristretto"]        = { colorscheme = "monokai-pro-ristretto", background = "dark"  },
    ["rose-pine"]        = { colorscheme = "rose-pine-dawn"       , background = "light" },
    ["solitude"]         = { colorscheme = "ashen"                , background = "dark"  },
    ["vantablack"]       = { colorscheme = "vantablack"           , background = "dark"  },
    ["white"]            = { colorscheme = "white"                , background = "light" },
}

-- 系统文件记录实际生效的主题变体，与 Neovim 自身的 state 目录无关。
local state_home = vim.env.XDG_STATE_HOME
if not state_home or state_home == "" then
    state_home = vim.fn.expand("~/.local/state")
end
M.system_path = state_home .. "/ten-theme/name"
local started, watcher

local function sync()
    local ok, lines = pcall(vim.fn.readfile, M.system_path)
    local name = ok
            and type(lines) == "table"
            and vim.trim(table.concat(lines, ""))
        or ""
    local theme = M.system_themes[name]
    local background = theme and theme.background or "dark"
    vim.o.background = background
    if theme and pcall(vim.cmd.colorscheme, theme.colorscheme) then
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
            function(err, filename)
                -- 忽略壁纸和预览元数据等无关变化；平台未提供文件名时仍同步。
                if
                    not err
                    and (
                        not filename
                        or filename == vim.fs.basename(M.system_path)
                    )
                then
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
