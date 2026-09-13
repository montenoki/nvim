"use strict";
(() => {
  const data = JSON.parse(document.getElementById("capability-data").textContent);
  const sections = { capabilities: "能力总表", groups: "边界比较", plugins: "插件与依赖", windows: "窗口与界面", keys: "快捷键", tools: "工具链" };
  const storageKey = "ten-nvim-capability-review-v1";
  const index = new Map(Object.keys(sections).flatMap(s => data[s].map(row => [row.id, row])));
  let active = "capabilities";
  const $ = id => document.getElementById(id);
  const esc = value => String(value ?? "").replaceAll("&", "&amp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll('"', "&quot;").replaceAll("'", "&#39;");
  const txt = value => Array.isArray(value) ? value.join("；") : value && typeof value === "object" ? JSON.stringify(value) : String(value ?? "");
  const show = value => esc(txt(value));
  const detail = value => value && txt(value) ? `<div class="detail">${show(value)}</div>` : "";
  const tag = value => value ? `<span class="tag">${show(value)}</span>` : "";
  const sources = row => (row.sources || []).map(src => {
    const href = src.startsWith("docs/") ? src.slice(5) : "../" + src;
    return `<a href="${esc(href)}">${esc(src)}</a>`;
  }).join("");
  const message = text => { $("message").textContent = text; };
  const reviewed = row => ["已决定", "待实施", "已验收"].includes(row.status);
  const options = (values, selected) => values.map(v => `<option value="${esc(v)}"${v === selected ? " selected" : ""}>${esc(v)}</option>`).join("");
  function reviewOf(row) { return { id: row.id, status: row.status, decision: row.decision, notes: row.notes || "" }; }
  function validateReviews(rows) {
    if (!Array.isArray(rows)) throw new Error("进度必须是数组");
    rows = rows.map(row => row && row.status === "已验证" ? { ...row, status: "已验收" } : row);
    const seen = new Set();
    for (const row of rows) {
      if (!row || typeof row.id !== "string" || seen.has(row.id)) throw new Error("进度 ID 缺失或重复");
      seen.add(row.id);
      if (!data.meta.statuses.includes(row.status) || !data.meta.decisions.includes(row.decision) || typeof row.notes !== "string") throw new Error(`条目 ${row.id} 的状态、决定或备注格式不正确`);
    }
    return rows;
  }
  function applyReviews(rows) {
    rows = validateReviews(rows);
    let count = 0;
    for (const row of rows) if (index.has(row.id)) {
      Object.assign(index.get(row.id), reviewOf(row));
      count++;
    }
    return count;
  }
  function persist() {
    try {
      const reviews = [...index.values()].map(reviewOf);
      localStorage.setItem(storageKey, JSON.stringify({ schemaVersion: 1, revision: data.meta.revision, reviews }));
      message("已保存到当前浏览器。需要保存进仓库时，请导出 JSON。");
    } catch {
      message("浏览器未允许本地存储；本次修改仍在页面中，请导出 JSON 保存。");
    }
  }
  try {
    const saved = JSON.parse(localStorage.getItem(storageKey) || "null");
    if (saved) {
      if (saved.schemaVersion !== 1) throw new Error("进度版本不支持");
      const count = applyReviews(saved.reviews);
      message(`已恢复浏览器中 ${count} 项进度${saved.revision !== data.meta.revision ? "（来自其他配置版本，请复核已验收项）" : ""}。`);
    }
  } catch (error) {
    message(`未恢复浏览器进度：${error.message}。可以使用 JSON 导入或导出。`);
  }
  function fillFilter(id, values, all) {
    const el = $(id), previous = el.value;
    el.innerHTML = `<option value="">${esc(all)}</option>` + options([...new Set(values.filter(Boolean))].sort(), previous);
  }
  function setupFilters() {
    const rows = data[active];
    fillFilter("category", rows.map(r => r.category), "全部类别");
    fillFilter("availability", rows.map(r => r.availability), "全部条件");
    $("availability").disabled = !rows.some(r => r.availability);
  }
  function filters() {
    return { query: $("search").value.trim().toLocaleLowerCase(), category: $("category").value, status: $("status-filter").value, decision: $("decision-filter").value, availability: $("availability").value };
  }
  function matches(row, f) {
    return (!f.category || row.category === f.category) && (!f.status || row.status === f.status) && (!f.decision || row.decision === f.decision) && (!f.availability || row.availability === f.availability) && (!f.query || f.query.split(/\s+/).every(q => JSON.stringify(row).toLocaleLowerCase().includes(q)));
  }
  const columns = {
    capabilities: ["能力与范围", "实现与入口", "窗口与条件", "边界与依据"],
    groups: ["比较组", "重叠类型", "关联能力", "判断问题"],
    plugins: ["插件与角色", "启用与加载", "能力与依赖", "配置与版本"],
    windows: ["名称与类型", "打开方式", "条件与目标", "关联能力与依据"],
    keys: ["按键与模式", "动作与作用域", "提供方与映射", "采集依据"],
    tools: ["服务与类型", "调度与条件", "最终配置", "边界与依据"],
  };
  function cells(row) {
    const title = value => `<div class="row-title">${show(value)}</div>`;
    const refs = `<div class="source-links">${sources(row)}</div>`;
    switch (active) {
      case "capabilities": return [title(row.capability) + tag(row.category) + detail(row.scope), show(row.providers) + detail(row.entries), show(row.windows) + detail(row.availability), tag(row.overlap) + show(row.question) + refs];
      case "groups": return [title(row.category), show(row.kind), show(row.capabilities), show(row.question)];
      case "plugins": return [title(row.plugin) + tag(row.category) + detail(row.role), show(row.availability) + detail(row.condition) + detail(row.loading), show(row.capabilities) + detail(row.dependencies), `<code>${show(row.commit)}</code>` + refs];
      case "windows": return [title(row.title) + `<code>${show(row.filetype)}</code>` + detail(row.provider), show(row.open), show(row.availability) + detail(row.target), show(row.capabilities) + refs];
      case "keys": return [title(row.key) + tag(row.mode), show(row.description) + detail(row.scope), show(row.providers) + detail(row.rhs), show(row.evidence)];
      case "tools": return [title(row.tool) + tag(row.category) + detail(row.scope), show(row.provider) + detail(row.availability), `<code>${show(row.config)}</code>`, show(row.question) + refs];
    }
  }
  function updateStats(visible) {
    const rows = data[active], done = rows.filter(reviewed).length;
    const all = [...index.values()];
    $("count").textContent = `${sections[active]} · ${visible} / ${rows.length}`;
    $("progress").max = Math.max(rows.length, 1);
    $("progress").value = done;
    $("progress-text").textContent = `本维度已作决定 ${done}/${rows.length} · 已验收 ${rows.filter(r => r.status === "已验收").length}`;
    $("all-progress").textContent = `全部维度已作决定 ${all.filter(reviewed).length}/${all.length}（关联行独立计数）`;
    $("stats").innerHTML = data.meta.statuses.map(s => `<span class="stat">${esc(s)} ${rows.filter(r => r.status === s).length}</span>`).join("");
  }
  function render() {
    $("tabs").innerHTML = Object.entries(sections).map(([key, label]) => `<button data-section="${key}" aria-pressed="${key === active}">${esc(label)} ${data[key].length}</button>`).join("");
    $("table-head").innerHTML = `<tr><th class="cell-id" scope="col">ID</th>${columns[active].map(label => `<th scope="col">${label}</th>`).join("")}<th class="cell-review" scope="col">筛查状态／处理决定</th><th class="cell-notes" scope="col">备注／验收结果</th></tr>`;
    const rows = data[active].filter(row => matches(row, filters()));
    $("table-body").innerHTML = rows.map(row => `<tr data-id="${esc(row.id)}"><td class="cell-id"><code>${esc(row.id)}</code></td>${cells(row).map(cell => `<td>${cell}</td>`).join("")}<td class="cell-review"><label>状态<select data-field="status" aria-label="${esc(row.id)} 筛查状态">${options(data.meta.statuses, row.status)}</select></label><label>决定<select data-field="decision" aria-label="${esc(row.id)} 处理决定">${options(data.meta.decisions, row.decision)}</select></label></td><td class="cell-notes"><textarea data-field="notes" rows="4" aria-label="${esc(row.id)} 备注" placeholder="目标边界、主入口、实测结果…">${esc(row.notes)}</textarea></td></tr>`).join("") || '<tr><td colspan="7" class="empty">当前筛选没有匹配项。</td></tr>';
    updateStats(rows.length);
  }
  $("tabs").addEventListener("click", event => {
    const button = event.target.closest("button[data-section]");
    if (!button) return;
    active = button.dataset.section;
    $("category").value = "";
    $("availability").value = "";
    setupFilters(); render();
  });
  $("table-body").addEventListener("input", event => {
    if (event.target.dataset.field !== "notes") return;
    const row = index.get(event.target.closest("tr").dataset.id);
    row.notes = event.target.value;
    persist();
  });
  $("table-body").addEventListener("change", event => {
    const field = event.target.dataset.field;
    if (!["status", "decision"].includes(field)) return;
    const row = index.get(event.target.closest("tr").dataset.id);
    row[field] = event.target.value;
    persist(); render();
  });
  for (const id of ["search", "category", "status-filter", "decision-filter", "availability"]) $(id).addEventListener(id === "search" ? "input" : "change", render);
  $("clear-filters").addEventListener("click", () => {
    for (const id of ["search", "category", "status-filter", "decision-filter", "availability"]) $(id).value = "";
    render();
  });
  $("export-json").addEventListener("click", () => {
    const blob = new Blob([JSON.stringify(data, null, 2) + "\n"], { type: "application/json;charset=utf-8" });
    const url = URL.createObjectURL(blob), link = document.createElement("a");
    link.href = url; link.download = "nvim-capabilities.json";
    document.body.append(link); link.click(); link.remove();
    setTimeout(() => URL.revokeObjectURL(url), 1000);
    message("已导出全部维度的 JSON。将下载文件替换 docs/nvim-capabilities.json 后运行生成命令，即可保存进仓库。");
  });
  $("import-json").addEventListener("click", () => $("import-file").click());
  $("import-file").addEventListener("change", async event => {
    const file = event.target.files[0];
    if (!file) return;
    try {
      const incoming = JSON.parse(await file.text());
      if (incoming.schemaVersion !== 1 || Object.keys(sections).some(s => !Array.isArray(incoming[s]))) throw new Error("请选择本表导出的完整 JSON");
      const rows = Object.keys(sections).flatMap(s => incoming[s]);
      const count = applyReviews(rows);
      persist(); render();
      message(`已导入 ${count} 项进度，忽略 ${rows.length - count} 个当前快照中不存在的 ID。只更新状态、决定和备注；能力描述仍采用本页快照。`);
    } catch (error) { message(`导入失败，现有进度未改动：${error.message}`); }
    event.target.value = "";
  });
  $("snapshot").textContent = `${data.meta.date} · 工作区 ${data.meta.revision.slice(0, 7)} + 未提交变更 · ${data.meta.capture.effectivePlugins} 个有效插件 · Neovim ${data.meta.runtime.version}`;
  $("limits").innerHTML = data.meta.limits.map(s => `<li>${esc(s)}</li>`).join("");
  $("status-filter").innerHTML = '<option value="">全部状态</option>' + options(data.meta.statuses);
  $("decision-filter").innerHTML = '<option value="">全部决定</option>' + options(data.meta.decisions);
  setupFilters(); render();
})();
