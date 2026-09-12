local obsidian = require("config.obsidian")

-- 解析真实目录，避免通过符号链接打开笔记时绕过笔记库排除。
-- 新文件尚不存在时，先解析父目录。
local function real_path(path)
    return vim.fs.normalize(
        vim.uv.fs_realpath(path)
            or vim.fs.joinpath(
                vim.uv.fs_realpath(vim.fs.dirname(path)) or vim.fs.dirname(path),
                vim.fs.basename(path)
            )
    )
end

return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            servers = {
                marksman = {
                    -- Nix 环境需在 Neovim 的 extraPackages 中提供 pkgs.marksman。
                    -- 只接入普通 Markdown；笔记库沿用 Obsidian 插件。
                    root_dir = function(bufnr, on_dir)
                        local name = vim.api.nvim_buf_get_name(bufnr)
                        if name == "" then
                            return
                        end
                        local path = real_path(name)
                        -- 与 Obsidian 插件复用同一套笔记库发现规则。
                        for _, workspace in
                            ipairs(
                                obsidian.workspaces(vim.fn.expand("~/obsidian"))
                            )
                        do
                            local root = real_path(workspace.path)
                            if
                                path == root
                                or path:sub(1, #root + 1) == root .. "/"
                            then
                                -- 不调用 on_dir，Neovim 就不会为此文件连接 Marksman。
                                return
                            end
                        end
                        -- 优先使用项目根目录；零散 Markdown 使用所在目录。
                        on_dir(
                            vim.fs.root(path, { ".marksman.toml", ".git" })
                                or vim.fs.dirname(path)
                        )
                    end,
                },
            },
        },
    },
}
