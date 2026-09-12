# Python 开发与调试

`python.lua` 使用 venv-selector 自带的 Lualine 组件显示当前环境名；点击该项或 `<空格>cv` 选择环境。
保留 nvim-lspconfig 依赖以确保缓存恢复环境前注册语言服务；删除版本查询回调和重复映射。

启用 LazyVim `dap.core` 与已有 Python Extra。Nix 环境禁用 mason-nvim-dap，调试器由项目 devShell 提供。

```sh
dev-init python ~/codes/my-project
cd ~/codes/my-project
nix develop
uv venv  # 有 pyproject.toml 时用 uv sync
NVIM_APPNAME=nvim-test nvim main.py
```

`dev-init` 由 NixOS 仓库的 home/cli/dev-init.nix 提供，需部署后进入 PATH。
Git 项目须跟踪新 Nix 文件；暂不跟踪时可使用 `nix develop path:.`。

- `<空格>db`：设置断点。
- `<空格>dc`：启动或继续。
- `<空格>dO`：单步跳过。
- `<空格>di`：进入函数。
- `<空格>du`：打开或关闭调试面板。

2026-09-12 验收：项目 devShell 构建、环境名含空格、停用隐藏、Pyright 解释器切换、真实断点、变量读取、单步与继续均通过。
测试使用真实 nvim-test 配置与项目 .venv-alt。启动回调完成后再模拟选择，避免自动化操作与缓存恢复竞争。
系统未部署时旧 Neovim 包装器仍提供全局 debugpy；测试显式将 devShell 调试器路径置于最前，模拟部署后的行为。
完整系统部署后应从 devShell 启动 Neovim，检查 `:lua print(vim.fn.exepath('debugpy-adapter'))`。
