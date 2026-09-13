# 编辑项目里的 Markdown

> 来源：Marksman + 通用 LSP/格式化键位；不依赖 Obsidian 笔记库。

## 什么时候用

修改项目 README、设计文档，想跳转链接目标、查看标题结构或统一排版时使用。

## 怎么用

| 模式 / 场景    | 键位或命令                   | 会发生什么                             |
| -------------- | ---------------------------- | -------------------------------------- |
| Markdown、普通 | `gd`                         | 在服务器支持的链接或标题引用上跳转。   |
| Markdown、普通 | `gr`                         | 查询服务器识别的引用。                 |
| Markdown、普通 | `<leader>cs`                 | 用 Trouble 查看标题等符号结构。        |
| Markdown、普通 | `<leader>ss`                 | 搜索当前文档符号。                     |
| Markdown、普通 | `<leader>cf`                 | 通过 Prettier 格式化。                 |
| 普通           | `gqip`                       | 按文本排版规则整理当前段落。           |
| 命令           | `:setlocal formatoptions-=t` | 当前文件暂时停止正文输入时自动硬断行。 |

## 跟着做一次

从项目根目录打开 README。把光标放到 Markdown 文件链接上按 `gd`，或用 `<leader>cs` 打开标题列表后跳到某一节。编辑完先看改动，再用 `<leader>cf` 整理格式。

## 在你的配置里

Marksman 必须在环境中可用。普通文档以 `.marksman.toml`、Git 根目录或所在目录确定范围；已识别的 Obsidian 库会被排除。你的 Markdown 正文开启了约 80 列的输入硬断行，它会插入真实换行；Prettier 可能按自己的规则再次排版。

## 继续查

配置：[Marksman 边界](../../../lua/plugins/languages/markdown.lua)、[文本排版](../../../lua/config/options.lua)。
相关：[Obsidian](obsidian.md)。

[返回卡片目录](../README.md)
