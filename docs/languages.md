# 语言能力与依赖归属

本轮以 x86_64 Linux 为目标；ARM 保留原有 Nix 包集合，后续单独对齐。

## 安装边界

- **全局高亮**：NixOS 仓库 `home/cli/editor.nix` 聚合锁定 Nixpkgs 中全部
  Tree-sitter parser 和配套 queries，经 `NVIM_NIX_PARSER_RTP` 加入运行时目录。
  Lazy 管理插件代码，Nix 模式禁止自动安装 parser 和 Mason 工具。
- **全局编辑**：工具由 Neovim 的 Nix `extraPackages` 提供，普通目录中的零散
  文件也可用。Schema 补全依赖匹配规则，远程 Schema 可能需要联网。
- **项目开发**：Python、Rust、Ansible、Terraform 等保留现有配置，工具由项目
  devShell 提供。先 `nix develop` 再启动 Neovim；本次不新增模板或项目配置机制。
  没有语言服务器仍能高亮，Rust 等已有配置可能提示缺少工具。

## 通用编辑清单

| 文件 | 语言服务 / 编辑辅助 | 格式化 / 检查 | 配置入口 |
| --- | --- | --- | --- |
| JSON / JSONC | jsonls、SchemaStore | Prettier | JSON Extra、`config_files.lua` |
| YAML | yamlls、SchemaStore | Prettier | YAML Extra、`config_files.lua` |
| TOML | Taplo；Cargo.toml 另保留 crates.nvim | Taplo | TOML Extra、`config_files.lua` |
| Nix | nil | nixfmt、statix | Nix Extra |
| Lua / Neovim | lua_ls、lazydev | StyLua | LazyVim 默认配置 |
| Vimscript | vimls | 服务器诊断 | `config_files.lua` |
| Bash / sh | bashls | shfmt；bashls 调用 ShellCheck | `bash.lua` |
| Fish | fish_lsp | fish_indent、fish 语法检查 | `bash.lua` |
| Zsh | 内置 syntax / Nix parser | `zsh --no-exec` 语法检查 | `bash.lua` |
| Markdown | Marksman；笔记库使用 Obsidian | Prettier | `markdown.lua` |
| CSV / TSV | csvview：按列显示、移动、维度统计 | 虚拟对齐，不注册格式化器 | `csv.lua` |
| XML / XSD / XSL / SVG | LemMinX | LSP 格式化、可用的 Schema 校验 | `xml.lua` |
| HTML / CSS / SCSS / Less | html、cssls | Prettier | `web.lua` |
| JS / TS / JSX / TSX / MJS / CJS | ts_ls | Prettier | `web.lua` |
| QML | qmlls，含 Qt / Quickshell 模块目录 | qmlformat | `qml.lua` |
| Dockerfile / Containerfile | dockerls | Hadolint | Docker Extra |
| Compose | docker_compose_language_service、yamlls | Prettier | Docker Extra、文件名识别 |
| SQL | 高亮 | sql-formatter 默认 SQL 方言 | `sql.lua` |
| INI / conf / .env | 内置文件类型识别、syntax、注释 | 基础编辑，不推断各程序的字段规则 | Neovim runtime |
| Git 配置 / ignore / commit / diff | 高亮、现有 Git 辅助 | 保留原工作流 | Git Extra |

`lua/plugins/languages/` 存放语言映射；`lua/plugins/coding/` 保留共享策略。
JSON/YAML/TOML/Nix 等复用 Extra，不复制整套上游设置。

Compose 文件识别覆盖基础文件名以及环境/用途后缀，例如 `docker-compose.dev.yml`、
`compose.prod.yaml`、`compose.override.yaml`，不改变其他 YAML 的文件类型。

### CSV / TSV

打开后自动启用表格显示。`]v` / `[v` 移到下一列 / 上一列末尾，只在 CSV 视图内生效。
`:CsvViewInfo` 查看行列数、分隔符和表头，`:CsvViewToggle` 切换原文与表格显示。
非标准分隔符可用 `:CsvViewEnable delimiter=;` 显式指定。

对齐由虚拟文字实现，不添加空格到文件中；以 `#` 或 `//` 开头的字段仍是数据。
维度统计辅助检查列结构，不代表完整的 CSV 数据校验或电子表格计算功能。

### QML / Quickshell

Nix 的 `qmlls` wrapper 使用与系统 Quickshell 相同的 Nixpkgs / Qt，传入模块搜索
目录；不修改整个桌面会话的 `QML_IMPORT_PATH`。`qmlformat` 使用同一份 Qt。

Quickshell 的 `qs.*` 导入以及运行时生成的组件可能需要 shell 自己的 `.qmlls.ini`。
需要时在 `shell.qml` 旁创建空 `.qmlls.ini`，由 Quickshell 运行时生成本机配置，
不要提交其中的机器路径。本轮不启动桌面服务或生成项目配置。

### 边界

- JS/TS 语言服务器由 Nixpkgs 提供固定 TypeScript 后端；项目 npm 依赖和构建工具
  不因此变成全局依赖。QML 中的 JavaScript 由 QML 工具处理。
- Qt JS 不做全局内容识别。项目显式声明 `javascript.qml` 后，使用 qmlformat
  和 JS 基础高亮，不接入 ts_ls；这类独立资源没有完整 JS LSP。
  NixOS 项目的声明留到维护 Quickshell 时添加。在此之前，独立 `.js` 仍按普通 JS
  处理，带 Qt 指令的资源可能遇到语言服务或 Prettier 报错。
- Zsh 不套用 Bash LS 或 shfmt。SQL 不配置数据库连接，特殊方言留给具体项目。
- Zsh 通过 `-s` 检查未保存内容；此模式的错误没有行号，因此作为文件级诊断显示在首行。
- 编辑 Docker 文件不需要启动 Docker daemon，也不自动构建或运行容器。
- systemd 服务在 NixOS 项目中通过 Nix 定义和部署，沿用 Nix 编辑能力，不额外安装 systemd 语言服务器。
- Neovim 不再安装 debugpy 或 CodeLLDB，不接入 DAP。
- 旧 `.neoconf.json` 没有启用的 neoconf 插件读取，本次不将其接成项目设置入口。

## 验证与部署

构建编辑器依赖和 parser runtime，再用源码配置打开无项目标记的临时样例，
检查 LSP、格式化、parser/query 加载，以及 CSV 原文不变。
已有 UFO 兼容性检查见 [tests/README.md](../tests/README.md)。

2026-09-16 验证记录（x86_64，Neovim 0.12.5）：

- 326 种 parser 和 1,168 份查询成功加载；合并 Extras 后安装清单仍为空，Mason 禁用。
- 初次重构的 28 份零散文件样例、114 项检查通过，其中 21 份验证了语言服务器连接。
  随后按实际工作流移除了额外的 systemd 支持，该样例不再属于通用编辑验收范围。
- JSON/YAML/TOML 错误诊断、Zsh/Fish/Hadolint 检查、Quickshell 类型悬浮说明通过。
- 初次 Qt JS 自动识别和格式化验证通过；随后移除了全局自动识别，保留
  显式 `javascript.qml` 的 qmlformat 配置，项目声明尚未添加。
- CSV/TSV 原文不变、Zsh stdin 诊断与清理、UFO 无 LSP/parser 回退的兼容性测试通过。
- Nix 工具、parser 聚合目录和 t14 的 Home Manager Neovim 包构建成功。
- StyLua、nixfmt、两仓库 diff 检查、能力文档生成校验通过；未部署系统。

修改分别位于 Neovim 和 NixOS 两个仓库。更新 NixOS 的 `nvim-config` input 并部署
后才会同时生效；开发验证可用 `NVIM_APPNAME=nvim-test` 指向源码，并显式提供
新工具 PATH 与 `NVIM_NIX_PARSER_RTP`。只更新 Lua 配置不能补齐 Nix 依赖。

参考：[Nixpkgs Neovim 文档](https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/neovim.section.md)、
[csvview](https://github.com/hat0uma/csvview.nvim)、
[Quickshell 编辑器设置](https://quickshell.org/docs/v0.3.0/guide/install-setup/)。
