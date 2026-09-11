return {
    {
        "kkew3/jieba.vim",
        branch = "release",
        ft = "markdown",
        dependencies = { "tpope/vim-repeat" },
        build = ":call jieba_vim#install()",
        init = function()
            vim.g.jieba_vim_lazy = 1
            -- Keep the plugin from creating global word mappings.
            vim.g.jieba_vim_keymap = 0
        end,
        keys = function()
            local keys = {}
            for _, motion in ipairs({ "w", "b", "e", "ge", "iw", "aw" }) do
                keys[#keys + 1] = {
                    motion,
                    "<Plug>(Jieba_" .. motion .. ")",
                    mode = #motion == 2 and motion ~= "ge" and { "x", "o" }
                        or { "n", "x", "o" },
                    ft = "markdown",
                    desc = "Chinese word " .. motion,
                }
            end
            return keys
        end,
    },
}
