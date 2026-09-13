# 编辑 YAML 与 JSON 配置

> 来源：YAML：yamlls + SchemaStore；格式化：本地 Prettier 声明。

## 什么时候用

修改配置文件，希望知道字段是否拼错、取值是否合规，并把缩进排整齐时使用。

## 怎么用

| 模式 / 场景           | 键位或命令                  | 会发生什么                      |
| --------------------- | --------------------------- | ------------------------------- |
| YAML、插入            | 输入字段前缀并选择补全      | Schema 可用时提供配置字段建议。 |
| YAML、普通            | `K`                         | 查看服务器提供的字段说明。      |
| YAML、普通            | `<leader>cd` / `<leader>xX` | 查看当前行 / 当前文件诊断。     |
| YAML/JSON/JSONC、普通 | `<leader>cf`                | 使用 Prettier 排版。            |
| 命令                  | `:ConformInfo`              | 确认格式化器是否可用。          |

## 跟着做一次

编辑一个能匹配 Schema 的 YAML 文件，输入配置项时按 Ctrl-Space 看候选；写错字段或取值后，用 `<leader>cd` 读诊断。最后按 `<leader>cf` 统一格式。

## 在你的配置里

Schema 是字段规则，不是所有 YAML 都有对应规则。当前明确启用了 YAML Extra，但没有启用 JSON Extra；JSON/JSONC 有 Prettier 格式化，不应据此推断已经有完整 JSON LSP 或 Schema 补全。

## 继续查

配置：[格式化](../../../lua/plugins/coding/formatting.lua)、[Extras](../../../lazyvim.json)。

[返回卡片目录](../README.md)
