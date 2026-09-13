# 编辑 Terraform/HCL 和查资源文档

> 来源：LazyVim Terraform Extra；语言服务、格式化与可选 Telescope 扩展。

## 什么时候用

修改资源定义、变量和模块引用时，需要补全、诊断和对应资源文档。

## 怎么用

| 模式 / 场景     | 键位或命令                 | 会发生什么                           |
| --------------- | -------------------------- | ------------------------------------ |
| Terraform、普通 | `K` / `gd`                 | 查询文档 / 定义。                    |
| Terraform、普通 | `<leader>cf`               | 请求 terraform fmt 对应的格式化。    |
| 普通            | `<leader>cd`               | 查看当前位置诊断。                   |
| 命令            | `:Telescope terraform_doc` | 扩展可用时搜索 Terraform 文档。      |
| 命令            | `:ConformInfo`             | 确认当前文件实际选择了哪个格式化器。 |

## 跟着做一次

在已有 Terraform 项目中打开 `.tf` 文件，修改资源参数后按 `<leader>cf`。对不熟悉的资源字段先用 K，或通过 terraform_doc 查文档，再执行项目原有的验证、plan 流程。

## 在你的配置里

解析、格式化与实际 `plan/apply` 分开。格式化不会替你创建基础设施；编辑器也不自动批准或执行 apply。工具、provider 初始化和凭据仍由项目环境决定。HCL 与 Terraform 文件的格式化器可能不同，以 ConformInfo 为准。

## 继续查

入口：[Terraform Extra](../../../lazyvim.json)。
相关：[格式化](../lazyvim/formatting.md)。

[返回卡片目录](../README.md)
