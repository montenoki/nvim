# 编辑 Bash 和 Shell 脚本

> 来源：bashls、fish_lsp、Shell 专属格式化和语法检查。

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

Bash/sh 使用 bashls、ShellCheck、shfmt；Fish 使用 fish_lsp、fish_indent 和 fish
语法检查；Zsh 使用自己的解析器检查语法，不接入 Bash LS 或 shfmt。
这些工具由 Nix 全局提供。`.ps1` 的 PowerShell 支持没有新增，脚本执行环境仍由原工作流决定。

## 继续查

配置：[Bash](../../../lua/plugins/languages/bash.lua)。
相关：[内置终端](../lazyvim/terminal.md)。

[返回卡片目录](../README.md)
