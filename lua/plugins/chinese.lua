if true then
    return {}
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
