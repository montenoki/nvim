# 在断点处看变量、逐行运行

> 来源：nvim-dap + dap-python + dap-ui；由 LazyVim 的 DAP/Python Extra 接入。

## 什么时候用

程序能运行，但中间变量不符合预期，单靠打印不方便定位时使用。

## 怎么用

| 模式 / 场景        | 键位或命令                    | 会发生什么                     |
| ------------------ | ----------------------------- | ------------------------------ |
| Python 文件、普通  | `<leader>db`                  | 设置或移除断点。               |
| 普通               | `<leader>dc`                  | 启动调试，或继续到下一个断点。 |
| 暂停时、普通       | `<leader>dO`                  | 单步跳过当前调用。             |
| 暂停时、普通       | `<leader>di`                  | 单步进入函数。                 |
| 暂停时、普通       | `<leader>do`                  | 运行到当前函数返回。           |
| 暂停时、普通或可视 | `<leader>de`                  | 查看光标处或选区表达式的值。   |
| 普通               | `<leader>du`                  | 打开或关闭调试面板。           |
| 普通               | `<leader>dt`                  | 终止当前调试。                 |
| Python 文件、普通  | `<leader>dPt` / `<leader>dPc` | 调试测试方法 / 测试类。        |

## 跟着做一次

在循环里累加变量的那一行设置断点，按 `<leader>dc` 选择 Python 启动配置。停住后用 `<leader>de` 查看累计值，用大写 O 的 `<leader>dO` 执行下一步，再看数值怎样变化。

## 在你的配置里

从包含 `debugpy-adapter` 的 devShell 启动 Neovim；只选择虚拟环境不一定能补齐调试器。可用 `:lua print(vim.fn.exepath("debugpy-adapter"))` 检查入口。项目的测试框架、工作目录和运行参数仍要正确。`dP` 本身是暂停调试，`dPt/dPc` 是 Python 测试子键。

## 继续查

相关：[Python 环境](python-environment.md)。
配置入口：[启用的 Extras](../../../lazyvim.json)。

[返回卡片目录](../README.md)
