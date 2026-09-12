local platform = require("config.platform")

if not platform.nix_managed_tools then
    return {}
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        -- 解析器由 Nix 更新，插件更新后不再自动执行 TSUpdate。
        build = false,
        opts = function(_, opts)
            -- Nix 通过 runtimepath 提供解析器，清空安装清单以避免重复下载。
            opts.ensure_installed = {}
        end,
    },
}
