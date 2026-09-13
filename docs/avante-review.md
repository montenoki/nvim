# Avante 配置检查

## 当前配置（2026-09-13）

已统一为 Snacks 选择器与输入框，以及 Blink 补全；以下旧检查记录作为历史保留。

- 删除重复的 `instructions_file` 声明，继续使用默认 `avante.md`。
- OpenRouter 模型及采样参数保留，超时改为 120000 毫秒。
- 移除 Avante 对 mini.pick、Telescope、fzf-lua、Dressing、nvim-cmp 的声明。
  Telescope 依赖移到仍使用它的 Obsidian；fzf-lua 仍由 LazyVim 管理。
- 使用 `Kaiser-Yang/blink-cmp-avante`：未归档，最新提交为 2025-07-24 的
  `4f494c6e124acbe31a8f5d58effa0c14aa38a6d5`，更新较少，已固定版本并做兼容测试。
  补全仅在 `AvanteInput` 和 `AvantePromptInput` 生效；后者只提供基础 @ 引用。
  聊天引用使用当前 Avante 的列表和侧栏回调，保留 @file 的选择器动作。
- 图片绝对路径仅用于 `AvanteInput`；普通 Markdown 使用相对路径。
- 保留图片粘贴和 Markdown 渲染，移除冗余图标加载配置及英文示例注释。

验证：`tests/avante_completion.lua` 检查四个原生模块、Blink 的 /、@、# 候选和
@file 接受动作，不发送模型请求。
此前侧栏、Snacks 输入框和选择器的一次性验收脚本已清理；未验证真实回复和图片上传。

检查日期：2026-09-12。以下初次检查以当时锁定的 Avante 提交
`1a36a37b1a96c9acbbc863205c3b0e2c5b2f1e18` 的源码为准。

| 检查项       | 结论                                                                                                                                                                            |
| ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 模型名称     | 原来的 `anthropic/claude-4.5-sonnet` 顺序错误，已改为 `anthropic/claude-sonnet-4.5`。                                                                                           |
| Provider     | `provider = "openrouter"` 配合 `__inherited_from = "openai"` 是有效的自定义 Provider 配置。                                                                                     |
| API 地址     | `https://openrouter.ai/api/v1` 正确；插件会拼接 Chat Completions 路径，无需自行追加。                                                                                           |
| API 密钥     | `api_key_name = "OPENROUTER_API_KEY"` 正确。检查进程中未设置该变量；运行 Neovim 的终端需要提供密钥。其他终端是否设置未验证。                                                    |
| 请求参数     | `temperature` 和 `max_tokens` 放在 `extra_request_body` 内正确。已验证合并后的请求保留 `max_tokens = 20480`，移除继承的 `max_completion_tokens` 和不适用的 `reasoning_effort`。 |
| 指令文件     | `instructions_file = "avante.md"` 有效，也是默认值。项目指令应放在对应项目根目录。                                                                                              |
| 构建配置     | Windows 的 `Build.ps1` 和其他平台的 `make` 与上游示例一致；`make` 默认获取预编译库，不代表一定从源码构建。                                                                      |
| 本地构建状态 | 在干净的 headless Neovim 中，已安装插件的 `avante_templates`、`avante_tokenizers` 原生模块均无法加载。配置语法正确不等于原生组件已准备好。                                      |
| 超时         | `30000` 毫秒有效，但长输出可能超时。若实际出现超时，可提高到 `120000` 或更高；本次保留原值。                                                                                    |
| 可选依赖     | 同时声明 mini.pick、Telescope、fzf-lua、Dressing、Snacks，以及 nvim-cmp、Copilot，属于上游示例中的多个可选集成，不是 OpenRouter 的全部必需项。                                  |

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

## 构建失败复查（2026-09-12）

`Local build is out of date . Downloading latest v0.1.2.` 后立即出现
`Makefile:52: luajit` 错误，是下载地址解析失败。当前锁定版本的 `build.sh`
默认访问 `yetone/avante.nvim`，其实测 release API 返回 HTTP 301；脚本使用
`curl -s`，没有跟随重定向，响应中没有 `browser_download_url`，最终因
`grep` 返回 1 和 `set -e` 而退出。

插件仓库已改为 `avante-corp/avante.nvim`，构建入口保持上游的 `make`。
锁定版本同步更新至 `94afb841a9748f9c2cf38652879dd9f8a3e43a91`：
该提交的 `build.sh` 默认使用新仓库，直接构造 release 下载地址，已不再调用
旧 release API。仅修改插件仓库地址不会替换旧锁定版本中的构建脚本。
新仓库 API 请求成功，且 Linux x86_64 LuaJIT 的 v0.1.2 压缩包已在临时目录
完成下载、解压验证。新锁定提交的构建脚本通过 `bash -n`；配置加载与
仓库、构建命令和锁定版本断言、`git diff --check` 均通过。

当前 NixOS 上用干净的 headless Neovim 加载该预编译包，`avante_templates`、
`avante_repo_map`、`avante_html2md` 均成功；`avante_tokenizers` 因找不到
`libstdc++.so.6` 失败。复查发现系统已通过 `nix-ld` 提供该运行库，但 Nix 打包的
Neovim 不会自动使用 `NIX_LD_LIBRARY_PATH`。已在相邻 NixOS 仓库的
`home/cli/editor.nix` 中增加 `extraWrapperArgs`，通过 `LD_LIBRARY_PATH`
为 Neovim 提供 `lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ]`。
使用完整配置求值得到的运行库路径复测，四个原生模块均加载成功。
T14 的 `programs.neovim.finalPackage` 构建通过；清除外部 `LD_LIBRARY_PATH`
后直接运行新包，四个原生模块仍全部加载成功，确认 wrapper 修复生效。
尚未部署系统或改写已安装插件；部署本次配置后先执行
`:Lazy restore avante.nvim` 同步锁定版本，
如需重新构建再执行 `:Lazy build avante.nvim`。尚未完成新版插件运行验证。

用户 rebuild 后复查：已安装 Avante 为 `94afb841a9748f9c2cf38652879dd9f8a3e43a91`。
使用当前 PATH 中的 Neovim 直接加载已安装插件，四个原生模块全部成功；
`avante_tokenizers.from_pretrained("gpt-4o")` 与 `encode("Hello world")`
成功返回 2 个 token，未再出现 `libstdc++.so.6` 错误。
此次进程内 `LD_LIBRARY_PATH` 未设置，Neovim 包路径也仍为此前版本，
因此可以确认当前已安装插件可用，但不能据此认定前述 wrapper 修改已经部署。
未测试实际模型请求。

参考：

- [OpenRouter 的 Claude Sonnet 4.5 模型标识](https://openrouter.ai/anthropic/claude-sonnet-4.5)
- [Avante 安装与配置说明](https://github.com/avante-corp/avante.nvim)
- [当前锁定版本的 Provider 实现](https://github.com/avante-corp/avante.nvim/blob/1a36a37b1a96c9acbbc863205c3b0e2c5b2f1e18/lua/avante/providers/openai.lua)
