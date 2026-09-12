local filetypes = require("config.jieba").filetypes

return {
    {
        "kkew3/jieba.vim",
        -- 使用稳定发布分支；首次打开支持的文件类型时加载插件。
        branch = "release",
        ft = filetypes,
        dependencies = { "tpope/vim-repeat" },
        -- 优先下载预编译分词库，失败时由上游安装脚本尝试本地编译。
        build = ":call jieba_vim#install()",
        keys = function()
            local keys = {}
            -- 只接管小写按词动作，保留 W/B/E 等原生大范围移动。
            for _, motion in ipairs({ "w", "b", "e", "ge", "iw", "aw" }) do
                keys[#keys + 1] = {
                    motion,
                    "<Plug>(Jieba_" .. motion .. ")",
                    mode = #motion == 2 and motion ~= "ge" and { "x" }
                        or { "n", "x", "o" },
                    ft = filetypes,
                    desc = "Chinese word " .. motion,
                }
            end
            -- 操作符等待模式中的 iw/aw 单独处理，以兼容 mini.surround。
            for _, motion in ipairs({ "iw", "aw" }) do
                keys[#keys + 1] = {
                    motion,
                    function()
                        return require("config.jieba").operator_textobject(motion)
                    end,
                    mode = "o",
                    ft = filetypes,
                    expr = true,
                    desc = "Chinese word " .. motion,
                }
            end
            return keys
        end,
    },
}
