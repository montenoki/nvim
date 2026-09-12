local M = {}

-- 由 Nix 显式设置环境变量，不根据操作系统推断；只有值为 "1" 时才启用。
-- 工具交给 Nix 管理时，禁用 Mason 和 Tree-sitter 的自动安装，避免重复下载。
M.nix_managed_tools = vim.env.NVIM_NIX_MANAGED_TOOLS == "1"

-- 配置交给 Nix 管理时，适配只读配置目录，例如将锁文件的运行副本放入状态目录。
-- 与工具管理分开判断，允许使用 Nix 提供的工具，同时在普通目录中编辑配置。
M.nix_managed_config = vim.env.NVIM_NIX_MANAGED_CONFIG == "1"

return M
