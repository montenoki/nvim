return {
    {
        "s1n7ax/nvim-window-picker",
        version = "2.*",
        -- 用悬浮大字母标记可选窗口，快捷键和 Neo-tree 共用此设置。
        opts = { hint = "floating-big-letter" },
        keys = {
            {
                "<leader>wp",
                function()
                    local picked_window_id =
                        require("window-picker").pick_window()
                    if picked_window_id then
                        vim.api.nvim_set_current_win(picked_window_id)
                    end
                end,
                desc = "选择窗口",
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        opts = {
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        -- 从目录树打开文件后，自动收起目录树。
                        require("neo-tree.command").execute({ action = "close" })
                    end,
                },
            },
            window = {
                mappings = {
                    -- 先选择目标窗口，再打开文件或创建分屏。
                    ["v"] = {
                        "vsplit_with_window_picker",
                        desc = "选择窗口并垂直分屏",
                    },
                    ["s"] = {
                        "split_with_window_picker",
                        desc = "选择窗口并水平分屏",
                    },
                    ["S"] = "none",
                    ["<CR>"] = {
                        "open_with_window_picker",
                        desc = "选择窗口并打开文件",
                    },
                },
            },
            default_component_configs = {
                git_status = {
                    symbols = {
                        -- 自定义变更图标，其余沿用默认值。
                        added = "",
                        deleted = "",
                        modified = "",
                        renamed = "",
                        -- 暂存状态图标：staged 特意覆盖 LazyVim 的默认设置。
                        unstaged = "󰢤",
                        staged = "",
                    },
                },
            },
        },
    },
}
