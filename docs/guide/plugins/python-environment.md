# 选择项目的 Python 环境

> 来源：venv-selector + Pyright；项目工具由 Nix devShell 提供。

## 什么时候用

不同项目装了不同依赖，或者虚拟环境不叫 .venv，希望补全和检查使用正确解释器时使用。

## 怎么用

| 模式 / 场景       | 键位或命令             | 会发生什么                                   |
| ----------------- | ---------------------- | -------------------------------------------- |
| 项目终端          | `nix develop`          | 进入项目已有的 Nix 开发环境。                |
| 项目终端          | `uv sync`              | 已有 uv 项目时安装锁定依赖并准备项目环境。   |
| 项目终端          | `uv venv`              | 没有项目依赖清单、只需要环境时创建虚拟环境。 |
| Python 文件、普通 | `<leader>cv`           | 搜索并选择虚拟环境。                         |
| 命令              | `:VenvSelect`          | 打开同一个环境选择入口。                     |
| 命令              | `:checkhealth vim.lsp` | 检查 Python 语言服务状态。                   |

## 跟着做一次

已有项目：

```sh
cd ~/codes/my-project
nix develop
uv sync
NVIM_APPNAME=nvim-test nvim main.py
```

打开 Python 文件后按 `<leader>cv`，选中这个项目实际使用的环境。如果项目不使用 uv，按项目原有方式准备环境，不必为了编辑器改包管理工具。

## 在你的配置里

虚拟环境名称可以不是 `.venv`；选择的是实际环境。插件会缓存选择，后续可能自动恢复。devShell 提供工具和运行依赖，虚拟环境提供项目 Python 包，它们不是同一层。新项目初始化可用已部署的 `dev-init python 目录`，但已有 Nix 文件时先阅读项目现有入口。

## 继续查

配置：[Python](../../../lua/plugins/languages/python.lua)。
已有说明：[Python 开发流程](../../python-development.md)。

[返回卡片目录](../README.md)
