# Obsidian 测试库

使用社区维护版 `obsidian-nvim/obsidian.nvim`，本次安装并锁定稳定发行
`v3.16.7`（`7a2b7caf41de196de66f27c1969d0d429810621a`）。
Neovim 配置通过标准 `opts` 完成初始化。笔记外观由 render-markdown 管理，
Obsidian 的 `ui.enable` 设为 `false`，保留笔记、链接和搜索功能。

## 目录

```text
~/obsidian/
└── test/                 # 独立测试笔记库
    ├── .obsidian/
    │   └── app.json
    ├── Welcome.md        # 首页、任务列表和链接
    └── Second-note.md    # 链接回首页
```

笔记位于用户目录，不提交进 Neovim 配置仓库。
在 Obsidian 桌面应用中选择“打开文件夹作为仓库”，选取 `~/obsidian/test` 即可。
本次没有启动桌面应用或注册到它的全局仓库列表。

## Neovim 使用

配置生效后，打开 `~/obsidian/test/Welcome.md` 即会加载插件。
光标放在笔记链接上按 Enter，或使用 `:Obsidian follow_link` 跳转。

| 命令 | 用途 |
| --- | --- |
| `:Obsidian quick_switch` | 搜索并切换笔记，使用现有 Telescope |
| `:Obsidian new 标题` | 创建笔记 |
| `:Obsidian backlinks` | 查看当前笔记的反向链接 |
| `:Obsidian workspace test` | 切换到测试库 |
| `:checkhealth obsidian render-markdown` | 检查初始化和渲染兼容性 |

使用社区版的 `:Obsidian 子命令`，不再启用旧式 `:ObsidianQuickSwitch` 等命令。
该版本通过内置 `obsidian-ls` 提供语言服务，可由已有 Blink 的 LSP source 获取补全，
不额外引入 nvim-cmp。

启动 Neovim 时自动扫描 `~/obsidian` 的直接子目录：只有包含 `.obsidian/`
目录的非隐藏子目录才注册为 workspace，名称使用子目录名，按名称排序。
每个库的根目录固定为该子目录，不把它们合并为一个大库。

例如新增 `~/obsidian/personal/.obsidian/` 和 `~/obsidian/work/.obsidian/` 后，
重启 Neovim 即可发现 `personal`、`work`，不再需要编辑插件配置。
打开库中的 Markdown 文件会按所属库切换，也可以执行 `:Obsidian workspace work`。
没有 `.obsidian/` 的普通目录、隐藏目录和更深层的嵌套库不会自动注册。
同一库的多篇笔记直接放进库内即可，不需要为每篇笔记增加 workspace。

这不是实时监听：运行期间新增或移除库，需要重启 Neovim。
如果根目录不存在或没有找到任何库，本次启动不启用 Obsidian 插件，避免空 workspace
初始化错误，也不会擅自创建笔记库；创建库后重启即可启用。

## 验证与范围

在工作区完整配置下，以终端 UI 启动，验证了：

- `opts` 初始化成功，当前 workspace 是 `test`，路径正确。
- `obsidian-ls` 成功连接到 Markdown 笔记缓冲区。
- `Welcome.md` → `Second-note.md` → `Welcome.md` 双向链接跳转成功。
- Obsidian 配置校验通过；render-markdown 报告 Obsidian 不冲突。
- 两项 health 合计 0 ERROR、4 WARNING：3 条原有 LaTeX 警告，1 条可选录音工具缺失。
- 临时多库测试通过：按名称排序、过滤普通/隐藏/嵌套目录、正确解析笔记所属库、命令切换库。

以上是当时的验收记录；依赖个人示例库和临时工作区的验收脚本已清理。
日常复查可使用上面的 workspace 命令和 health 检查；它们不代表后续版本已自动验证。

本次没有验证桌面应用打开、真实补全菜单交互、录音或云同步。
云同步默认关闭，不需要配置账号。

日常 `~/.config/nvim` 由 Nix 部署。本次更新的是配置仓库和本机插件安装，
没有执行 NixOS/Home Manager 部署；日常启动使用新配置仍需更新对应 Nix input 并应用配置。
验证使用临时 XDG_CONFIG_HOME 链接到本仓库，与旧部署配置隔离。

参考：[v3.16.7 安装文档](https://github.com/obsidian-nvim/obsidian.nvim/blob/v3.16.7/README.md)、
[Workspace 文档](https://github.com/obsidian-nvim/obsidian.nvim/wiki/Workspace)。
