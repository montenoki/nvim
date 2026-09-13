# 当前键位清单

按本机已安装插件和配置在 2026-09-13 的状态整理，不重新分配按键。
`<leader>` 和 `<localleader>` 都是空格；`M`/`A` 都表示 Alt。
模式：`n` 普通、`x` 可视、`s` Select（如片段占位符）、`o` 操作等待、`i` 插入、`t` 终端、`c` 命令行。

## 阅读与维护

- 按空格查看主分组；`<leader>?` 查看当前缓冲区键位；`Ctrl-w Space` 连续操作窗口。
- 自定义 `desc` 写在映射定义处。分组在 [which_key.lua](../lua/plugins/ui/which_key.lua)，
  继承文案的翻译在 [key_descriptions.lua](../lua/config/ui/key_descriptions.lua)。
- 中文翻译只作用于 Which-key；`:map` 和其他快捷键搜索可能仍显示上游英文。
- 下表合并已加载的全局映射与 lazy.nvim 最终键位声明，并补充 LSP / Git 局部映射。
  文件类型和服务器能力决定局部映射是否出现；表中“通用”不表示任何插件窗口都不会覆盖它。
- Neovim 的全部原生命令不重复抄录；`g`、`z`、`[`、`]`、文本对象等预设的菜单说明也已翻译。
- 本文是可阅读的现状快照，不参与加载。插件更新或改键后应复核；实时结果以当前缓冲区菜单为准。

## 分组

| 前缀                                      | 内容                                   |
| ----------------------------------------- | -------------------------------------- |
| `<leader>a`                               | AI 助手                                |
| `<leader>b` / `<leader><Tab>`             | 缓冲区 / 标签页                        |
| `<leader>c`                               | 代码                                   |
| `<leader>d` / `<leader>dP` / `<leader>dp` | 调试 / Python 调试 / 性能分析          |
| `<leader>f` / `<leader>s`                 | 文件与查找 / 搜索                      |
| `<leader>g` / `<leader>gh`                | Git / 改动块                           |
| `<leader>q`                               | 退出与会话                             |
| `<leader>t`                               | 任务                                   |
| `<leader>u`                               | 显示与开关                             |
| `<leader>w` / `<C-w>`                     | 窗口                                   |
| `<leader>x`                               | 诊断与 Quickfix                        |
| `g` / `gz` / `z`                          | 跳转与文本操作 / 包围符号 / 折叠与拼写 |
| `[` / `]`                                 | 上一个 / 下一个                        |
| `a` / `i`（操作等待、可视模式）           | 包含边界 / 内部文本                    |

## AI

| 按键                          | 模式 | 说明                      | 范围 | 来源        |
| ----------------------------- | ---- | ------------------------- | ---- | ----------- |
| <code>&lt;leader&gt;a?</code> | n    | Avante 选择模型           | 通用 | avante.nvim |
| <code>&lt;leader&gt;aB</code> | n    | Avante 添加全部已打开文件 | 通用 | avante.nvim |
| <code>&lt;leader&gt;aC</code> | n    | Avante 切换选区提示       | 通用 | avante.nvim |
| <code>&lt;leader&gt;aM</code> | n    | Avante 选择 ACP 模型      | 通用 | avante.nvim |
| <code>&lt;leader&gt;aR</code> | n    | Avante 显示仓库结构       | 通用 | avante.nvim |
| <code>&lt;leader&gt;aS</code> | n    | Avante 停止生成           | 通用 | avante.nvim |
| <code>&lt;leader&gt;aa</code> | nxs  | Avante 提问               | 通用 | avante.nvim |
| <code>&lt;leader&gt;ad</code> | n    | Avante 切换调试日志       | 通用 | avante.nvim |
| <code>&lt;leader&gt;ae</code> | xs   | Avante 编辑选区           | 通用 | avante.nvim |
| <code>&lt;leader&gt;af</code> | n    | Avante 聚焦侧栏           | 通用 | avante.nvim |
| <code>&lt;leader&gt;ah</code> | n    | Avante 选择历史对话       | 通用 | avante.nvim |
| <code>&lt;leader&gt;am</code> | n    | Avante 选择 ACP 模式      | 通用 | avante.nvim |
| <code>&lt;leader&gt;an</code> | nxs  | Avante 新建对话           | 通用 | avante.nvim |
| <code>&lt;leader&gt;ar</code> | n    | Avante 刷新               | 通用 | avante.nvim |
| <code>&lt;leader&gt;as</code> | n    | Avante 切换自动建议       | 通用 | avante.nvim |
| <code>&lt;leader&gt;at</code> | n    | Avante 切换侧栏           | 通用 | avante.nvim |
| <code>&lt;leader&gt;az</code> | nxs  | Avante 切换专注模式       | 通用 | avante.nvim |

## 文件与搜索

| 按键                                     | 模式 | 说明                               | 范围 | 来源       |
| ---------------------------------------- | ---- | ---------------------------------- | ---- | ---------- |
| <code>&lt;leader&gt;/</code>             | n    | 搜索文件内容（项目根目录）         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Space&gt;</code> | n    | 查找文件（项目根目录）             | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fB</code>            | n    | 全部缓冲区                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fE</code>            | n    | 文件树（Neo-tree）（当前工作目录） | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fF</code>            | n    | 查找文件（当前工作目录）           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fL</code>            | n    | 复制绝对路径及行号                 | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fR</code>            | n    | 最近文件（当前工作目录）           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fT</code>            | n    | 终端（当前工作目录）               | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fY</code>            | n    | 复制绝对路径                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fb</code>            | n    | 缓冲区                             | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fc</code>            | n    | 查找配置文件                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fe</code>            | n    | 文件树（Neo-tree）（项目根目录）   | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ff</code>            | n    | 查找文件（项目根目录）             | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fg</code>            | n    | 查找 Git 文件                      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fn</code>            | n    | 新建缓冲区                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fr</code>            | n    | 最近文件                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ft</code>            | n    | 终端（项目根目录）                 | 通用 | 运行时映射 |
| <code>&lt;leader&gt;fy</code>            | n    | 复制项目相对路径                   | 通用 | 运行时映射 |
| <code>&lt;leader&gt;s"</code>            | n    | 寄存器                             | 通用 | 运行时映射 |
| <code>&lt;leader&gt;s/</code>            | n    | 搜索历史                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sC</code>            | n    | 命令列表                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sD</code>            | n    | 当前文件诊断                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sG</code>            | n    | 搜索文件内容（当前工作目录）       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sH</code>            | n    | 搜索高亮组                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sM</code>            | n    | Man 手册                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sR</code>            | n    | 恢复上次搜索                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sS</code>            | n    | 工作区符号                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sT</code>            | n    | TODO/FIX/FIXME 注释                | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sW</code>            | n    | 搜索光标处单词（当前工作目录）     | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sW</code>            | x    | 搜索选中文字（当前工作目录）       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sa</code>            | n    | 自动命令                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sb</code>            | n    | 当前文件内容                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sc</code>            | n    | 命令历史                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sd</code>            | n    | 诊断列表                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sg</code>            | n    | 搜索文件内容（项目根目录）         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sh</code>            | n    | 帮助文档                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sj</code>            | n    | 跳转历史                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sk</code>            | n    | 快捷键列表                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sl</code>            | n    | 位置列表                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sm</code>            | n    | 跳转到标记                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sna</code>           | n    | 全部消息（Noice）                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;snd</code>           | n    | 清除全部消息                       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;snh</code>           | n    | 消息历史（Noice）                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;snl</code>           | n    | 最近一条消息（Noice）              | 通用 | 运行时映射 |
| <code>&lt;leader&gt;snt</code>           | n    | 搜索消息（Noice）                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sq</code>            | n    | Quickfix 列表                      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sr</code>            | nx   | 搜索并替换                         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ss</code>            | n    | 文件符号                           | 通用 | 运行时映射 |
| <code>&lt;leader&gt;st</code>            | n    | TODO 注释                          | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sw</code>            | n    | 搜索光标处单词（项目根目录）       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;sw</code>            | x    | 搜索选中文字（项目根目录）         | 通用 | 运行时映射 |

## 缓冲区与标签页

| 按键                                              | 模式 | 说明               | 范围 | 来源       |
| ------------------------------------------------- | ---- | ------------------ | ---- | ---------- |
| <code>&lt;leader&gt;,</code>                      | n    | 切换缓冲区         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;&lt;Tab&gt;</code> | n    | 新建标签页         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;[</code>           | n    | 上一个标签页       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;]</code>           | n    | 下一个标签页       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;d</code>           | n    | 关闭标签页         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;f</code>           | n    | 第一个标签页       | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;l</code>           | n    | 最后一个标签页     | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&lt;Tab&gt;o</code>           | n    | 关闭其他标签页     | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&#96;</code>                  | n    | 切换到上次缓冲区   | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bD</code>                     | n    | 关闭缓冲区及窗口   | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bP</code>                     | n    | 关闭未固定的缓冲区 | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bb</code>                     | n    | 切换到上次缓冲区   | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bd</code>                     | n    | 关闭缓冲区         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;be</code>                     | n    | 缓冲区列表         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bi</code>                     | n    | 关闭未显示的缓冲区 | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bj</code>                     | n    | 选择缓冲区         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bl</code>                     | n    | 关闭左侧缓冲区     | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bo</code>                     | n    | 关闭其他缓冲区     | 通用 | 运行时映射 |
| <code>&lt;leader&gt;bp</code>                     | n    | 切换缓冲区固定状态 | 通用 | 运行时映射 |
| <code>&lt;leader&gt;br</code>                     | n    | 关闭右侧缓冲区     | 通用 | 运行时映射 |

## 代码与诊断

| 按键                          | 模式 | 说明                           | 范围       | 来源               |
| ----------------------------- | ---- | ------------------------------ | ---------- | ------------------ |
| <code>&lt;leader&gt;cA</code> | n    | 文件级代码操作                 | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cC</code> | n    | 刷新并显示 CodeLens            | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cF</code> | nx   | 格式化嵌入语言                 | 通用       | 运行时映射         |
| <code>&lt;leader&gt;cR</code> | n    | 重命名文件                     | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cS</code> | n    | LSP 引用、定义等（Trouble）    | 通用       | 运行时映射         |
| <code>&lt;leader&gt;ca</code> | nx   | 代码操作                       | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cc</code> | nx   | 执行 CodeLens                  | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cd</code> | n    | 当前行诊断                     | 通用       | 运行时映射         |
| <code>&lt;leader&gt;cf</code> | nx   | 格式化                         | 通用       | 运行时映射         |
| <code>&lt;leader&gt;cl</code> | n    | LSP 信息                       | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;co</code> | n    | 整理导入                       | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cr</code> | n    | 重命名符号                     | LSP 支持时 | LSP                |
| <code>&lt;leader&gt;cs</code> | n    | 符号大纲（Trouble）            | 通用       | 运行时映射         |
| <code>&lt;leader&gt;cv</code> | n    | 选择 Python 虚拟环境           | python     | venv-selector.nvim |
| <code>&lt;leader&gt;cz</code> | n    | 中文排版：全文                 | 通用       | 运行时映射         |
| <code>&lt;leader&gt;cz</code> | x    | 中文排版：选中行               | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xL</code> | n    | 位置列表（Trouble）            | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xQ</code> | n    | Quickfix 列表（Trouble）       | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xT</code> | n    | TODO/FIX/FIXME 注释（Trouble） | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xX</code> | n    | 当前文件诊断（Trouble）        | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xl</code> | n    | 位置列表                       | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xq</code> | n    | Quickfix 列表                  | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xt</code> | n    | TODO 注释（Trouble）           | 通用       | 运行时映射         |
| <code>&lt;leader&gt;xx</code> | n    | 诊断列表（Trouble）            | 通用       | 运行时映射         |

## 调试与任务

| 按键                           | 模式 | 说明                       | 范围         | 来源            |
| ------------------------------ | ---- | -------------------------- | ------------ | --------------- |
| <code>&lt;leader&gt;dB</code>  | n    | 设置条件断点               | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dC</code>  | n    | 运行到光标                 | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dO</code>  | n    | 单步跳过                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dP</code>  | n    | 暂停调试                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dPc</code> | n    | 调试测试类                 | python       | nvim-dap-python |
| <code>&lt;leader&gt;dPt</code> | n    | 调试测试方法               | python       | nvim-dap-python |
| <code>&lt;leader&gt;da</code>  | n    | 带参数运行                 | 通用         | 运行时映射      |
| <code>&lt;leader&gt;db</code>  | n    | 切换断点                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dc</code>  | n    | 启动或继续调试             | 通用         | 运行时映射      |
| <code>&lt;leader&gt;de</code>  | nx   | 求值                       | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dg</code>  | n    | 移动调试位置（不执行）     | 通用         | 运行时映射      |
| <code>&lt;leader&gt;di</code>  | n    | 单步进入                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dj</code>  | n    | 向下移动                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dk</code>  | n    | 向上移动                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dl</code>  | n    | 再次运行上次调试           | 通用         | 运行时映射      |
| <code>&lt;leader&gt;do</code>  | n    | 单步跳出                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dph</code> | n    | 切换性能分析高亮           | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dpp</code> | n    | 切换性能分析               | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dps</code> | n    | 性能分析临时缓冲区         | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dr</code>  | n    | 切换调试 REPL              | 通用         | 运行时映射      |
| <code>&lt;leader&gt;ds</code>  | n    | 会话                       | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dt</code>  | n    | 终止调试                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;du</code>  | n    | 调试界面（DAP）            | 通用         | 运行时映射      |
| <code>&lt;leader&gt;dw</code>  | n    | 调试组件                   | 通用         | 运行时映射      |
| <code>&lt;leader&gt;ta</code>  | n    | 运行 Ansible Playbook/Role | yaml.ansible | nvim-ansible    |

## Git

| 按键                           | 模式 | 说明                                | 范围     | 来源       |
| ------------------------------ | ---- | ----------------------------------- | -------- | ---------- |
| <code>&lt;leader&gt;gB</code>  | nx   | 打开 Git 网页                       | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gG</code>  | n    | Git 界面（Lazygit）（当前工作目录） | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gL</code>  | n    | Git 提交历史（当前工作目录）        | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gS</code>  | n    | Git 暂存记录（stash）               | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gY</code>  | nx   | 复制 Git 网页链接                   | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gb</code>  | n    | 当前行 Git 归属                     | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gc</code>  | n    | Git 提交记录                        | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gd</code>  | n    | Git 改动文件                        | 通用     | 运行时映射 |
| <code>&lt;leader&gt;ge</code>  | n    | Git 状态文件树                      | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gf</code>  | n    | 当前文件 Git 历史                   | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gg</code>  | n    | Git 界面（Lazygit）（项目根目录）   | 通用     | 运行时映射 |
| <code>&lt;leader&gt;ghB</code> | n    | 查看整个文件 Git 归属               | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghD</code> | n    | 与上一提交比较当前文件              | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghR</code> | n    | 还原整个文件                        | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghS</code> | n    | 暂存整个文件                        | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghb</code> | n    | 查看当前行 Git 归属                 | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghd</code> | n    | 与索引比较当前文件                  | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghp</code> | n    | 行内预览改动块                      | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghr</code> | nx   | 还原改动块                          | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghs</code> | nx   | 暂存改动块                          | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;ghu</code> | n    | 撤销改动块暂存                      | Git 文件 | Git 文件   |
| <code>&lt;leader&gt;gl</code>  | n    | Git 提交记录                        | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gn</code>  | n    | Git 界面（Neogit）                  | 通用     | 运行时映射 |
| <code>&lt;leader&gt;gs</code>  | n    | 状态                                | 通用     | 运行时映射 |

## 显示与开关

| 按键                          | 模式 | 说明                          | 范围 | 来源       |
| ----------------------------- | ---- | ----------------------------- | ---- | ---------- |
| <code>&lt;leader&gt;uA</code> | n    | 切换标签栏                    | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uC</code> | n    | 预览并选择配色                | 通用 | fzf-lua    |
| <code>&lt;leader&gt;uD</code> | n    | 切换非活动代码淡化            | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uG</code> | n    | 切换 Git 行标记               | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uI</code> | n    | 检查语法树                    | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uL</code> | n    | 切换相对行号（记住选择）      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uS</code> | n    | 切换平滑滚动                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uT</code> | n    | 切换 Tree-sitter 高亮         | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uZ</code> | n    | 切换窗口最大化                | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ua</code> | n    | 切换动画                      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uc</code> | n    | 切换文本隐藏（记住选择）      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ud</code> | n    | 切换诊断（记住选择）          | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uf</code> | n    | 切换自动格式化（记住选择）    | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ug</code> | n    | 切换缩进引导线                | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uh</code> | n    | 切换行内提示（记住选择）      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ui</code> | n    | 检查光标处高亮与语法          | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ul</code> | n    | 切换行号                      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;un</code> | n    | 清除全部通知                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ur</code> | n    | 重绘、清除搜索高亮并更新 Diff | 通用 | 运行时映射 |
| <code>&lt;leader&gt;us</code> | n    | 切换拼写检查（记住选择）      | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uw</code> | n    | 切换自动换行显示              | 通用 | 运行时映射 |
| <code>&lt;leader&gt;uz</code> | n    | 切换专注模式                  | 通用 | 运行时映射 |

## 窗口与会话

| 按键                                  | 模式 | 说明                      | 范围 | 来源       |
| ------------------------------------- | ---- | ------------------------- | ---- | ---------- |
| <code>&lt;C-W&gt;</code>              | i    | help i_CTRL-W-default     | 通用 | 运行时映射 |
| <code>&lt;C-W&gt;&lt;C-D&gt;</code>   | n    | 显示光标处诊断            | 通用 | 运行时映射 |
| <code>&lt;C-W&gt;&lt;Space&gt;</code> | n    | 连续窗口操作（Which-key） | 通用 | 运行时映射 |
| <code>&lt;C-W&gt;d</code>             | n    | 显示光标处诊断            | 通用 | 运行时映射 |
| <code>&lt;leader&gt;-</code>          | n    | 向下分屏                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;qS</code>         | n    | 选择会话                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;qd</code>         | n    | 停止保存当前会话          | 通用 | 运行时映射 |
| <code>&lt;leader&gt;ql</code>         | n    | 恢复上一次会话            | 通用 | 运行时映射 |
| <code>&lt;leader&gt;qq</code>         | n    | 退出全部窗口              | 通用 | 运行时映射 |
| <code>&lt;leader&gt;qs</code>         | n    | 恢复当前目录会话          | 通用 | 运行时映射 |
| <code>&lt;leader&gt;wM</code>         | n    | 切换窗口最大化            | 通用 | 运行时映射 |
| <code>&lt;leader&gt;wd</code>         | n    | 关闭窗口                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;wm</code>         | n    | 切换窗口最大化            | 通用 | 运行时映射 |
| <code>&lt;leader&gt;wp</code>         | n    | 选择窗口                  | 通用 | 运行时映射 |
| <code>&lt;leader&gt;&#124;</code>     | n    | 向右分屏                  | 通用 | 运行时映射 |

## 移动与编辑

| 按键                        | 模式 | 说明                           | 范围             | 来源       |
| --------------------------- | ---- | ------------------------------ | ---------------- | ---------- |
| <code>#</code>              | x    | help v\_#-default              | 通用             | 运行时映射 |
| <code>$</code>              | nx   | 最后一个非空白字符             | 通用             | 运行时映射 |
| <code>&</code>              | n    | help &-default                 | 通用             | 运行时映射 |
| <code>\*</code>             | x    | help v_star-default            | 通用             | 运行时映射 |
| <code>=P</code>             | n    | 过滤后粘贴到前方               | 通用             | 运行时映射 |
| <code>=p</code>             | n    | 过滤后粘贴到后方               | 通用             | 运行时映射 |
| <code>&gt;P</code>          | n    | 粘贴到前方并向右缩进           | 通用             | 运行时映射 |
| <code>&gt;p</code>          | n    | 粘贴并向右缩进                 | 通用             | 运行时映射 |
| <code>@</code>              | x    | help v\_@-default              | 通用             | 运行时映射 |
| <code>C</code>              | n    | 修改到行尾（保留复制内容）     | 通用             | 运行时映射 |
| <code>C</code>              | x    | 修改选中行（保留复制内容）     | 通用             | 运行时映射 |
| <code>F</code>              | nxo  | 向后查找字符                   | 通用             | 运行时映射 |
| <code>H</code>              | n    | 上一个缓冲区                   | 通用             | 运行时映射 |
| <code>K</code>              | n    | 悬浮文档                       | LSP 支持时       | LSP        |
| <code>L</code>              | n    | 下一个缓冲区                   | 通用             | 运行时映射 |
| <code>N</code>              | nxo  | 上一个搜索结果                 | 通用             | 运行时映射 |
| <code>P</code>              | n    | 粘贴到光标前                   | 通用             | 运行时映射 |
| <code>Q</code>              | x    | help v_Q-default               | 通用             | 运行时映射 |
| <code>T</code>              | nxo  | 向后查找到目标字符之后         | 通用             | 运行时映射 |
| <code>Y</code>              | n    | help Y-default                 | 通用             | 运行时映射 |
| <code>[&lt;C-L&gt;</code>   | n    | lpfile                         | 通用             | 运行时映射 |
| <code>[&lt;C-Q&gt;</code>   | n    | cpfile                         | 通用             | 运行时映射 |
| <code>[&lt;C-T&gt;</code>   | n    | ptprevious                     | 通用             | 运行时映射 |
| <code>[&lt;Space&gt;</code> | n    | 在上方添加空行                 | 通用             | 运行时映射 |
| <code>[A</code>             | n    | rewind                         | 通用             | 运行时映射 |
| <code>[B</code>             | n    | 缓冲区向前排序                 | 通用             | 运行时映射 |
| <code>[D</code>             | n    | 当前文件第一个诊断             | 通用             | 运行时映射 |
| <code>[H</code>             | n    | 第一个 Git 改动块              | Git 文件         | Git 文件   |
| <code>[L</code>             | n    | lrewind                        | 通用             | 运行时映射 |
| <code>[N</code>             | x    | 选择上一个同级语法节点         | 通用             | 运行时映射 |
| <code>[P</code>             | n    | 在上方按行粘贴并调整缩进       | 通用             | 运行时映射 |
| <code>[Q</code>             | n    | crewind                        | 通用             | 运行时映射 |
| <code>[T</code>             | n    | trewind                        | 通用             | 运行时映射 |
| <code>[[</code>             | n    | 上一个引用                     | LSP 支持时       | LSP        |
| <code>[a</code>             | n    | previous                       | 通用             | 运行时映射 |
| <code>[b</code>             | n    | 上一个缓冲区                   | 通用             | 运行时映射 |
| <code>[d</code>             | n    | 上一个诊断                     | 通用             | 运行时映射 |
| <code>[e</code>             | n    | 上一个错误                     | 通用             | 运行时映射 |
| <code>[h</code>             | n    | 上一个 Git 改动块              | Git 文件         | Git 文件   |
| <code>[l</code>             | n    | lprevious                      | 通用             | 运行时映射 |
| <code>[n</code>             | x    | 选择上一个语法节点             | 通用             | 运行时映射 |
| <code>[p</code>             | n    | 在上方按行粘贴并调整缩进       | 通用             | 运行时映射 |
| <code>[q</code>             | n    | 上一项 Trouble/Quickfix        | 通用             | 运行时映射 |
| <code>[t</code>             | n    | 上一条 TODO 注释               | 通用             | 运行时映射 |
| <code>[w</code>             | n    | 上一个警告                     | 通用             | 运行时映射 |
| <code>[y</code>             | n    | 替换为下一项复制历史           | 通用             | 运行时映射 |
| <code>\</code>              | nxo  | 跨窗口跳转（Leap）             | 通用             | 运行时映射 |
| <code>]&lt;C-L&gt;</code>   | n    | lnfile                         | 通用             | 运行时映射 |
| <code>]&lt;C-Q&gt;</code>   | n    | cnfile                         | 通用             | 运行时映射 |
| <code>]&lt;C-T&gt;</code>   | n    | ptnext                         | 通用             | 运行时映射 |
| <code>]&lt;Space&gt;</code> | n    | 在下方添加空行                 | 通用             | 运行时映射 |
| <code>]A</code>             | n    | last                           | 通用             | 运行时映射 |
| <code>]B</code>             | n    | 缓冲区向后排序                 | 通用             | 运行时映射 |
| <code>]D</code>             | n    | 当前文件最后一个诊断           | 通用             | 运行时映射 |
| <code>]H</code>             | n    | 最后一个 Git 改动块            | Git 文件         | Git 文件   |
| <code>]L</code>             | n    | llast                          | 通用             | 运行时映射 |
| <code>]N</code>             | x    | 选择下一个同级语法节点         | 通用             | 运行时映射 |
| <code>]P</code>             | n    | 在下方按行粘贴并调整缩进       | 通用             | 运行时映射 |
| <code>]Q</code>             | n    | clast                          | 通用             | 运行时映射 |
| <code>]T</code>             | n    | tlast                          | 通用             | 运行时映射 |
| <code>]]</code>             | n    | 下一个引用                     | LSP 支持时       | LSP        |
| <code>]a</code>             | n    | 下一个                         | 通用             | 运行时映射 |
| <code>]b</code>             | n    | 下一个缓冲区                   | 通用             | 运行时映射 |
| <code>]d</code>             | n    | 下一个诊断                     | 通用             | 运行时映射 |
| <code>]e</code>             | n    | 下一个错误                     | 通用             | 运行时映射 |
| <code>]h</code>             | n    | 下一个 Git 改动块              | Git 文件         | Git 文件   |
| <code>]l</code>             | n    | lnext                          | 通用             | 运行时映射 |
| <code>]n</code>             | x    | 选择下一个语法节点             | 通用             | 运行时映射 |
| <code>]p</code>             | n    | 在下方按行粘贴并调整缩进       | 通用             | 运行时映射 |
| <code>]q</code>             | n    | 下一项 Trouble/Quickfix        | 通用             | 运行时映射 |
| <code>]t</code>             | n    | 下一条 TODO 注释               | 通用             | 运行时映射 |
| <code>]w</code>             | n    | 下一个警告                     | 通用             | 运行时映射 |
| <code>]y</code>             | n    | 替换为上一项复制历史           | 通用             | 运行时映射 |
| <code>an</code>             | xo   | 选择外层语法节点               | 通用             | 运行时映射 |
| <code>aw</code>             | xo   | 词语及周围空白（中文分词）     | 中文分词文件类型 | jieba.vim  |
| <code>b</code>              | nxo  | 上一个词首（中文分词）         | 中文分词文件类型 | jieba.vim  |
| <code>c</code>              | nx   | 修改文本（保留复制内容）       | 通用             | 运行时映射 |
| <code>e</code>              | nxo  | 下一个词尾（中文分词）         | 中文分词文件类型 | jieba.vim  |
| <code>f</code>              | nxo  | 向前查找字符                   | 通用             | 运行时映射 |
| <code>gD</code>             | n    | 跳转到声明                     | LSP 支持时       | LSP        |
| <code>gI</code>             | n    | 跳转到实现                     | LSP 支持时       | LSP        |
| <code>gK</code>             | n    | 函数签名帮助                   | LSP 支持时       | LSP        |
| <code>gO</code>             | n    | 文件符号                       | 通用             | 运行时映射 |
| <code>gP</code>             | nx   | 粘贴到选区前                   | 通用             | 运行时映射 |
| <code>g\_</code>            | nx   | 行尾（含尾随空白）             | 通用             | 运行时映射 |
| <code>gc</code>             | nx   | 切换注释                       | 通用             | 运行时映射 |
| <code>gc</code>             | o    | 注释文本对象                   | 通用             | 运行时映射 |
| <code>gcO</code>            | n    | 在上方添加注释                 | 通用             | 运行时映射 |
| <code>gcc</code>            | n    | 切换当前行注释                 | 通用             | 运行时映射 |
| <code>gco</code>            | n    | 在下方添加注释                 | 通用             | 运行时映射 |
| <code>gd</code>             | n    | 跳转到定义                     | LSP 支持时       | LSP        |
| <code>ge</code>             | nxo  | 上一个词尾（中文分词）         | 中文分词文件类型 | jieba.vim  |
| <code>gp</code>             | nx   | 粘贴到选区后                   | 通用             | 运行时映射 |
| <code>gr</code>             | n    | 查找引用                       | LSP 支持时       | LSP        |
| <code>gra</code>            | nx   | 代码操作                       | 通用             | 运行时映射 |
| <code>gri</code>            | n    | 跳转到实现                     | 通用             | 运行时映射 |
| <code>grn</code>            | n    | 重命名符号                     | 通用             | 运行时映射 |
| <code>grr</code>            | n    | 查找引用                       | 通用             | 运行时映射 |
| <code>grt</code>            | n    | 跳转到类型定义                 | 通用             | 运行时映射 |
| <code>grx</code>            | n    | 执行 CodeLens                  | 通用             | 运行时映射 |
| <code>gx</code>             | nx   | 用系统应用打开光标处路径或链接 | 通用             | 运行时映射 |
| <code>gy</code>             | n    | 跳转到类型定义                 | LSP 支持时       | LSP        |
| <code>gzF</code>            | nxo  | 查找左侧包围符号               | 通用             | 运行时映射 |
| <code>gzFl</code>           | nxo  | 查找上一个左侧包围符号         | 通用             | 运行时映射 |
| <code>gzFn</code>           | nxo  | 查找下一个左侧包围符号         | 通用             | 运行时映射 |
| <code>gza</code>            | n    | 添加包围符号                   | 通用             | 运行时映射 |
| <code>gza</code>            | x    | 给选区添加包围符号             | 通用             | 运行时映射 |
| <code>gzd</code>            | n    | 删除包围符号                   | 通用             | 运行时映射 |
| <code>gzdl</code>           | n    | 删除上一个包围符号             | 通用             | 运行时映射 |
| <code>gzdn</code>           | n    | 删除下一个包围符号             | 通用             | 运行时映射 |
| <code>gzf</code>            | nxo  | 查找右侧包围符号               | 通用             | 运行时映射 |
| <code>gzfl</code>           | nxo  | 查找上一个右侧包围符号         | 通用             | 运行时映射 |
| <code>gzfn</code>           | nxo  | 查找下一个右侧包围符号         | 通用             | 运行时映射 |
| <code>gzh</code>            | n    | 高亮包围符号                   | 通用             | 运行时映射 |
| <code>gzhl</code>           | n    | 高亮上一个包围符号             | 通用             | 运行时映射 |
| <code>gzhn</code>           | n    | 高亮下一个包围符号             | 通用             | 运行时映射 |
| <code>gzr</code>            | n    | 替换包围符号                   | 通用             | 运行时映射 |
| <code>gzrl</code>           | n    | 替换上一个包围符号             | 通用             | 运行时映射 |
| <code>gzrn</code>           | n    | 替换下一个包围符号             | 通用             | 运行时映射 |
| <code>ih</code>             | xo   | 选择 Git 改动块                | Git 文件         | Git 文件   |
| <code>in</code>             | xo   | 选择内部语法节点               | 通用             | 运行时映射 |
| <code>iw</code>             | xo   | 词语内部（中文分词）           | 中文分词文件类型 | jieba.vim  |
| <code>n</code>              | nxo  | 下一个搜索结果                 | 通用             | 运行时映射 |
| <code>p</code>              | n    | 粘贴到光标后                   | 通用             | 运行时映射 |
| <code>p</code>              | x    | 替换选区（保留复制内容）       | 通用             | 运行时映射 |
| <code>t</code>              | nxo  | 向前查找到目标字符之前         | 通用             | 运行时映射 |
| <code>w</code>              | nxo  | 下一个词首（中文分词）         | 中文分词文件类型 | jieba.vim  |
| <code>y</code>              | nx   | 复制文本                       | 通用             | 运行时映射 |
| <code>zK</code>             | n    | 预览折叠内容或悬浮文档         | 通用             | 运行时映射 |
| <code>zM</code>             | n    | 关闭全部折叠                   | 通用             | 运行时映射 |
| <code>zR</code>             | n    | 展开全部折叠                   | 通用             | 运行时映射 |

## 其他组合键

| 按键                         | 模式 | 说明                               | 范围       | 来源       |
| ---------------------------- | ---- | ---------------------------------- | ---------- | ---------- |
| <code>&lt;C-/&gt;</code>     | nt   | 终端（项目根目录）                 | 通用       | 运行时映射 |
| <code>&lt;C-B&gt;</code>     | nsi  | 向上滚动                           | 通用       | 运行时映射 |
| <code>&lt;C-F&gt;</code>     | nsi  | 向下滚动                           | 通用       | 运行时映射 |
| <code>&lt;C-H&gt;</code>     | n    | 切换到左侧窗口                     | 通用       | 运行时映射 |
| <code>&lt;C-K&gt;</code>     | i    | 函数签名帮助                       | LSP 支持时 | LSP        |
| <code>&lt;C-K&gt;</code>     | n    | 切换到上方窗口                     | 通用       | 运行时映射 |
| <code>&lt;C-L&gt;</code>     | n    | 切换到右侧窗口                     | 通用       | 运行时映射 |
| <code>&lt;C-S&gt;</code>     | nxsi | 保存文件                           | 通用       | 运行时映射 |
| <code>&lt;C-U&gt;</code>     | i    | help i_CTRL-U-default              | 通用       | 运行时映射 |
| <code>&lt;Down&gt;</code>    | nx   | 向下移动                           | 通用       | 运行时映射 |
| <code>&lt;Esc&gt;</code>     | nsi  | 退出并清除搜索高亮                 | 通用       | 运行时映射 |
| <code>&lt;M-j&gt;</code>     | nxsi | 向下移动当前行或选区               | 通用       | 运行时映射 |
| <code>&lt;M-k&gt;</code>     | nxsi | 向上移动当前行或选区               | 通用       | 运行时映射 |
| <code>&lt;M-n&gt;</code>     | n    | 下一个引用                         | LSP 支持时 | LSP        |
| <code>&lt;M-p&gt;</code>     | n    | 上一个引用                         | LSP 支持时 | LSP        |
| <code>&lt;NL&gt;</code>      | n    | 切换到下方窗口                     | 通用       | 运行时映射 |
| <code>&lt;S-CR&gt;</code>    | c    | 将命令输出显示为消息               | 通用       | 运行时映射 |
| <code>&lt;S-Tab&gt;</code>   | si   | 片段上一位置，否则使用 Shift-Tab   | 通用       | 运行时映射 |
| <code>&lt;Tab&gt;</code>     | si   | 片段下一位置，否则使用 Tab         | 通用       | 运行时映射 |
| <code>&lt;Up&gt;</code>      | nx   | 向上移动                           | 通用       | 运行时映射 |
| <code>&lt;leader&gt;.</code> | n    | 切换临时缓冲区                     | 通用       | 运行时映射 |
| <code>&lt;leader&gt;:</code> | n    | 命令历史                           | 通用       | 运行时映射 |
| <code>&lt;leader&gt;?</code> | n    | 当前缓冲区键位（Which-key）        | 通用       | 运行时映射 |
| <code>&lt;leader&gt;E</code> | n    | 文件树（Neo-tree）（当前工作目录） | 通用       | 运行时映射 |
| <code>&lt;leader&gt;K</code> | n    | 使用关键字查询程序                 | 通用       | 运行时映射 |
| <code>&lt;leader&gt;L</code> | n    | LazyVim 更新记录                   | 通用       | 运行时映射 |
| <code>&lt;leader&gt;S</code> | n    | 选择临时缓冲区                     | 通用       | 运行时映射 |
| <code>&lt;leader&gt;e</code> | n    | 文件树（Neo-tree）（项目根目录）   | 通用       | 运行时映射 |
| <code>&lt;leader&gt;l</code> | n    | 插件管理（Lazy）                   | 通用       | 运行时映射 |
| <code>&lt;leader&gt;n</code> | n    | 通知历史                           | 通用       | 运行时映射 |
| <code>&lt;leader&gt;p</code> | nx   | 打开复制历史                       | 通用       | 运行时映射 |
| <code>&lt;lt&gt;P</code>     | n    | 粘贴到前方并向左缩进               | 通用       | 运行时映射 |
| <code>&lt;lt&gt;p</code>     | n    | 粘贴并向左缩进                     | 通用       | 运行时映射 |

## 插件临时界面与没有 desc 的继承映射

这些不是统一的全局快捷键，执行动作由对应插件管理。

| 场景             | 按键                                | 当前行为                                                                     |
| ---------------- | ----------------------------------- | ---------------------------------------------------------------------------- |
| 补全菜单         | `Tab` / `Shift-Tab`                 | 下一项 / 上一项；`Enter` 确认                                                |
| 填写片段         | `Tab` / `Shift-Tab`                 | 下一填写位置 / 上一填写位置；支持嵌套后回到外层                              |
| 片段中需要补全   | `Ctrl-Space`                        | 手动打开菜单，再用 Tab 选择、Enter 确认                                      |
| 补全             | `Ctrl-e`                            | 取消补全；`Ctrl-b` / `Ctrl-f` 滚动文档                                       |
| 补全             | 方向键、`Ctrl-n` / `Ctrl-p`         | 回退给原生/其他映射，不通过 Blink 选候选                                     |
| Neo-tree         | `v` / `s`                           | 选择目标窗口后垂直分屏 / 水平分屏                                            |
| Neo-tree         | `Enter`                             | 现有 `<CR>` 与默认 `<cr>` 重复，可能直接打开或调用窗口选择器，见下方待决定项 |
| Neo-tree         | `S`                                 | 当前禁用                                                                     |
| Neo-tree         | `?`                                 | 查看文件树完整局部键位                                                       |
| UFO 预览         | `Ctrl-Up` / `Ctrl-Down`             | 向上 / 向下滚动预览                                                          |
| Avante 输入框    | 普通模式 `Enter`、插入模式 `Ctrl-s` | 发送请求；这里的 Ctrl-s 不是保存文件                                         |
| Avante 侧栏      | `q`                                 | 关闭侧栏                                                                     |
| Avante 结果区    | `a` / `A`                           | 应用当前代码块 / 全部代码块                                                  |
| Avante 侧栏      | `Tab` / `Shift-Tab`                 | 切换窗口；Shift-Tab 在工具调用区域也用于展开详情                             |
| Avante 侧栏      | `]p` / `[p`                         | 下一个 / 上一个提示词                                                        |
| Avante 文件列表  | `@` / `d`                           | 添加 / 移除上下文文件                                                        |
| Avante 冲突      | `co` / `ct` / `cb` / `ca` / `cc`    | 原代码 / AI 代码 / 两侧 / 全部 AI 代码 / 光标所在一侧                        |
| Avante 冲突      | `]x` / `[x`                         | 下一个 / 上一个冲突                                                          |
| fzf 终端         | `Ctrl-j` / `Ctrl-k`                 | 按原键传给 fzf，由选择器处理                                                 |
| 可视模式         | `<` / `>`                           | 缩进后保留选区                                                               |
| 插入模式         | `,` / `.` / `;`                     | 插入标点并划分撤销步骤                                                       |
| matchit          | `%` / `g%` / `[%` / `]%`            | 匹配结构跳转、反向跳转、前/后结构边界                                        |
| matchit 可视模式 | `a%`                                | 选择匹配结构                                                                 |

中文分词的具体文件类型见 [jieba.lua](../lua/config/languages/jieba.lua)。
Obsidian 没有在本地配置额外分配一套全局键位；进入笔记库后还会启用它的局部默认行为。
Neogit、DAP、Telescope 等界面也有插件自己的局部帮助；此次未重写这些界面的内部按键布局。

## 待决定的调整意见

1. Neo-tree 的 `<CR>` 与默认 `<cr>` 同时存在，最终都绑定 Enter；测试中默认 `open` 覆盖了窗口选择器。
   建议统一为默认小写 `<cr>` 并指定 `open_with_window_picker`。本轮只补说明，尚未处理这个动作冲突。
2. `<leader>wm`、`<leader>wM`、`<leader>uZ` 都切换窗口最大化。
   建议以后保留 `wm` 为常用入口；`wM` 是之前明确保留的别名，本轮不删。
3. `<leader>gn` 打开 Neogit；有 Lazygit 可执行文件时，`gg` / `gG` 打开 Lazygit。
   两者不是按键冲突，可以以后按使用习惯决定是否只保留一个入口。
4. Avante 上游的提问和编辑映射使用 `v`，因此也覆盖 Select 模式。
   如果希望片段占位符内完全不响应 AI 快捷键，可另行调整成 `x`；本轮保持现状。
5. `Ctrl-s` 在普通代码中保存文件，在 Avante 输入框中发送请求。这是局部覆盖；
   若经常误发送，再讨论换提交键，不直接改变现有习惯。

当前 mini.surround 实际使用 `gz` 前缀，如 `gzaiw"` 给词语加双引号。
这是 Leap Extra 对基础 `gs` 配置的覆盖；分组以最终生效的 `gz` 为准。
