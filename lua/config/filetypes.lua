local M = {}

function M.setup()
    -- Compose LSP 要求专属 filetype，Neovim 默认只识别为 YAML。
    vim.filetype.add({
        pattern = {
            ["compose%.ya?ml"] = "yaml.docker-compose",
            ["compose%..+%.ya?ml"] = "yaml.docker-compose",
            ["docker%-compose%.ya?ml"] = "yaml.docker-compose",
            ["docker%-compose%..+%.ya?ml"] = "yaml.docker-compose",
        },
    })
end

return M
