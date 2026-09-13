# 编辑 Nix 配置和模块

> 来源：LazyVim Nix Extra：nil_ls、nixfmt、statix。

## 什么时候用

编辑系统配置、Home Manager 模块或 flake，想查符号、排版和检查常见问题时使用。

## 怎么用

| 模式 / 场景 | 键位或命令                  | 会发生什么                |
| ----------- | --------------------------- | ------------------------- |
| Nix、普通   | `gd` / `K`                  | 请求跳转定义 / 查看文档。 |
| Nix、普通   | `<leader>ca`                | 查看可用代码操作。        |
| Nix、普通   | `<leader>cf`                | 用 nixfmt 格式化。        |
| Nix、普通   | `<leader>cd` / `<leader>xX` | 看当前行 / 当前文件诊断。 |
| 命令        | `:ConformInfo`              | 确认 nixfmt 是否可用。    |

## 跟着做一次

打开一个 `.nix` 文件，修改属性后用 `<leader>cf` 排版，再看 `<leader>xX` 中有没有诊断。需要判断整个配置能否构建，回到项目原来的 Nix 检查或构建流程。

## 在你的配置里

LSP 不能保证解析出所有动态求值产生的属性，跳不到定义不一定是代码错误。编辑器检查不等于 Nix 求值、构建或部署；这三步依然由你的 Nix 工作流完成。工具由 Nix 环境提供。

## 继续查

入口：[语言 Extras](../../../lazyvim.json)。
相关：[代码导航](../lazyvim/code-navigation.md)、[诊断](../lazyvim/diagnostics.md)。

[返回卡片目录](../README.md)
