# 能力审计表的维护

[HTML 筛查视图](../nvim-capabilities.html) · [Markdown 总表](../nvim-capabilities.md) · [JSON 数据](../nvim-capabilities.json)

`nvim-capabilities.json` 是唯一维护源。Markdown 和独立 HTML 都由它生成；HTML
没有网络请求、CDN 或服务端依赖，可以直接用浏览器打开。

## 记录筛查进度

1. 在 HTML 里选维度，搜索或筛选条目，填写“筛查状态”“处理决定”“备注”。
2. 修改自动存入当前浏览器的 localStorage；浏览器限制本地文件存储时页面会提示，仍可导出。
3. 点“导出 JSON”，将下载文件替换 `docs/nvim-capabilities.json`。
4. 在仓库运行下面的命令，重新生成 Markdown 和 HTML，再提交这些文档。

```sh
node docs/tools/render-capabilities.mjs
git diff --check
```

“导入 JSON 进度”只按稳定 ID 导入状态、决定和备注，不覆盖当前快照的能力描述。
已有浏览器草稿会优先于文件中的进度；需要以更新后的 JSON 为准时，明确导入该文件。
无痕浏览器、换浏览器或清除站点数据会丢失草稿，所以导出文件才是可长期保存的结果。

状态含义：

| 状态 | 何时使用 |
| --- | --- |
| 待筛查 | 还没判断是否需要 |
| 待试用 | 需要亲自操作后决定 |
| 已决定 | 已写明保留、合并、调整边界、停用或移除等决定 |
| 待实施 | 决定已明确，需要修改配置、依赖或快捷键 |
| 已验收 | 已完成需要的修改，并按备注中的目标行为验收 |

“已作决定”进度包含后三种状态。六个维度独立计数，同一能力对应的多行不会自动
连带完成；能力表用于任务级决策，插件/窗口/键位/工具表用于查漏。Lazygit 与 Neogit
的“有意并存”是用户已明确的决定，其余条目没有代替用户作出取舍。

## 修改内容或重新审计

- 保持已有 ID 稳定，便于跨版本导入进度。能力 ID 按领域编号；键位 ID 来源于键、模式和作用域。
- 增删、改键或更新插件后，先修改 JSON 的事实字段、来源与日期，再生成两个视图。
- 实现变化影响的条目应退回“待试用”或“待实施”，不要自动沿用旧“已验收”。
- `sources` 是相对仓库根目录的文件路径；生成器会验证来源存在、ID 唯一、能力关联有效、状态合法。
- 插件表包括有效声明、条件依赖、锁文件遗留、Nix 禁用项；不能把其总数当作已加载插件数。
- 窗口表的 `trouble:模式` 是组合标识；winbar/statusline/statuscolumn/tabline 是界面区域，不是 filetype。
- 快捷键包含插件最终声明、VeryLazy 后全局映射、LSP/语言局部补充和菜单摘要；普通空 buffer 不能验证所有局部覆盖。

这份表按当前工作区、本地已安装插件及其锁定版本整理；普通 `nvim` 的 Nix store
配置可能较旧。实测工作区请用 `NVIM_APPNAME=nvim-test nvim`。LSP、调试、AI、
Obsidian 等还需要各自的项目或外部环境。

重新采集时需要同时核对：

1. `lazy.core.config.plugins` 与 `lazy.core.plugin.values(plugin, "keys", true)` 的最终声明。
2. VeryLazy 后 `vim.api.nvim_get_keymap(mode)`，以及真实 LSP/插件窗口内的 buffer 局部映射。
3. `servers`、`formatters_by_ft`、`linters_by_ft` 的合并选项，语言 Extra 的单独管理器。
4. `lua/config/ui/windows.lua` 的窗口名称与打开目标规则，以及插件内部窗口的出现流程。
5. 使用场景和数据流；自动采集只能给出配置事实，不能代替“这些功能是否重复”的判断。

`capabilities-viewer.html`、`capabilities-viewer.js` 是视图模板；修改它们后也需要重新运行生成器。
