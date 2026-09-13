# 用终端式 Git 工具处理仓库

> 来源：LazyVim/Snacks 启动外部 Lazygit。

## 什么时候用

你更习惯 Lazygit 的工作流，或要处理分支、日志等仓库级操作时使用。

## 怎么用

| 模式 / 场景 | 键位或命令                  | 会发生什么                               |
| ----------- | --------------------------- | ---------------------------------------- |
| 普通        | `<leader>gg`                | 在项目根目录打开 Lazygit。               |
| 普通        | `<leader>gG`                | 在当前工作目录打开 Lazygit。             |
| Lazygit 内  | `?`                         | 查看当前界面键位帮助。                   |
| Lazygit 内  | `q`                         | 按界面层级返回或退出。                   |
| 普通        | `<leader>gf`                | 另用 LazyVim 入口查看当前文件历史。      |
| 普通        | `<leader>gB` / `<leader>gY` | 打开当前代码的 Git 网页 / 复制网页链接。 |

## 跟着做一次

在项目任意子目录文件中按 `<leader>gg`。确认仓库路径，按界面提示选择文件、查看差异。完成后退出 Lazygit，回到原来的编辑窗口。

## 在你的配置里

这些入口只有检测到 Lazygit 可执行文件时才会创建。Lazygit 内部的空格、Tab 等键不遵循 Blink 或 Which-key 的含义。Neogit 和 Lazygit 是两套界面，共用同一仓库状态；目前两种入口都保留。

## 继续查

相关：[Neogit](neogit.md)、[Git 改动块](git-hunks.md)。

[返回卡片目录](../README.md)
