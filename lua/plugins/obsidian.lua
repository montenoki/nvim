local M = {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
}

-- 尝试加载本地配置
local function load_local_config()
    local local_config_path = vim.fn.stdpath("config")
        .. "/lua/local/settings.lua"
    local ok, local_config = pcall(dofile, local_config_path)
    if ok then
        return local_config
    else
        -- 返回默认配置
        return {
            workspaces = {
                {
                    name = "default",
                    path = "~/vaults/default",
                },
            },
        }
    end
end

function M.config()
    local local_settings = load_local_config()

    return {
        workspaces = local_settings.workspaces,
        -- 其他通用配置...
    }
end

return M
