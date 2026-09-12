return {
    {
        "nvim-mini/mini.surround",
        opts = function(_, opts)
            -- 移除上游 Extra 遗留的失效键位声明。
            opts.mappings.update_n_lines = nil
        end,
    },
}
