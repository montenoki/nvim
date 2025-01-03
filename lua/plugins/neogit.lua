local keymapping = require("keymapping")
return {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { keymapping.neogit, "<CMD>Neogit<CR>", desc = "NeoGit" },
    },
}
