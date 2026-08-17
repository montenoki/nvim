local platform = require("config.platform")

if not platform.nix_managed_tools then
    return {}
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            -- Parsers are provided on Neovim's runtimepath by Nix. Keeping this
            -- list empty prevents runtime downloads into stdpath("data").
            opts.ensure_installed = {}
        end,
    },
}
