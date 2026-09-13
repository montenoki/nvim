import fs from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const here = path.dirname(fileURLToPath(import.meta.url));
const docs = path.resolve(here, "..");
const data = JSON.parse(fs.readFileSync(path.join(docs, "nvim-capabilities.json"), "utf8"));
const sections = {
  capabilities: ["能力总表", [["id", "ID"], ["category", "领域"], ["capability", "能力"], ["providers", "实现／插件"], ["scope", "模式与范围"], ["entries", "全部主要入口"], ["windows", "窗口／界面"], ["availability", "启用与条件"], ["overlap", "比较标签"], ["question", "待定边界"], ["sources", "配置依据"]]],
  groups: ["边界与重叠比较", [["id", "ID"], ["category", "比较组"], ["kind", "重叠类型"], ["capabilities", "能力 ID"], ["question", "逐项判断的问题"]]],
  plugins: ["插件与依赖", [["id", "ID"], ["plugin", "插件"], ["category", "类别"], ["role", "角色"], ["availability", "当前状态"], ["capabilities", "能力 ID"], ["condition", "条件"], ["loading", "加载声明"], ["dependencies", "依赖"], ["commit", "锁定提交"], ["sources", "配置依据"]]],
  windows: ["窗口与界面", [["id", "ID"], ["filetype", "filetype／模式／界面"], ["title", "显示名称"], ["provider", "提供方"], ["open", "打开方式"], ["availability", "出现条件"], ["target", "文件打开目标"], ["capabilities", "能力 ID"], ["sources", "配置依据"]]],
  keys: ["快捷键与局部入口", [["id", "ID"], ["key", "按键"], ["mode", "模式"], ["scope", "作用域"], ["description", "动作"], ["providers", "提供方"], ["rhs", "映射内容"], ["evidence", "采集依据"]]],
  tools: ["语言与外部工具链", [["id", "ID"], ["category", "类型"], ["tool", "服务／程序"], ["scope", "文件类型／能力 ID"], ["provider", "调度方"], ["availability", "启用条件"], ["config", "最终配置"], ["question", "待复核边界"], ["sources", "配置依据"]]],
};
const ids = new Set();
if (data.schemaVersion !== 1) throw new Error("不支持的数据版本");
for (const [section, [, columns]] of Object.entries(sections)) {
  if (!Array.isArray(data[section])) throw new Error(`缺少 ${section}`);
  for (const row of data[section]) {
    if (!row.id || ids.has(row.id)) throw new Error(`重复或空 ID：${row.id}`);
    ids.add(row.id);
    if (!data.meta.statuses.includes(row.status) || !data.meta.decisions.includes(row.decision)) throw new Error(`非法筛查状态：${row.id}`);
    for (const [field] of columns) if (row[field] === undefined) throw new Error(`${row.id} 缺少 ${field}`);
    for (const source of row.sources || []) {
      if (!fs.existsSync(path.resolve(docs, "..", source))) throw new Error(`不存在的来源：${source}`);
    }
  }
}
const capIds = new Set(data.capabilities.map(r => r.id));
for (const section of ["groups", "plugins", "windows"]) for (const row of data[section]) {
  for (const id of row.capabilities) if (!capIds.has(id)) throw new Error(`${row.id} 引用了不存在的能力 ${id}`);
}
const esc = value => String(value ?? "").replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;").replaceAll("'", "&#39;");
const text = value => Array.isArray(value) ? value.join("；") : value && typeof value === "object" ? JSON.stringify(value) : String(value ?? "");
const md = value => esc(text(value)).replaceAll("|", "&#124;").replaceAll("`", "&#96;").replaceAll(/\r?\n/g, "<br>");
const sourceLink = src => `[${src}](${src.startsWith("docs/") ? src.slice(5) : "../" + src})`;
const reviewColumns = [["status", "筛查状态"], ["decision", "处理决定"], ["notes", "备注／验收结果"]];
const summary = Object.entries(sections).map(([key, [label]]) => {
  const rows = data[key];
  const decided = rows.filter(r => ["已决定", "待实施", "已验收"].includes(r.status)).length;
  return `| ${label} | ${rows.length} | ${decided} | ${rows.filter(r => r.status === "已验收").length} |`;
}).join("\n");
let markdown = `<!-- 由 tools/render-capabilities.mjs 生成；修改 nvim-capabilities.json 后重新生成。 -->
# ${data.meta.title}

审计日期：${data.meta.date}；基准提交：\`${data.meta.revision}\`。

${data.meta.scope}

[打开可筛选和记录进度的 HTML 视图](nvim-capabilities.html) · [可维护的数据](nvim-capabilities.json) · [维护与重新采集说明](tools/README.md)

## 使用方式与状态栏

${data.meta.reviewInstructions.map(s => "- " + s).join("\n")}
- HTML 支持搜索、按领域／状态／决定／启用条件筛选，状态与备注先保存在当前浏览器。点“导出 JSON”后替换仓库中的同名数据文件，再运行生成命令，才能把进度保存进 Git。
- 本 Markdown 是生成快照；请修改 JSON，避免下一次生成覆盖手工修改。
- \`<leader>\` 与 \`<localleader>\` 都是空格。n 普通、x 可视、s Select、o 操作等待、i 插入、t 终端、c 命令行。\`<Plug>\` 是内部映射标识。

| 维度 | 条目 | 已作决定（含待实施、已验收） | 已验收 |
| --- | ---: | ---: | ---: |
${summary}

## 切分边界时先回答的问题

| 层次 | 本层决定 | 与其他层的关系 |
| --- | --- | --- |
| 用户任务 | 我是找文件、查符号、读诊断，还是执行调试？ | 能力总表的一行应能对应一次实际使用目的。 |
| 数据与工具 | 谁产生数据或执行修改？ | LSP、lint、formatter、DAP、Git 与显示它们的窗口分开评估。 |
| 视图 | 临时搜索、常驻列表、内联提示分别是否需要？ | 同一批诊断可以有多个视图，但每个视图应有明确使用场景。 |
| 实现 | 谁是主要插件，谁只是库、适配器或条件后端？ | 删实现前先查看其能力 ID、依赖和调用者。 |
| 入口 | 保留哪个主键，哪些是别名，哪些只是命令或按钮？ | 同动作多入口与多个插件重复实现分开处理。 |
| 作用域 | 根目录/cwd、文档/项目、普通/局部/Select 是否不同？ | 同一个键出现在不同场景不自动等于冲突。 |
| 验收 | 什么现象说明调整完成？ | 在备注记录目标行为，实施后再标已验收。 |

优先比较：R01 选择器、R02 文件发现、R03 诊断、R04 符号、R05 结果列表、R06 消息、R08 缩放别名。Git 的已知决定见 G01/G02 和 R09。

## 采集边界

${data.meta.limits.map(s => "- " + s).join("\n")}
- 本次读取 ${data.meta.capture.localConfigurationFiles} 个本地 Lua 文件；最终配置中有 ${data.meta.capture.effectivePlugins} 个有效插件、${data.meta.capture.pluginKeyDeclarations} 条插件键位声明、${data.meta.capture.runtimeMappings} 条全局运行时映射。合并、展开模式并补充局部入口后形成下面的键位表，三个数字不能直接相加。
- 运行环境：\`${md(data.meta.runtime)}\`。插件版本见插件表的锁定提交；“已启用”表示配置层，不代表联网、调试、外部命令都执行验证过。

`;
for (const [key, [label, columns]] of Object.entries(sections)) {
  const allColumns = [...columns, ...reviewColumns];
  markdown += `## ${label}（${data[key].length}）\n\n`;
  markdown += `| ${allColumns.map(c => c[1]).join(" | ")} |\n| ${allColumns.map(() => "---").join(" | ")} |\n`;
  markdown += data[key].map(row => "| " + allColumns.map(([field]) => field === "sources" ? row.sources.map(sourceLink).join("<br>") : md(row[field])).join(" | ") + " |").join("\n") + "\n\n";
}
const template = fs.readFileSync(path.join(here, "capabilities-viewer.html"), "utf8");
const viewer = fs.readFileSync(path.join(here, "capabilities-viewer.js"), "utf8");
const payload = JSON.stringify(data).replaceAll("<", "\\u003c").replaceAll("\u2028", "\\u2028").replaceAll("\u2029", "\\u2029");
const html = template.replace("<!-- DATA -->", `<script id="capability-data" type="application/json">${payload}</script>`).replace("<!-- VIEWER -->", `<script>\n${viewer}\n</script>`);
fs.writeFileSync(path.join(docs, "nvim-capabilities.md"), markdown);
fs.writeFileSync(path.join(docs, "nvim-capabilities.html"), html);
console.log(`已校验 ${ids.size} 个唯一条目，生成 Markdown 与独立 HTML。`);
