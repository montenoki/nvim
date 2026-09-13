# 编辑 Bash 和 Shell 脚本

> 来源：本地 bashls + LazyVim 的通用 LSP 支持。

## 什么时候用

编辑项目脚本、个人工具或系统脚本时，需要参数说明、补全和诊断。

## 怎么用

| 模式 / 场景 | 键位或命令             | 会发生什么                            |
| ----------- | ---------------------- | ------------------------------------- |
| Shell、普通 | `K`                    | 查看服务器能提供的说明。              |
| Shell、普通 | `gd` / `gr`            | 请求定义 / 引用。                     |
| Shell、普通 | `<leader>ca`           | 查看可用代码操作。                    |
| Shell、普通 | `<leader>cd`           | 阅读当前行诊断。                      |
| 命令        | `:set filetype?`       | 检查文件是否被识别为 sh/bash 等类型。 |
| 命令        | `:checkhealth vim.lsp` | 检查 bashls 是否可用、是否连接。      |

## 跟着做一次

用 `.sh` 扩展名或正确的 shebang 创建脚本，打开后查看 filetype。编辑参数或函数时尝试补全与 K；有诊断时先读消息，再决定如何改。

## 在你的配置里

Bash 语言服务不是所有 Shell 的通用解释器。`.ps1` 的 PowerShell 支持没有在这里新增，Zsh/Fish 的语法也不能一概按 Bash 判定。能否执行脚本还取决于它的解释器、可执行权限和运行环境。

## 继续查

配置：[Bash](../../../lua/plugins/languages/bash.lua)。
相关：[内置终端](../lazyvim/terminal.md)。

[返回卡片目录](../README.md)
