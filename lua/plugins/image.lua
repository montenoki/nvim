return {
    "3rd/image.nvim",
    ft = "markdown",
    -- Use ImageMagick from the application environment, without LuaRocks.
    build = false,
    opts = {
        backend = "sixel",
        integrations = {
            markdown = {
                enabled = true,
                filetypes = { "markdown" },
                download_remote_images = false,
                only_render_image_at_cursor = true,
            },
            asciidoc = { enabled = false },
            neorg = { enabled = false },
            typst = { enabled = false },
            syslang = { enabled = false },
        },
        hijack_file_patterns = {},
    },
}
