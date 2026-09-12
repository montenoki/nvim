-- 首次启动时安装 lazy.nvim，后续直接使用本地副本。
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    spec = {
        -- 先加载 LazyVim 的插件，再应用本地补充和覆盖。
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- lazy.nvim 不会递归扫描任意子目录；新增分类时在这里登记。
        { import = "plugins.coding" },
        { import = "plugins.editor" },
        { import = "plugins.ui" },
        -- 语言配置最后补充，保留 Python 向底栏追加的虚拟环境组件。
        { import = "plugins.languages" },
    },
    defaults = {
        -- 不按发布标签选择版本；锁文件仍用于安装和恢复，不会在启动时自动升级。
        version = false,
    },
    git = {
        -- 此超时也用于插件构建，为 Avante 的 Rust 库编译预留时间。
        timeout = 1200,
    },
    -- 首次安装期间的临时配色，日常主题由 config.ui.theme 跟随系统设置。
    install = { colorscheme = { "tokyonight", "habamax" } },
    checker = {
        enabled = true, -- 定期检查可用更新，不自动升级。
        notify = false, -- 在 Lazy 界面查看结果，不弹出通知。
    },
    performance = {
        rtp = {
            -- 关闭不使用的内置运行时插件。
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
}

local platform = require("config.platform")
if platform.nix_managed_tools then
    -- 当前插件无需 LuaRocks，Nix 管理工具时禁止额外安装 Lua 包管理环境。
    opts.rocks = { enabled = false }

    -- 通过 lazy.nvim 的入口接入解析器和查询文件，确保插件初始化时即可找到。
    local parser_rtp = vim.env.NVIM_NIX_PARSER_RTP
    if parser_rtp and parser_rtp ~= "" then
        opts.performance.rtp.paths = { parser_rtp }
    end
end

local config_dir = vim.fn.stdpath("config")
local real_config_dir = vim.uv.fs_realpath(config_dir) or config_dir
-- 仅 Nix store 中的只读配置使用运行副本；源码目录（包括 nvim-test 软链接）
-- 直接使用仓库锁文件，让插件更新产生的版本变更可以正常提交。
if platform.nix_managed_config and real_config_dir:match("^/nix/store/") then
    local source_lockfile = config_dir .. "/lazy-lock.json"
    local state_dir = vim.fn.stdpath("state") .. "/lazy"
    local state_lockfile = state_dir .. "/lazy-lock.json"

    vim.fn.mkdir(state_dir, "p")

    -- 以部署的锁文件为准同步运行副本；这不会自动恢复已安装插件的版本，
    -- 如需恢复版本，执行 :Lazy restore。
    local source_lines = vim.fn.readfile(source_lockfile)
    local state_lines = vim.fn.filereadable(state_lockfile) == 1
            and vim.fn.readfile(state_lockfile)
        or {}
    if table.concat(source_lines, "\n") ~= table.concat(state_lines, "\n") then
        vim.fn.writefile(source_lines, state_lockfile)
    end

    opts.lockfile = state_lockfile
end

require("lazy").setup(opts)
