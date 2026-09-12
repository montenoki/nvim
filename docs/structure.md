# 配置结构

目录只分一层，以职责归类；插件声明使用容易对应上游的名称。

| 目录 / 文件 | 职责 |
| --- | --- |
| `init.lua` | 启动入口、provider 和文件类型预设 |
| `lua/config/lazy.lua` | 引导 lazy.nvim、登记插件分类、Nix 加载规则 |
| `lua/config/options.lua` | 通用编辑器选项 |
| `lua/config/autocmds.lua` | 通用自动命令 |
| `lua/config/keymaps.lua` | 不归属特定插件的快捷键 |
| `lua/config/platform.lua` | 环境标记 |
| `lua/config/state.lua` | 偏好读写，不操作编辑器开关 |
| `lua/config/toggles.lua` | 全局开关、恢复保存偏好、对接快捷键和底栏 |
| `lua/config/ui/` | 系统主题同步、状态栏内容计算 |
| `lua/config/languages/` | 中文文本对象适配、笔记库发现等辅助逻辑 |
| `lua/plugins/coding/` | 补全、格式化、LSP、解析器、工具安装、Git 和 AI |
| `lua/plugins/editor/` | 移动、包围、折叠、复制、中文编辑和输入法 |
| `lua/plugins/languages/` | Bash、Python、Markdown、Obsidian 的插件配置 |
| `lua/plugins/ui/` | 主题、状态栏、文件树、提示及图像显示 |
| `tests/` | 升级后需要复查的跨插件适配，见其中的 README |

`config` 保存可调用的辅助逻辑；`plugins` 返回 lazy.nvim 插件声明，负责加载条件、
依赖、选项和插件专属快捷键。短小的单插件回调留在插件文件里，不必另拆模块。

例如：`config/languages/obsidian_workspaces.lua` 只发现笔记库，同时供 Obsidian
配置和 Marksman 排除规则使用；`plugins/languages/obsidian.lua` 负责插件设置。
`plugins/coding/lsp.lua` 只把全局偏好接到 LSP，开关逻辑仍在 `config/toggles.lua`。

LazyVim 约定的 `config/options.lua`、`autocmds.lua`、`keymaps.lua` 保持原位置。
其他模块移动后同步更新 `require`，如 `require("config.ui.theme")`。

lazy.nvim 不会递归扫描任意深度的目录：四个插件分类在 `config/lazy.lua` 中显式
`import`。向已有分类增加 `.lua` 文件会自动加载；新增分类时再登记一个 `import`。
语言分类最后加载，使 Python 等语言配置可以补充底栏和通用插件选项。
不要把普通辅助模块放进这些插件分类，否则 lazy.nvim 会把它当成插件声明。
