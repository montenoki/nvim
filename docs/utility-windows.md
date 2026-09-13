# 功能窗口名称与文件打开目标

顶部栏的功能窗口名称集中在 `lua/config/ui/windows.lua`，由
`lua/config/ui/statusline.lua` 显示。名称按窗口和缓冲区类型判断；Trouble
额外读取当前窗口的模式，所以同时打开诊断和符号树也能各自显示正确名称。
不修改插件内部的缓冲区名称、文件类型或动作。插件自带的浮窗标题仍由插件管理。

## 当前配置中的功能窗口

| 来源 | 顶部显示名称 / 包含的窗口 |
| --- | --- |
| Trouble | 诊断列表、符号树、LSP 导航、引用、定义、声明、实现、类型定义、Quickfix 列表、位置列表、待办事项；附带 `（Trouble）` |
| Neo-tree | 文件树、文件树操作 |
| Avante | AI 对话、AI 输入、AI 编辑指令、AI 选中代码、AI 上下文文件、AI 任务、AI 操作确认 |
| DAP / DAP UI | 调试变量、调用栈、断点、监视表达式、调试输出、调试交互终端、调试详情 |
| Neogit | Git 状态、提交历史、提交详情、提交选择、差异、引用、引用历史、暂存记录、命令输出、命令历史、操作 |
| Noice / Snacks notifier | 消息、通知、通知历史 |
| FzfLua / Telescope / Snacks picker | 搜索、搜索输入、搜索结果、搜索预览；FzfLua 是主选择器，Snacks 供 Avante 使用，Telescope 是 Obsidian 的条件依赖，当前未启用 |
| Grug-far | 搜索与替换、替换历史、替换帮助 |
| Lazy / Mason | 插件管理、开发工具管理 |
| Snacks / Which-key | 启动页、终端、输入、窗口帮助、快捷键提示 |
| Neovim | Quickfix 列表、位置列表、帮助、Man 手册、健康检查、终端（含终端中的 Lazygit） |

有些窗口是浮窗或使用自己的标题，不一定显示 lualine 顶部栏。显示名称与能否打开
文件分别判断：启动页虽有功能名称，仍可被打开的文件替换。新增的 Avante、Neogit、DAP UI 等面板使用带原始
filetype 的中文类别名称回退，其他特殊缓冲区显示“工具窗口（filetype）”。

普通源码、Markdown / Obsidian 笔记、Git 提交说明和 rebase 文件仍显示路径。
真正的新建空白编辑缓冲区仍显示 `[未命名]`，可以正常接收从文件树打开的文件。

## 窗口字母选择器

`lua/plugins/ui/neotree.lua` 的 `nvim-window-picker` 配置使用上述统一分类。
Neo-tree 的 Enter、`v`、`s` 和 `<leader>wp` 共用过滤规则：

- 排除 Trouble、AI、调试等功能面板、浮窗、预览窗口和设置了 `winfixbuf` 的窗口。
- 启动页（`snacks_dashboard`）是例外：可作为打开文件的目标；只有启动页可用时直接复用它。
- 保留上游对当前窗口、不可聚焦窗口等的排除规则。
- 只有一个可选目标（文件窗口或启动页）时自动选中；多个目标时显示字母。
- 既没有编辑窗口也没有启动页时，Neo-tree 的 Enter、`v`、`s` 新建编辑窗口并打开文件，保留其他功能面板。
  `<leader>wp` 只切换已有窗口，没有目标时仍提示无可选窗口。

Enter 的配置键名使用上游默认的 `<cr>`。当前 Neo-tree 版本未正确归一化
用户映射的键名；写成 `<CR>` 会与默认 `<cr>` 并存，两者注册到同一个 Enter
时可能被普通 `open` 覆盖，绕过选择器。完整配置回归测试
`tests/neotree_window_picker.lua` 检查合并后的映射唯一性及实际打开行为。

## 顶部栏的颜色与三角分隔

`lua/plugins/ui/lualine.lua` 将功能窗口名放在 `lualine_a`，活动窗口的普通文件路径
放在 `lualine_b`，非活动窗口的文件路径放在 `lualine_c`；无对应内容时隐藏该组件。
非活动窗口的 a 组件沿用当前模式下活动 a 的配色，随主题和模式变化，其余区域保留
主题的非活动样式。`disabled_filetypes.winbar = {}` 表示不按文件类型禁用顶部栏。
活动窗口的代码符号路径放在 `lualine_c`，沿用主题颜色和 `` / `` 分隔符。
实际色差由当前主题决定；相邻色块背景相同时三角可能不明显。

`dc767e4` 曾把活动标题从 a 移到 b、非活动标题从 b 移到 c，后者不生成左侧
三角分隔；现在按窗口名与文件路径分别使用 a、b。`e27436a` 只移动文件并修改模块引用，
`9405731` 的中文说明改动未修改 lualine。

跨插件适配检查见 `tests/utility_windows.lua` 和 [运行说明](../tests/README.md)。
