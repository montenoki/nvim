return {
    {
        "linux-cultist/venv-selector.nvim",
        -- 缓存自动恢复环境前，先注册 Python LSP 配置。
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "lualine.nvim",
        opts = function(_, opts)
            -- 环境属于项目上下文，紧跟项目与分支，不混入中央临时提示。
            table.insert(opts.sections.lualine_b, {
                -- 插件直接读取当前环境名，无环境时隐藏；保留点击选择环境。
                "venv-selector",
                cond = function()
                    return vim.bo.filetype == "python"
                        and package.loaded["venv-selector"] ~= nil
                end,
                on_click = function()
                    vim.cmd.VenvSelect()
                end,
            })
        end,
    },
}
