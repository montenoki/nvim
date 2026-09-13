# Neovim 使用卡片

这里按“一件事一张卡片”介绍你当前配置能做什么、怎么操作、会得到什么结果。
不按依赖库逐个罗列，也不介绍配色、图标、图片渲染、动画和纯性能优化。

## 先读这几条

- `<leader>`、`<localleader>` 都是 **空格**。`<leader>cf` 表示依次按空格、c、f。
- `Ctrl-x` 是同时按 Ctrl 与 x；`Ctrl-w h` 是先按 Ctrl-w，再按 h。`M`/`A` 表示 Alt。
- 默认从普通模式按快捷键；卡片标明“插入”“可视”“插件窗口”时，必须在对应环境操作。
- `:命令` 从普通模式输入，最后按 Enter。示例里的路径需要换成你的实际路径。
- `nvim` 使用部署配置；`NVIM_APPNAME=nvim-test nvim` 使用测试配置。手册对应当前仓库，旧部署可能尚未同步。
- 语言功能需要对应服务器/工具。Nix 托管工具时，通过系统配置或项目 devShell 提供它们。

## 从你的任务出发

| 我现在想做什么       | 先看                                                                       |
| -------------------- | -------------------------------------------------------------------------- |
| 基本编辑、保存、改词 | [模式与文件](neovim/modes-and-files.md)、[动作组合](neovim/operators.md)   |
| 找文件、找一段代码   | [文件名查找](lazyvim/find-files.md)、[内容搜索](lazyvim/project-search.md) |
| 读懂函数调用         | [代码导航](lazyvim/code-navigation.md)、[折叠](plugins/folding.md)         |
| 更快改中文和引号     | [中文分词](plugins/chinese-words.md)、[包围符号](plugins/surround.md)      |
| 多文件对照工作       | [缓冲区](lazyvim/buffers.md)、[窗口](lazyvim/windows.md)                   |
| 写代码、填模板       | [补全](plugins/completion.md)、[片段](plugins/snippets.md)                 |
| 修报错、统一格式     | [诊断](lazyvim/diagnostics.md)、[格式化](lazyvim/formatting.md)            |
| 运行和调试 Python    | [环境](plugins/python-environment.md)、[断点调试](plugins/python-debug.md) |
| 编辑文档或笔记       | [项目 Markdown](plugins/markdown.md)、[Obsidian](plugins/obsidian.md)      |
| 检查本次修改、提交   | [改动块](plugins/git-hunks.md)、[Neogit](plugins/neogit.md)                |
| 让 AI 解释或修改代码 | [AI 提问](plugins/ai-chat.md)、[AI 编辑](plugins/ai-edit.md)               |

## 卡片目录

分类表示你从哪里接触这些能力，不代表实现完全独立。
例如诊断由 Neovim 提供底层能力，LazyVim 配键，Trouble 提供列表；每张卡片开头写明来源。

### Neovim 基础能力

- [标记位置，随时跳回来](neovim/marks.md)
- [注释代码和调整缩进](neovim/comments-and-indentation.md)
- [进入编辑、保存和退出](neovim/modes-and-files.md)
- [用动作组合修改文本](neovim/operators.md)
- [选择文本与文本对象](neovim/selections-and-textobjects.md)
- [撤销、重做和重复上次修改](neovim/undo-and-repeat.md)
- [在当前文件搜索与替换](neovim/search-and-substitute.md)
- [寄存器与系统剪贴板](neovim/registers.md)
- [录制并重复一串操作](neovim/macros.md)

### LazyVim 日常工作流

- [不记得快捷键时找 Which-key](lazyvim/key-help.md)
- [按文件名打开文件](lazyvim/find-files.md)
- [在项目里按内容找代码](lazyvim/project-search.md)
- [切换和关闭已打开的文件](lazyvim/buffers.md)
- [分屏、切换窗口和标签页](lazyvim/windows.md)
- [在编辑器里运行终端命令](lazyvim/terminal.md)
- [恢复上次的编辑现场](lazyvim/sessions.md)
- [查定义、引用和重命名符号](lazyvim/code-navigation.md)
- [阅读错误、警告和问题列表](lazyvim/diagnostics.md)
- [把多处结果当作待处理清单](lazyvim/quickfix.md)
- [整理代码格式](lazyvim/formatting.md)

### 插件与语言功能

- [沿目录找文件与选择打开位置](plugins/file-tree.md)
- [快速跳到看到的位置](plugins/leap.md)
- [给文字加、删、换括号或引号](plugins/surround.md)
- [按中文词语移动和修改](plugins/chinese-words.md)
- [整理中英文之间的空格](plugins/chinese-spacing.md)
- [退出插入模式时自动切到英文](plugins/input-method.md)
- [找回之前复制过的内容](plugins/yank-history.md)
- [选择并确认代码补全](plugins/completion.md)
- [依次填写代码模板，支持嵌套](plugins/snippets.md)
- [折叠代码，只看需要的部分](plugins/folding.md)
- [预览并替换多个文件的文本](plugins/project-replace.md)
- [按改动块检查和暂存代码](plugins/git-hunks.md)
- [在 Neovim 里检查并提交 Git 改动](plugins/neogit.md)
- [用终端式 Git 工具处理仓库](plugins/lazygit.md)
- [带着代码上下文向 AI 提问](plugins/ai-chat.md)
- [让 AI 修改选区，并决定是否应用](plugins/ai-edit.md)
- [选择项目的 Python 环境](plugins/python-environment.md)
- [在断点处看变量、逐行运行](plugins/python-debug.md)
- [编辑项目里的 Markdown](plugins/markdown.md)
- [在笔记库里创建、查找和连接笔记](plugins/obsidian.md)
- [编辑 Nix 配置和模块](plugins/nix.md)
- [编辑 Bash 和 Shell 脚本](plugins/shell.md)
- [编辑 YAML 与 JSON 配置](plugins/yaml-json.md)
- [编辑 Dockerfile 和 Compose](plugins/docker.md)
- [编辑并按需运行 Ansible](plugins/ansible.md)
- [编辑 Rust 与 Cargo 依赖](plugins/rust.md)
- [编辑 Terraform/HCL 和查资源文档](plugins/terraform.md)
- [找回一闪而过的错误和通知](plugins/messages.md)

## 当前边界与查证

- 已把本地改键写进对应卡片：`$`/`g_`、保护复制内容的 `c/C`、`gz` 包围前缀等。
- Neo-tree 的 Enter 重复声明尚未修复，文件树卡片使用明确可用的其他入口。
- Obsidian 的配置已存在，但本机当前没有安装目录；按配置和上游命令资料整理，未宣称本轮操作验证。
- Rust、Python 等语言局部映射可能覆盖通用映射；以对应语言卡片和当前文件的 Which-key 为准。
- 这套卡片不承诺每个项目都具备完整服务器、调试器和命令环境，也不把历史测试当成当前部署状态。

整理依据：2026-09-13 的工作区配置、[启用的 Extras](../../lazyvim.json)、
[lazy-lock.json](../../lazy-lock.json)，以及本机插件默认配置/帮助。
语言与插件内的可变命令以实际安装版本为准。Obsidian 另核对了其官方命令资料。

想查完整按键索引，见 [键位清单](../keymaps.md)；想自己读配置，见 [目录边界说明](../structure.md)。
