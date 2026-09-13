# 编辑 Rust 与 Cargo 依赖

> 来源：rustaceanvim/rust-analyzer + crates.nvim，由 LazyVim Rust Extra 接入。

## 什么时候用

读写 Rust、查看类型和编译诊断，或编辑 Cargo.toml 依赖时使用。

## 怎么用

| 模式 / 场景      | 键位或命令         | 会发生什么                     |
| ---------------- | ------------------ | ------------------------------ |
| Rust、普通       | `gd` / `K` / `gr`  | 定义 / 类型文档 / 引用。       |
| Rust、普通       | `<leader>cr`       | 重命名符号。                   |
| Rust、普通       | `<leader>cR`       | Rust 专用代码操作。            |
| Rust、普通       | `<leader>dr`       | 列出 Rust 可调试目标。         |
| Cargo.toml、插入 | 补全依赖名或版本   | 使用 crates.nvim 提供的候选。  |
| Cargo.toml、普通 | `K` / `<leader>ca` | 在支持的位置看依赖说明或操作。 |

## 跟着做一次

在 Cargo 项目中打开 Rust 文件，把光标放到一个函数调用上，先 K 看类型和文档，再 gd 看实现。修改依赖时打开 Cargo.toml，利用候选选择版本，最终仍用 Cargo 命令验证构建和测试。

## 在你的配置里

Rust 文件里 `cR` 是代码操作，`dr` 是可调试目标，覆盖了通用语境下同名按键的含义。调试依赖额外适配器（如 codelldb）；已启用 DAP 并不保证当前 devShell 已提供 Rust 调试器。

## 继续查

入口：[Rust Extra](../../../lazyvim.json)。
相关：[代码导航](../lazyvim/code-navigation.md)。

[返回卡片目录](../README.md)
