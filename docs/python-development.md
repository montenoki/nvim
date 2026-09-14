# Python 开发

`python.lua` 使用 venv-selector 自带的 Lualine 组件显示当前环境名；点击该项或 `<空格>cv` 选择环境。
保留 nvim-lspconfig 依赖以确保缓存恢复环境前注册语言服务；删除版本查询回调和重复映射。

保留 Python Extra 的语言服务与虚拟环境选择。Neovim 内的 DAP 调试已移除，
程序调试使用其他编辑器；Neovim 不再安装专用 debugpy。

```sh
dev-init python ~/codes/my-project
cd ~/codes/my-project
nix develop
uv venv  # 有 pyproject.toml 时用 uv sync
NVIM_APPNAME=nvim-test nvim main.py
```

`dev-init` 由 NixOS 仓库的 home/cli/dev-init.nix 提供，需部署后进入 PATH。
Git 项目须跟踪新 Nix 文件；暂不跟踪时可使用 `nix develop path:.`。

在普通终端运行 Python 或测试命令；用 `<leader>cv` 选择项目解释器。
其他编辑器或项目共享的调试工具不据此卸载。
