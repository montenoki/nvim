# 主动安装的 Neovim 插件

完整用法见 [插件使用手册（HTML）](plugins-guide.html) 与
[功能总览（SVG）](plugins-map.svg)。手册包含默认插件、依赖和条件启用项，
按功能分类说明使用场景、实际按键与配置边界。

按当前配置整理，包含直接添加和主动启用 LazyVim Extra 的功能插件；依赖区中具有独立使用入口的主动配置项也计入。不包含纯依赖、仅修改配置的默认插件及未启用项。

| 名称 | 分类 | 用途 |
| --- | --- | --- |
| avante.nvim | AI 编程 | 接入 OpenRouter，使用 Snacks 选择/输入界面和 Blink 的命令、引用、快捷提示补全。 |
| jieba.vim | 中文编辑 | 在 Markdown、纯文本和常用代码/配置文件中按中文词语移动及选择文本，支持中文注释编辑和 Surround 组合。 |
| pangu.vim | 中文排版 | 整理中文与英文、数字之间的空格。 |
| im-select.nvim | 输入法 | 随编辑模式切换输入法。 |
| leap.nvim | 光标跳转 | 使用 `\` 双字符跨窗口跳转；直接实现多行 `f/F/t/T` 查找，普通和可视模式显示标签；不接管 `s/S`。 |
| mini.surround | 文本编辑 | 添加、删除和替换括号、引号等包围符号。 |
| LuaSnip | 代码片段 | 为 Blink 提供片段展开、嵌套填写和前后跳转，复用 friendly-snippets。 |
| vim-repeat | 文本编辑 | 使用 . 重复插件提供的编辑操作。 |
| yanky.nvim | 剪贴板 | 管理复制历史，增强粘贴和历史切换。 |
| nvim-window-picker | 窗口管理 | 通过窗口标签选择目标窗口。 |
| neogit | Git | 在编辑器内查看变更、暂存和提交代码。 |
| obsidian.nvim（社区维护版） | 笔记管理 | 自动发现 ~/obsidian 下的笔记库，支持多库切换、笔记链接、搜索及补全。 |
| image.nvim | 笔记管理 | 在 Markdown 中通过 Sixel 显示光标处图片，使用 ImageMagick 处理；不下载远程图片。 |
| nvim-navic | 代码导航 | 显示当前光标所在的代码符号路径。 |
| nvim-ufo | 代码折叠 | 增强代码折叠，显示折叠摘要并预览折叠内容。 |
| statuscol.nvim | 界面 | 定制行号、标记和折叠列，支持鼠标交互。 |
| venv-selector.nvim | Python | 查找和切换 Python 虚拟环境，状态栏显示当前环境名。 |
| nvim-dap / nvim-dap-python | 调试 | 断点、单步和 Python 调试；debugpy 由项目 devShell 提供。 |
| nvim-dap-ui / nvim-dap-virtual-text | 调试 | 显示调试面板、变量和行内调试信息。 |
| nvim-ansible | Ansible | 提供 Ansible 专用编辑辅助。 |
| rustaceanvim | Rust | 集成 Rust 语言服务和开发操作。 |
| crates.nvim | Rust | 查看和管理 Cargo 依赖，提供版本信息与补全。 |
| kanagawa.nvim | 主题 | 提供 Kanagawa 配色。 |
| retro-82.nvim | 主题 | 提供 Retro 82 配色。 |
| nord.nvim | 主题 | 提供 Nord 配色。 |
| gruvbox-material | 主题 | 提供 Gruvbox Material 配色。 |
| ethereal.nvim | 主题 | 提供 Ethereal 配色。 |
| everforest-nvim | 主题 | 提供 Everforest 森林绿配色。 |
| flexoki-neovim | 主题 | 提供 Flexoki 配色，含 flexoki-light 浅色版本。 |
| hackerman.nvim | 主题 | 提供 Hackerman 荧光绿配色。 |
| lumon.nvim | 主题 | 提供 Lumon 配色。 |
| matteblack.nvim | 主题 | 提供 Matte Black 配色。 |
| miasma.nvim | 主题 | 提供 Miasma 配色。 |
| bamboo.nvim | 主题 | 提供与 Osaka Jade 对应的竹绿配色。 |
| monokai-pro.nvim | 主题 | 提供 Monokai Pro 配色，通过 monokai-pro-ristretto 使用 Ristretto。 |
| rose-pine | 主题 | 提供 Rosé Pine 配色，含 rose-pine-dawn 浅色版本。 |
| vantablack.nvim | 主题 | 提供 Vantablack 配色。 |
| white.nvim | 主题 | 提供 White 浅色配色。 |
| ashen.nvim | 主题 | 提供与 Solitude 对应的 Ashen 配色。 |

Showkeys：右下角显示最近按键；底栏 `󰌌` 或 `:ShowkeysToggle` 切换并记住选择，首次默认关闭。配置见 [showkeys.lua](../lua/plugins/showkeys.lua)。
