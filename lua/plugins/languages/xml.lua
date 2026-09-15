return {
    "neovim/nvim-lspconfig",
    -- LemMinX 同时提供格式化与 XSD 校验，无需额外的 XML 格式化进程。
    opts = { servers = { lemminx = {} } },
}
