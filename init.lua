-- 启动入口：先设置环境和文件类型，再加载 lazy.nvim、LazyVim 及插件。
local platform = require("config.platform")
if platform.nix_managed_tools then
    -- Nix 管理工具时，关闭当前未使用的 Python、Node、Perl 和 Ruby 远程 provider。
    -- 不影响语言服务器、格式化器和插件直接调用外部命令。
    vim.g.loaded_python3_provider = 0
    vim.g.loaded_node_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0
end

require("config.filetypes").setup()

require("config.lazy")
