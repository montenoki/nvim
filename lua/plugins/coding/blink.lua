return {
    "saghen/blink.cmp",
    dependencies = {
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            dependencies = { "rafamadriz/friendly-snippets" },
            opts = { delete_check_events = "TextChanged,TextChangedI" },
            config = function(_, opts)
                require("luasnip").setup(opts)
                -- 复用现有片段库，以及配置目录下的自定义 VS Code 格式片段。
                require("luasnip.loaders.from_vscode").lazy_load()
                require("luasnip.loaders.from_vscode").lazy_load({
                    paths = { vim.fn.stdpath("config") .. "/snippets" },
                })
            end,
        },
    },
    opts = {
        snippets = { preset = "luasnip" },
        completion = {
            -- 填写代码片段时，Tab/Shift-Tab 跳转填写位置，不自动弹出补全。
            -- 需要补全时按 Ctrl-Space，再用 Tab 选候选、Enter 确认。
            trigger = { show_in_snippet = false },
            list = { selection = { preselect = false } },
        },
        keymap = {
            ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },

            ["<Up>"] = { "fallback" },
            ["<Down>"] = { "fallback" },
            ["<C-p>"] = { "fallback" },
            ["<C-n>"] = { "fallback" },
        },
    },
}
