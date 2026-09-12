return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            -- 在活动窗口顶部显示当前代码符号路径，颜色随顶部栏背景调整。
            -- Navic 的 LSP 接入、图标和显示层数由 LazyVim Extra 配置。
            table.insert(
                opts.winbar.lualine_c,
                { "navic", color_correction = "dynamic" }
            )
        end,
    },
}
