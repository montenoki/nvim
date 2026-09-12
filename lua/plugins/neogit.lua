local keymapping = require("keymapping")
return {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    keys = {
        { keymapping.neogit, "<CMD>Neogit<CR>", desc = "NeoGit" },
    },
}
