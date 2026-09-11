# Avante 配置检查

检查日期：2026-09-12。以本项目锁定的 Avante 提交
`1a36a37b1a96c9acbbc863205c3b0e2c5b2f1e18` 的源码为准。

| 检查项 | 结论 |
| --- | --- |
| 模型名称 | 原来的 `anthropic/claude-4.5-sonnet` 顺序错误，已改为 `anthropic/claude-sonnet-4.5`。 |
| Provider | `provider = "openrouter"` 配合 `__inherited_from = "openai"` 是有效的自定义 Provider 配置。 |
| API 地址 | `https://openrouter.ai/api/v1` 正确；插件会拼接 Chat Completions 路径，无需自行追加。 |
| API 密钥 | `api_key_name = "OPENROUTER_API_KEY"` 正确。检查进程中未设置该变量；运行 Neovim 的终端需要提供密钥。其他终端是否设置未验证。 |
| 请求参数 | `temperature` 和 `max_tokens` 放在 `extra_request_body` 内正确。已验证合并后的请求保留 `max_tokens = 20480`，移除继承的 `max_completion_tokens` 和不适用的 `reasoning_effort`。 |
| 指令文件 | `instructions_file = "avante.md"` 有效，也是默认值。项目指令应放在对应项目根目录。 |
| 构建配置 | Windows 的 `Build.ps1` 和其他平台的 `make` 与上游示例一致；`make` 默认获取预编译库，不代表一定从源码构建。 |
| 本地构建状态 | 在干净的 headless Neovim 中，已安装插件的 `avante_templates`、`avante_tokenizers` 原生模块均无法加载。配置语法正确不等于原生组件已准备好。 |
| 超时 | `30000` 毫秒有效，但长输出可能超时。若实际出现超时，可提高到 `120000` 或更高；本次保留原值。 |
| 可选依赖 | 同时声明 mini.pick、Telescope、fzf-lua、Dressing、Snacks，以及 nvim-cmp、Copilot，属于上游示例中的多个可选集成，不是 OpenRouter 的全部必需项。 |

已修复确定的模型名称错误。其余配置保持原有选择。

当前选择器和输入框沿用 Avante 的 `native` 默认值，因此安装全部可选选择器不会自动启用它们。
`copilot.lua` 也不会因为出现在依赖列表中就成为当前模型 Provider。
使用 LazyVim 的 `blink.cmp` 时，Avante 的可选 `nvim-cmp` 集成不会自动转换成 Blink 集成。
这些属于可精简的配置，不是本次模型请求失败的确定原因。

下一步运行准备：在启动 Neovim 的环境中设置 `OPENROUTER_API_KEY`，并用
`:Lazy build avante.nvim` 构建原生模块。如果 NixOS 上的预编译库无法加载，需要查看
构建日志和动态链接错误，选择 Nix 提供的 Avante 包或配置相应的源码构建环境。
本次没有运行付费模型请求，也没有验证真实流式回复、工具调用及图片输入。

验证：通过本地 Avante 源码加载配置，检查有效 Provider、请求体字段与 API 模式；
只检查密钥是否存在，不输出密钥内容。

参考：

- [OpenRouter 的 Claude Sonnet 4.5 模型标识](https://openrouter.ai/anthropic/claude-sonnet-4.5)
- [Avante 安装与配置说明](https://github.com/avante-corp/avante.nvim)
- [当前锁定版本的 Provider 实现](https://github.com/avante-corp/avante.nvim/blob/1a36a37b1a96c9acbbc863205c3b0e2c5b2f1e18/lua/avante/providers/openai.lua)
