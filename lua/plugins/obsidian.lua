local workspaces =
    require("config.obsidian").workspaces(vim.fn.expand("~/obsidian"))

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    -- Obsidian requires at least one workspace during setup.
    enabled = #workspaces > 0,
    ft = "markdown",
    -- 笔记库选择器使用 Telescope，由实际使用它的插件声明依赖。
    dependencies = { "nvim-telescope/telescope.nvim" },
    cmd = "Obsidian",
    opts = {
        legacy_commands = false,
        frontmatter = { enabled = false },
        workspaces = workspaces,
        -- Let render-markdown.nvim handle note appearance.
        ui = { enable = false },
        picker = { name = "telescope.nvim" },
    },
}
