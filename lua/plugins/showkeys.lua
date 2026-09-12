return {
    "nvzone/showkeys",
    event = "VeryLazy",
    cmd = "ShowkeysToggle",
    -- 使用默认的右下角浮窗；不抢焦点，也不参与窗口切换。
    opts = { winopts = { focusable = false } },
    config = function(_, opts)
        require("showkeys").setup(opts)
        local toggles = require("config.toggles")
        -- 底栏与命令共用持久化开关，插件加载完成后再恢复选择。
        vim.api.nvim_create_user_command("ShowkeysToggle", function()
            toggles.toggle("showkeys")
        end, {
            desc = "切换按键浮窗（记住选择）",
            force = true,
        })
        toggles.restore_showkeys()
    end,
}
