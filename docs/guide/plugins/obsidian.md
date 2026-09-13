# 在笔记库里创建、查找和连接笔记

> 来源：obsidian-nvim/obsidian.nvim；只服务已发现的 Obsidian 库。

## 什么时候用

管理你自己的 Obsidian 笔记库，而不是随项目散落的 Markdown 文件时使用。

## 怎么用

| 模式 / 场景  | 键位或命令                 | 会发生什么                     |
| ------------ | -------------------------- | ------------------------------ |
| 笔记中、命令 | `:Obsidian quick_switch`   | 按名字选择库里的笔记。         |
| 笔记中、命令 | `:Obsidian search`         | 按内容搜索笔记。               |
| 笔记中、命令 | `:Obsidian new 标题`       | 创建一篇笔记。                 |
| 笔记中、命令 | `:Obsidian backlinks`      | 查看哪些笔记链接到了当前笔记。 |
| 笔记中、命令 | `:Obsidian follow_link`    | 跟随光标处笔记链接。           |
| 命令         | `:Obsidian workspace 名称` | 在已登记的库之间切换。         |
| 笔记插入     | 输入 `[[`，继续输入名字    | 通过补全候选插入笔记链接。     |

## 跟着做一次

假设你已有 `~/obsidian/personal/.obsidian/`，重启 Neovim 后打开这个目录下的笔记。运行 `:Obsidian new 阅读记录`，再在另一篇笔记里输入 `[[阅读`，从补全中选择它；以后用 backlinks 找到关联入口。

## 在你的配置里

只扫描 `~/obsidian` 的直接子目录，目录里必须有 `.obsidian/`，隐藏目录和深层嵌套库不自动登记。没有任何库时插件不启用，不会替你创建笔记库。Frontmatter 自动管理已关闭；项目 Markdown 使用 Marksman。本机当前未安装该插件，以上按锁定配置和命令文档整理，未做本轮实际笔记库验收。

## 继续查

配置：[Obsidian](../../../lua/plugins/languages/obsidian.lua)、[库发现规则](../../../lua/config/languages/obsidian_workspaces.lua)。
命令参考：[上游命令说明](https://github.com/obsidian-nvim/obsidian.nvim#commands)。
当前锁定版本见 [lazy-lock.json](../../../lazy-lock.json)。

[返回卡片目录](../README.md)
