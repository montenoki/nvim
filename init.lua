-- 启动入口：先设置环境和文件类型，再加载 lazy.nvim、LazyVim 及插件。
local platform = require("config.platform")
if platform.nix_managed_tools then
    -- Nix 管理工具时，关闭当前未使用的 Node、Perl 和 Ruby 远程 provider。
    -- 不影响插件直接调用 node 等外部命令，Python provider 仍保持可用。
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

-- 原生识别结果为 yaml，显式指定 Docker Compose 语言服务器需要的文件类型。
vim.filetype.add({
    filename = {
        ["docker-compose.yml"] = "yaml.docker-compose",
        ["docker-compose.yaml"] = "yaml.docker-compose",
        ["compose.yml"] = "yaml.docker-compose",
        ["compose.yaml"] = "yaml.docker-compose",
    },
})

require("config.lazy")
