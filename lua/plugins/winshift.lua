local keymapping = require("keymapping")
return {
    "sindrets/winshift.nvim",
    keys = {
        {
            keymapping.winshift,
            "<CMD>WinShift<CR>",
            desc = "Window Manager",
        },
    },
}
