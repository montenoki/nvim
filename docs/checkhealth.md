# Neovim checkhealth 问题清单

基线检查日期：2026-09-12。首次检查只采集、调查、记录；后续经用户确认的修复记录如下。
本文主清单保留修复前工作区配置的结果；同时保留当时日常 Nix 部署配置的结果。

## 检查范围与可信边界

### 最新复查（2026-09-12，配置提交 2c0e101）

当前 `nvim-test` 使用已部署的 parser 路径后，完整检查为 **42 条诊断：8 ERROR、34 WARNING**，
原始基线为 54 条（12 ERROR、42 WARNING）。插件目录和工具环境与基线不同，
数量变化不能全部归因于配置修复。完整原文及本次逐条清单见
[更正后的复查报告](checkhealth-current-parser.md)。上一轮 44 条诊断的报告继承了旧会话 parser 路径，
其中 H10 / H11 是过期环境造成的提示。以下原始报告及 H 编号继续保留。

| 状态 | 项目 | 本次证据或后续处理 |
| --- | --- | --- |
| 已消失 | H02 Copilot | 不再列入已启用插件，不代表已完成认证。 |
| 已通过 | H03 图标、H31 输入框、H54 重复映射 | devicons found、Snacks.input 接管、无重复映射。Dressing input disabled 为主动禁用状态。 |
| 已通过 | H07 ast-grep、H09 / H16 / H17 回收站工具、H12 公式转换器 | ast-grep 0.42.1、gio 2.88.3、latex2text 已识别。未验证 ast-grep 实际搜索替换。 |
| 异常未再出现 | H13 Obsidian / Markdown | 冲突检查通过；本次未打开笔记，Obsidian setup 未调用，功能验证仍参考此前测试。 |
| 识别已通过 | H39 / H44 Compose 类型 | 未再报告未知 Compose 类型；实际 LSP 连接仍待项目 devShell 验证。 |
| 已通过 | H10 / H11 latex parser | NixOS 提交 a7dc107 已补充；按当前 Home Manager 环境变量复测，parser installed、ABI 15。无需重复安装。 |
| 待项目验证 | H14 / H37 / H38 / H40–H43 语言工具 | Rust、Ansible、Compose、Dockerfile、Python、Terraform 工具统一由各项目 devShell 提供。 |
| 尚未决定 | H45 / H46 GitLab、Helm 类型 | 本次仍报告未知类型，未修改识别规则，需结合实际项目确认需求。 |
| 按用户决定跳过 | H04–H06、H08 / H47、H34、H48–H53、H55 | 图片预览、空包目录、SQLite、前缀重叠、录音保留现状。 |
| 状态提示 / 未启用模块 | H01、H15、H18–H30、H32 / H33、H35、H36 | 含动态补全源、禁用模块与版本提示；不以消除全部提示为目标。 |

8 条 ERROR 中，7 条来自未启用的 Snacks.image，1 条来自 rust-analyzer 缺失。
本次未执行 Nix 部署或业务项目验证；没有据此宣称全部功能正常。

### 初始基线环境

| 项目 | 本次环境 |
| --- | --- |
| Neovim | 0.12.4，Nix 包装的 nvim；工具 PATH 以 Neovim 内部为准 |
| 平台 | NixOS / Linux x86_64，TERM=foot |
| 工作区配置 | `/home/ten/codes/nvim`，通过临时 XDG_CONFIG_HOME 软链接启动，使用临时状态目录 |
| 日常配置 | `~/.config/nvim`，实际指向 Nix store，尚未包含工作区最近的变更 |
| 插件目录 | 两次检查均复用 `~/.local/share/nvim/lazy` |
| Nix 管理 | `NVIM_NIX_MANAGED_CONFIG=1`、`NVIM_NIX_MANAGED_TOOLS=1`，Mason 不负责自动补工具 |
| 启动方式 | PTY 终端 UI，延迟 2 秒运行检查，让 UIEnter/VeryLazy 完成 |
| 覆盖方式 | 将所有已启用且已安装的 Lazy 插件目录加入 health 搜索范围；未强制对每个插件调用 setup |
| 避免副作用 | 临时关闭 Lazy 自动安装、更新检查及配置变更监听；未修改仓库运行配置 |

主报告共 **54 条诊断：12 ERROR、42 WARNING**。
部署报告共 **55 条诊断：14 ERROR、41 WARNING**。
这是诊断出现次数，不是独立根因数量；同一依赖可能同时产生 ERROR 和 WARNING。

初次 headless 检查出现了 Dashboard/Notifier 未就绪、Markdown 配置尚未初始化等提示，
终端 UI 复测后这些提示消失，因此未混入主清单。
PTY 仍不能完整验证图片协议、真实项目的 LSP attach 或模型请求。
扩展 health 搜索范围会让尚未加载的可选插件也接受检查，相关条目均需结合启用状态解读。

完整原文：[工作区报告](checkhealth-workspace.md)、[部署报告](checkhealth-deployed.md)。

## 已确认的处理决策

Python 的 Pyright、Ruff 等开发工具由项目 devShell 提供，不在 Neovim 的全局
工具环境中补装。使用时从对应 devShell 启动 Neovim，使其继承项目的 PATH。
已运行的 Neovim 不会因为另一个终端进入 devShell 而自动更新环境。

因此，devShell 外的工具缺失警告不单独认定为 Neovim 配置故障。
这项目前为“策略已确认，项目验证待完成”，不是“已修复”：还需指定 Python
项目，检查其 devShell 是否提供工具，并验证 Python 文件中的 Pyright 实际连接。
当前 nvim 仓库没有 devShell 配置，本次没有修改运行配置或安装工具。

### 后续决策与 Avante 构建

- H10–H12：用户需要公式渲染，`latex` parser 和 `latex2text` 由用户在 Nix 中配置，本仓库未代为安装，待复测。
- H34：Snacks.picker 未启用，SQLite 回退警告按用户决定跳过。
- H08 / H47：按用户决定跳过。进一步在隔离目录复现 Catppuccin 自动适配调用
  `vim.pack.get()` 后创建空 `site/pack/core/opt`；仅清空目录并非持久修复，保留自动适配。
- H04–H06：用户暂不配置 fzf-lua 图片预览；Snacks.image 未启用，其图片相关诊断暂不处理。
- H07：ast-grep 可选功能暂未决定，普通搜索替换继续使用 ripgrep。

Avante 构建曾被 Lazy 默认 120 秒时限中止；经用户确认设置 `git.timeout = 1200`。
该时限也影响其他 Lazy 子进程。用户重建后，`nvim-test` 四个原生模块加载检查通过，
随后用户确认重启后 Avante 可用。此项不是原始 health 诊断，不计入基线数量。

### H13：Markdown / Obsidian 初始化异常已修复

经用户同意，迁移到社区维护版 `obsidian-nvim/obsidian.nvim` 稳定发行 `v3.16.7`。
用标准 `opts` 初始化，配置 `~/obsidian/test` workspace，关闭 Obsidian 自身 UI，
由 render-markdown 负责渲染。移除未生效的 `opt` 本地配置加载逻辑。

随后经用户确认改为启动时自动发现 `~/obsidian` 下含 `.obsidian/` 的直接子目录，
每个子目录注册为独立 workspace；现有 `test` 库由扫描发现。无库时不启用插件。

测试库包含两篇互相链接的笔记。完整配置验证通过：workspace 初始化、
obsidian-ls 连接、双向链接跳转，以及两插件健康检查中的兼容性校验。
H13 不再出现；H10–H12 的 LaTeX 警告仍保留。
原始报告作为基线不重写，具体使用方式见 [Obsidian 测试库](obsidian.md)。
状态为“工作区已修复并验证，Nix 部署未执行”。

新增记录 H55：社区版 `checkhealth obsidian` 提示缺少可选录音工具
`rec` / `sox` / `arecord`；不影响本次验证的文本笔记与链接功能，尚未决定是否需要录音。

### H31：输入框接管冲突已修复

关闭 Dressing 的 `input`，保留其 `select`。当前 Dressing 即使禁用 input，
仍保留 `vim.ui.input` 转发包装；因此在其 setup 后调用 `snacks.input.enable()`，
将输入接口恢复为 Snacks 的实现。

使用 `nvim-test` 插件目录和工作区配置，在终端 UI 启动后复测：
`vim.ui.input == require("snacks.input").input` 通过，Dressing select 仍启用，
`checkhealth dressing snacks` 确认 Snacks.input 为 OK，H31 消失。
Dressing 新出现的 `vim.ui.input not enabled` WARNING 是主动关闭功能的状态提示。
其余图片、回收站等诊断仍待处理；未执行 Nix 部署。

### H54：窗口快捷键冲突已修复

按用户选择，`<leader>wm` 保留 WinShift，`<leader>wM` 切换窗口缩放。
在用户 keymaps 中覆盖默认映射，并过滤 which-key 中旧的 wm Zoom 虚拟提示，
保留 WinShift 提示；窗口缩放原有的 `<leader>uZ` 仍可使用。
终端 UI 验证两键映射、Zoom 开启/恢复及 WinShift 命令加载通过，
which-key 健康检查不再报告重复映射。未执行 Nix 部署。

### H02：移除未使用的 Copilot

用户确认不需要 Copilot，移除 Avante 的 `copilot.lua` 可选依赖及对应锁文件条目。
Avante 继续使用 OpenRouter。此项按“移除不用的功能”处理，不代表完成了 Copilot 认证。
本地已下载的插件目录留给 Lazy 的清理流程处理；未执行 Nix 部署。

### H03：图标插件启动加载后警告消失

用户确认将 `nvim-web-devicons` 设置为 `lazy = false`，并用 `opts = {}` 初始化。
在 `nvim-test` 终端 UI 中验证启动后模块已加载，运行 `checkhealth fzf_lua`，
原图标警告变为 `OK nvim-web-devicons found`。格式检查通过，未执行 Nix 部署。
本次检查仍有可选图片工具警告，以及受限测试环境的 serverstart/runtime 目录错误；
仅将 H03 标为已解决，不视为 fzf-lua 全部功能验证通过。

### H09：用户配置 GIO 后验证通过

用户在 Nix 中提供 GIO 后，终端和 Neovim 均找到
`/etc/profiles/per-user/ten/bin/gio`，版本为 2.88.3。
在 `nvim-test` 中调用 Neo-tree 的 GIO 后端，用主目录文件系统上的唯一临时文件
验证移入回收站、恢复及内容一致性，全部通过，测试文件已清理。
`checkhealth neo-tree` 显示 `OK gio is executable`，H09 消失。

范围限制：`/tmp` 上的测试失败，GIO 明确返回
`Trashing on system internal mounts is not supported`；不代表所有挂载点都支持回收站。
本次未改动 Neo-tree 键位，`d` 仍为 delete，`T` 为 trash。

### H39 / H44：补充 Docker Compose 文件类型识别

完整 `nvim-test` 配置实测四种标准 Compose 文件名原先均识别为 `yaml`，
而已启用的 `docker_compose_language_service` 仅匹配 `yaml.docker-compose`。
经用户确认，在启动入口用 `vim.filetype.add` 注册 `docker-compose.yml`、
`docker-compose.yaml`、`compose.yml`、`compose.yaml`。
复测四种文件均识别为 `yaml.docker-compose`，普通 `.yml` / `.yaml` 仍为 `yaml`。
当前测试环境没有 `docker-compose-langserver`，服务由项目 devShell 提供；
本次仅验证识别规则，实际 LSP 连接待在对应 devShell 中验证。GitLab / Helm 类型未改。

## 已调查的主要问题

| 问题组 | 已确认的事实与影响 | 仍未确认的部分 |
| --- | --- | --- |
| 语言服务缺失 | rust-analyzer、ansible-language-server、docker-compose-langserver、docker-langserver、pyright-langserver、ruff、terraform-ls 不在 Neovim 的可执行搜索路径中；对应服务不可用。 | 是否仅在某些项目的 devShell 中提供，尚未逐项目检查。 |
| Markdown / Obsidian | render-markdown 的 configuration 已通过；冲突检查调用 `obsidian.get_client()`，Obsidian 没有 client 因而抛错。本项目 Obsidian spec 没有 opts/config，且把本地配置的 `opt` 写入 `M.opt`，这不是 Lazy 的 `opts`。 | 尚未在真实 Obsidian vault 中验证全部行为；不能仅凭这次异常判定 Markdown 渲染整体失效。 |
| Markdown LaTeX | latex parser 不存在，ABI unknown 是伴随结果；utftex、latex2text 也未安装。 | 用户是否需要公式渲染，尚未确定。 |
| 输入框实现冲突 | Dressing health 显示它接管了 vim.ui.input；Snacks.input 已启用但检测到实现不属于自己。 | 真实交互中是否出现功能异常，需要用户场景复现。 |
| 窗口快捷键重复 | `lua/keymapping.lua` 和 `lua/plugins/which_key.lua` 使用 `<leader>wm` 表示 WinShift；LazyVim 同时给 Zoom 使用该键。 | 当前每种加载顺序下最终执行哪个动作，需要交互验证。 |
| Copilot | 基线报告中客户端不可用，由 Avante 的可选依赖引入；用户确认不需要，现已移除依赖与锁文件条目。 | 不再配置或验证 Copilot 认证；该错误不是 OpenRouter 密钥错误。 |
| 图片和图表预览 | 转换工具、部分 parser 和终端协议检查未通过；Snacks.image 当前禁用。 | 是否需要图片/PDF/公式/Mermaid；PTY 中的终端协议结果不能代替真实终端验证。 |
| 回收站 | 外部 trash/gio/KDE 命令不存在；Snacks.explorer 当前禁用。Neo-tree 明确提供自身 XDG trash 回退。 | 实际删除是否经过 Neo-tree 的回退实现，尚未做文件操作实验。 |
| SQLite | Snacks 通过 LuaJIT FFI 加载 sqlite3 动态库，不是仅检查 sqlite3 命令；失败后改用文件存储。 | 动态库究竟未安装还是 Nix 链接搜索路径不可见，尚未进一步定位。 |
| 多包管理器提示 | `site/pack/core/opt` 确实存在，且检查时为空；因此有 Lazy 目录警告和 vim.pack 缺锁警告。 | 尚无重复安装同一插件的证据。 |
| 图标提示不一致 | fzf-lua 报图标不可用，但 Neo-tree、render-markdown、which-key 都确认图标插件存在。 | fzf-lua 的后端初始化与 health 执行顺序还需专项复测。 |
| 复合 filetype | vim.lsp 将 `yaml.docker-compose`、`yaml.gitlab`、`yaml.helm-values` 报为未知；这是已知 filetype 表的检查。 | 尚未用真实文件验证 filetype 检测和服务器附着，不直接定性为配置错误。 |

源码核对范围：本地锁定版本的 `render-markdown/health.lua`、`obsidian/init.lua`、
`dressing/init.lua`、`snacks/picker/util/db.lua`、LazyVim `config/keymaps.lua`，以及 Neovim `vim/lsp/health.lua`。

## 全部 ERROR / WARNING

下表逐条列出基线工作区报告的每一次 ERROR / WARNING，不合并重复项。
H03、H09、H13、H31、H54 已修复，H02 已通过移除不用的功能处理，其余仍为待处理或待验证；H55 为迁移后新增的可选功能提示，不计入基线 54 条。

| 编号 | 级别 | 检查项 | 原始问题 | 调查结论 |
| --- | --- | --- | --- | --- |
| H01 | WARNING | Sources | Some providers may show up as "disabled" but are enabled dynamically (e.g. cmdline) | 提示性质：动态启用的 source 可能显示 disabled，不代表补全故障。 |
| H02 | ERROR | Copilot Authentication | Copilot LSP client not available | 客户端不可用，且报告没有凭据；本次是 Avante 的可选依赖，不能据此认定 Avante/OpenRouter 故障。 |
| H03 | WARNING | fzf-lua [optional] | `nvim-web-devicons` or `mini.icons` not found | 待复核：其他 health 确认图标插件已安装；可能是加载时机或 fzf-lua 图标后端状态，不是确定缺包。 |
| H04 | WARNING | fzf-lua [optional:media] | 'viu' not found | 可选图片预览工具缺失；不影响普通文本搜索，三个工具不要求全部安装。 |
| H05 | WARNING | fzf-lua [optional:media] | 'chafa' not found | 可选图片预览工具缺失；不影响普通文本搜索，三个工具不要求全部安装。 |
| H06 | WARNING | fzf-lua [optional:media] | 'ueberzugpp' not found | 可选图片预览工具缺失；不影响普通文本搜索，三个工具不要求全部安装。 |
| H07 | WARNING | Checking external dependencies | ast-grep: not found. Install [ast-grep](https://ast-grep.github.io) for extended capabilities | 扩展搜索能力所需的 ast-grep 缺失；rg 已通过检查。 |
| H08 | WARNING | lazy.nvim | found existing packages at `/home/ten/.local/share/nvim/site/pack/core` | 检测到另一套包目录；已核实 core/opt 为空，尚无实际重复插件证据。 |
| H09 | WARNING | Trash executables (prioritized in descending order, `:h neo-tree-trash`) | `gio` not found (from glib2) | gio 缺失；报告同时说明 Neo-tree 自带 XDG trash 回退，不能直接认定删除必然永久生效。 |
| H10 | WARNING | render-markdown.nvim [tree-sitter latex] | parser: not installed | Markdown 的可选 LaTeX 渲染依赖缺失；普通 Markdown parser 和高亮检查通过。 |
| H11 | WARNING | render-markdown.nvim [tree-sitter latex] | ABI: unknown | 同一 latex parser 缺失的派生警告，不是已确认的二进制 ABI 冲突。 |
| H12 | WARNING | render-markdown.nvim [latex] | none installed: { "utftex", "latex2text" } | Markdown 的可选 LaTeX 渲染依赖缺失；普通 Markdown parser 和高亮检查通过。 |
| H13 | ERROR | render-markdown.nvim [conflicts] | Failed to run healthcheck for "render-markdown" plugin. Exception: | 冲突检查调用未初始化的 Obsidian client 后抛错；配置校验已通过，不能归因于 Markdown 配置字段错误。 |
| H14 | ERROR | Checking external dependencies | rust-analyzer: not found: Could not find an executable binary. | 确定缺失 rust-analyzer；Rust LSP 不可用，cargo/rustc 已存在。 |
| H15 | WARNING | Snacks.explorer | setup {disabled} | 该模块被配置为禁用；状态提示，不应单独视为故障。 |
| H16 | ERROR | Snacks.explorer | None of the tools found: 'trash', 'gio', 'kioclient5', 'kioclient' | Explorer 本次已禁用；缺少外部回收站工具是其可选功能问题，和 Neo-tree 的回退行为不同。 |
| H17 | WARNING | Snacks.explorer | No system trash command found; deleting files will be permanent | Explorer 本次已禁用；缺少外部回收站工具是其可选功能问题，和 Neo-tree 的回退行为不同。 |
| H18 | WARNING | Snacks.image | setup {disabled} | 该模块被配置为禁用；状态提示，不应单独视为故障。 |
| H19 | ERROR | Snacks.image | None of the tools found: 'kitty', 'wezterm', 'ghostty' | 图片模块已禁用；当前 TERM=foot，PTY 不完整模拟图形协议，终端兼容性仍需真实窗口核实。 |
| H20 | ERROR | Snacks.image | None of the tools found: 'magick', 'convert' | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H21 | ERROR | Snacks.image | `magick` is required to convert images. Only PNG files will be displayed. | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H22 | WARNING | Snacks.image | Missing Treesitter languages: `css`, `latex`, `norg`, `scss`, `svelte`, `typst`, `vue` | 图片嵌入相关 parser 不齐；不表示已安装语言的普通代码高亮全部失效。 |
| H23 | WARNING | Snacks.image | Image rendering in docs with missing treesitter parsers won't work | 图片嵌入相关 parser 不齐；不表示已安装语言的普通代码高亮全部失效。 |
| H24 | ERROR | Snacks.image | Tool not found: 'gs' | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H25 | WARNING | Snacks.image | `gs` is required to render PDF files | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H26 | ERROR | Snacks.image | None of the tools found: 'tectonic', 'pdflatex' | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H27 | WARNING | Snacks.image | `tectonic` or `pdflatex` is required to render LaTeX math expressions | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H28 | ERROR | Snacks.image | Tool not found: 'mmdc' | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H29 | WARNING | Snacks.image | `mmdc` is required to render Mermaid diagrams | 图片模块已禁用；缺少对应图片/PDF/LaTeX/Mermaid 转换工具，仅影响启用后的相应功能。 |
| H30 | ERROR | Snacks.image | your terminal does not support the kitty graphics protocol | 图片模块已禁用；当前 TERM=foot，PTY 不完整模拟图形协议，终端兼容性仍需真实窗口核实。 |
| H31 | ERROR | Snacks.input | `vim.ui.input` is not set to `Snacks.input` | 输入框接管冲突：Dressing 报告 vim.ui.input active，Snacks 期望自己的实现。 |
| H32 | WARNING | Snacks.picker | setup {disabled} | 该模块被配置为禁用；状态提示，不应单独视为故障。 |
| H33 | WARNING | Snacks.picker | `vim.ui.select` for `Snacks.picker` is not enabled | 本次 Snacks picker 已禁用，Dressing/Telescope 接管选择框；属于当前配置状态。 |
| H34 | WARNING | Snacks.picker | `SQLite3` is not available. Frecency and history will be stored in a file instead. | SQLite 动态库不可加载；已回退文件存储，不代表历史功能完全失效，也不是 SQL 数据库插件残留。 |
| H35 | WARNING | Snacks.statuscolumn | setup {disabled} | 该模块被配置为禁用；状态提示，不应单独视为故障。 |
| H36 | WARNING | System Info | Nvim 0.12.5 is available (current: 0.12.4) | 版本更新提示；仅记录本次 health 查询结果，不代表当前版本不能使用。 |
| H37 | WARNING | vim.lsp: Enabled Configurations | 'ansible-language-server' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H38 | WARNING | vim.lsp: Enabled Configurations | 'docker-compose-langserver' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H39 | WARNING | vim.lsp: Enabled Configurations | Unknown filetype 'yaml.docker-compose' (Hint: filename extension != filetype). | 复合 filetype 未被健康检查的已知类型表识别；尚不能认定真实文件检测或 LSP attach 失败。 |
| H40 | WARNING | vim.lsp: Enabled Configurations | 'docker-langserver' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H41 | WARNING | vim.lsp: Enabled Configurations | 'pyright-langserver' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H42 | WARNING | vim.lsp: Enabled Configurations | 'ruff' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H43 | WARNING | vim.lsp: Enabled Configurations | 'terraform-ls' is not executable. Configuration will not be used. | 确定：配置声明的命令在 Neovim 包装后的 PATH 中不可执行，该 LSP 配置不会启用。 |
| H44 | WARNING | vim.lsp: Enabled Configurations | Unknown filetype 'yaml.docker-compose' (Hint: filename extension != filetype). | 复合 filetype 未被健康检查的已知类型表识别；尚不能认定真实文件检测或 LSP attach 失败。 |
| H45 | WARNING | vim.lsp: Enabled Configurations | Unknown filetype 'yaml.gitlab' (Hint: filename extension != filetype). | 复合 filetype 未被健康检查的已知类型表识别；尚不能认定真实文件检测或 LSP attach 失败。 |
| H46 | WARNING | vim.lsp: Enabled Configurations | Unknown filetype 'yaml.helm-values' (Hint: filename extension != filetype). | 复合 filetype 未被健康检查的已知类型表识别；尚不能认定真实文件检测或 LSP attach 失败。 |
| H47 | WARNING | vim.pack: basics | Lockfile is absent, plugin directory is present. Restart Nvim and run `vim.pack.add({})` to regenerate the lockfile | 原生包目录存在但锁文件缺失；core/opt 为空，和 lazy 的目录提示同一背景。 |
| H48 | WARNING | checking for overlapping keymaps | In mode `n`, <g> overlaps with <gc>, <gcc>, <gcO>, <gco>, <g%>, <gP>, <gp>, <g_>, <gzh>, <gzr>, <gzn>, <gzf>, <gzd>, <gzF>, <gza>, <gra>, <grn>, <grx>, <gri>, <grr>, <grt>, <g[>, <g]>, <gs>, <gx>, <gO>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H49 | WARNING | checking for overlapping keymaps | In mode `x`, <a> overlaps with <an>, <a%>, <ai>, <al>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H50 | WARNING | checking for overlapping keymaps | In mode `x`, <i> overlaps with <ii>, <in>, <il>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H51 | WARNING | checking for overlapping keymaps | In mode `o`, <a> overlaps with <ai>, <an>, <al>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H52 | WARNING | checking for overlapping keymaps | In mode `o`, <i> overlaps with <ii>, <in>, <il>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H53 | WARNING | checking for overlapping keymaps | In mode `n`, <gc> overlaps with <gcc>, <gcO>, <gco>: | 前缀重叠提示；多数是 Vim 的操作符/文本对象组合，不等于映射被覆盖。 |
| H54 | WARNING | Checking for duplicate mappings | Duplicates for <<LEADER>wm> in mode `n`: | 真实快捷键语义冲突：自定义 WinShift/Windows Manager 与 LazyVim Zoom 共用 <leader>wm。 |

## 部署配置与工作区的差异

以下按检查模块、子项、诊断文本对比；路径与快捷键列举顺序的变化不代表新增故障。
部署仍包含已从工作区移除的 OpenCode；其可执行文件缺失应作为“旧配置仍在使用”的证据。
工作区的 Snacks picker 禁用，而部署配置启用；两者的 UI select 诊断因此不同。

| 来源 | 检查项 | 诊断 |
| --- | --- | --- |
| 仅部署报告 | opencode.nvim [binaries] | `opencode` executable not found in `$PATH`. |
| 仅部署报告 | Snacks.picker | `vim.ui.select` is not set to `Snacks.picker.select` |
| 仅部署报告 | checking for overlapping keymaps | In mode `n`, <g> overlaps with <gO>, <gzr>, <gzf>, <gza>, <gzd>, <gzn>, <gzh>, <gzF>, <gc>, <gcc>, <gco>, <gcO>, <grr>, <gra>, <grx>, <grn>, <gri>, <grt>, <g_>, <gp>, <go>, <goo>, <gP>, <g[>, <g%>, <gx>, <g]>, <gs>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `x`, <a> overlaps with <a%>, <an>, <ai>, <al>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `x`, <i> overlaps with <in>, <ii>, <il>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `o`, <a> overlaps with <an>, <ai>, <al>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `o`, <i> overlaps with <in>, <ii>, <il>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `n`, <go> overlaps with <goo>: |
| 仅部署报告 | checking for overlapping keymaps | In mode `n`, <gc> overlaps with <gcc>, <gco>, <gcO>: |
| 仅工作区报告 | Snacks.picker | setup {disabled} |
| 仅工作区报告 | Snacks.picker | `vim.ui.select` for `Snacks.picker` is not enabled |
| 仅工作区报告 | checking for overlapping keymaps | In mode `n`, <g> overlaps with <gc>, <gcc>, <gcO>, <gco>, <g%>, <gP>, <gp>, <g_>, <gzh>, <gzr>, <gzn>, <gzf>, <gzd>, <gzF>, <gza>, <gra>, <grn>, <grx>, <gri>, <grr>, <grt>, <g[>, <g]>, <gs>, <gx>, <gO>: |
| 仅工作区报告 | checking for overlapping keymaps | In mode `x`, <a> overlaps with <an>, <a%>, <ai>, <al>: |
| 仅工作区报告 | checking for overlapping keymaps | In mode `x`, <i> overlaps with <ii>, <in>, <il>: |
| 仅工作区报告 | checking for overlapping keymaps | In mode `o`, <a> overlaps with <ai>, <an>, <al>: |
| 仅工作区报告 | checking for overlapping keymaps | In mode `o`, <i> overlaps with <ii>, <in>, <il>: |
| 仅工作区报告 | checking for overlapping keymaps | In mode `n`, <gc> overlaps with <gcc>, <gcO>, <gco>: |

## 未被 checkhealth 证明正常的事项

- Avante health 主要检查依赖插件和 TreeSitter，显示 OK 不等于 API 密钥、模型请求或原生模块可用。此前单独检查发现的情况保留在 [Avante 调查](avante-review.md)，不伪装成本次 checkhealth 的 ERROR。
- crates 的报告明确写明 setup 未调用而跳过；不能把绿色标题理解为 Rust 全功能已验证。
- Rust 调试依赖、Neo-tree 文件操作 LSP 集成等以普通信息或可选项显示，未全部启用；未归入 ERROR/WARNING 计数。
- 未打开具体项目，因此没有验证全部语言的真实诊断、补全、格式化和调试。
- 每项修改前先确认要保留的功能及方案；用户决策后才修复，并单独复测。

## 核验

已将两份原始报告中的每条 ERROR/WARNING 与本文清单及差异表逐项对应，统计自动生成。
原始报告完整保留 OK、普通信息和异常上下文，方便后续复查。
后续修复应在相同配置入口复测，并记录消失的诊断编号；不要把“模块禁用”与“功能修好”混为一谈。
