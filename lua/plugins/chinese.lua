local keymapping = require("keymapping")

if true then
    return {
        {
            "hotoo/pangu.vim",
            lazy = true,
            keys = {
                {
                    keymapping.format_cjk,
                    "<CMD>PanguAll<CR>",
                    { desc = "Format CJK" },
                },
            },
        },
    }
else
    return {
        {
            "noearc/jieba.nvim",
            dependencies = { "noearc/jieba-lua" },
            opts = {},
        },
        { "noearc/leap-zh.nvim", dependencies = { "noearc/jieba-lua" } },
    }
end
