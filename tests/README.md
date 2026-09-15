# 升级兼容性检查

`compat/` 存放随插件升级持续维护的兼容性测试。

只保留依赖上游行为的适配检查，不为普通选项、配色清单、界面布局逐项写断言。
测试使用本机已安装的插件，不验证真实 AI 回复或整个编辑器的所有功能。
只在对应插件升级后运行；保留真实插件接口、跨插件调用和关键结果检查。
不保留固定文案、配色、默认选项、文件类型清单及纯本地逻辑的模拟测试。

| 测试                    | 更新哪些插件后运行              | 保护的行为                                                                |
| ----------------------- | ------------------------------- | ------------------------------------------------------------------------- |
| `compat/jieba_surround.lua`    | jieba.vim、mini.surround、Leap  | 中文 `iw/aw` 的范围、重复操作、操作符接线                                 |
| `compat/csv_view.lua` | csvview.nvim | CSV/TSV 自动附着、字段导航、带引号和多行数据渲染后原文不变 |
| `compat/zsh_lint.lua` | nvim-lint、Zsh | libuv stdin 接线、未保存内容的语法诊断和修正后清理；需要 PATH 中有 Zsh |
| `compat/ufo_provider.lua`      | nvim-ufo、promise-async         | 真实 UFO / Promise 接口、无 LSP 和解析器时返回空折叠 |
| `compat/avante_completion.lua` | Avante、blink-cmp-avante、Blink | 原生模块能加载，候选接口和侧栏动作回调仍兼容                              |
| `compat/avante_preferences.lua` | Avante | config.override、选模保存回调、toggle 接口及重启恢复 |
| `compat/git_history.lua` | Snacks picker、Git 历史适配 | 文件/行历史对比、改名前路径、未保存内容、只读快照与工作区不变 |
| `compat/luasnip_nesting.lua`   | LuaSnip、Blink                  | 嵌套片段前后跳转，并返回外层填写位置                                      |
| `compat/neotree_window_picker.lua` | Neo-tree、nvim-window-picker、Trouble、Snacks | Enter 映射无冲突、多窗口选择、启动页复用、无目标时新建，以及保留功能面板 |

在仓库根目录运行。下面使用现有 `nvim-test` 插件目录；第二组还要求
`~/.config/nvim-test` 指向本仓库。测试状态和缓存使用临时目录。
第二组启动完整配置，沿用其插件加载策略，运行前应已安装所需插件。

```sh
NVIM_TEST_PLUGIN_ROOT="${XDG_DATA_HOME:-$HOME/.local/share}/nvim-test/lazy"
export NVIM_TEST_PLUGIN_ROOT

for test in jieba_surround ufo_provider csv_view zsh_lint; do
    test_tmp=$(mktemp -d)
    XDG_DATA_HOME="$test_tmp/data" XDG_STATE_HOME="$test_tmp/state" \
        XDG_CACHE_HOME="$test_tmp/cache" \
        nvim --headless -u NONE -i NONE -l "tests/compat/$test.lua" || break
done

for test in avante_completion luasnip_nesting neotree_window_picker git_history; do
    test_tmp=$(mktemp -d)
    NVIM_APPNAME=nvim-test XDG_STATE_HOME="$test_tmp/state" \
        XDG_CACHE_HOME="$test_tmp/cache" NVIM_TEST_FILE="tests/compat/$test.lua" \
        nvim --headless -i NONE \
        '+lua local ok, err = xpcall(function() dofile(vim.env.NVIM_TEST_FILE) end, debug.traceback); if not ok then print(err); vim.cmd("cquit") end' || break
done
```

缺少插件或 Avante 原生库会直接失败，应先修复依赖再重跑；不将缺依赖视作通过。

模型偏好测试分两次启动，共用一份临时状态目录；不发送模型请求：

```sh
test_tmp=$(mktemp -d)
for phase in write read; do
    NVIM_APPNAME=nvim-test NVIM_TEST_PHASE="$phase" \
        XDG_STATE_HOME="$test_tmp/state" XDG_CACHE_HOME="$test_tmp/cache" \
        nvim --headless -i NONE \
        '+lua local ok, err = xpcall(function() dofile("tests/compat/avante_preferences.lua") end, debug.traceback); if not ok then print(err); vim.cmd("cquit") end' || break
done
```
