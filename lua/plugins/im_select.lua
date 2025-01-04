return {
    {
        "keaising/im-select.nvim",
        opts = function()
            if vim.fn.has("win32") == 1 then
                return {
                    default_im_select = "1033",
                    default_command = "im-select.exe",
                    keep_quiet_on_no_binary = true,
                }
            elseif vim.fn.has("mac") == 1 then
                return {
                    default_im_select = "com.apple.keylayout.ABC",
                    default_command = "im-select",
                    keep_quiet_on_no_binary = true,
                }
            else -- Linux
                return {
                    default_im_select = "keyboard-us",
                    default_command = "fcitx5-remote",
                    keep_quiet_on_no_binary = true,
                }
            end
        end,
    },
}
